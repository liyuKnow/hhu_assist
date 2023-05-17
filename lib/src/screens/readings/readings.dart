import 'dart:io';
import 'package:flutter/material.dart';
import 'package:quickalert/quickalert.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart' as XLSIO;
import 'package:spreadsheet_decoder/spreadsheet_decoder.dart';
import 'package:intl/intl.dart';

import 'package:hhu_assist/src/controller/permissions_controller.dart';
import 'package:hhu_assist/src/screens/readings/reading_card.dart';
import 'package:hhu_assist/main.dart';
import 'package:hhu_assist/src/data/models/model.dart';

enum MenuItems { import, export, sync }

class ReadingsScreen extends StatefulWidget {
  const ReadingsScreen({super.key});

  @override
  State<ReadingsScreen> createState() => _ReadingsScreenState();
}

class _ReadingsScreenState extends State<ReadingsScreen> {
  late Stream<List<Reading>> readings = objectbox.getReadings();
  @override
  void initState() {
    PermissionController.onStartUpPermission();
    super.initState();
  }

  ReadingCard Function(BuildContext, int) _itemBuilder(List<Reading> reading) =>
      (BuildContext context, int index) => ReadingCard(reading: reading[index]);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Readings"),
        centerTitle: true,
        actions: [
          popupActions(),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(vertical: 15),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  hintText: "Search by customer id, device id ",
                  prefixIcon: const Icon(Icons.search)),
              onChanged: (value) {
                _search(value);
              },
            ),
          ),
          Expanded(
            child: StreamBuilder<List<Reading>>(
              stream: readings,
              builder: (context, snapshot) {
                if (snapshot.data?.isNotEmpty ?? false) {
                  return ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.hasData ? snapshot.data!.length : 0,
                      itemBuilder: _itemBuilder(
                        snapshot.data ?? [],
                      ));
                } else {
                  return const Center(child: Text("No records yet!"));
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  PopupMenuButton<MenuItems> popupActions() {
    return PopupMenuButton<MenuItems>(
      onSelected: (value) {
        if (value == MenuItems.import) {
          showAlert();
        } else if (value == MenuItems.export) {
          exportData();
        } else if (value == MenuItems.sync) {}
      },
      itemBuilder: ((context) => [
            PopupMenuItem(
              value: MenuItems.import,
              child: Row(
                children: const [
                  Icon(
                    Icons.download,
                    color: Colors.indigo,
                  ),
                  SizedBox(
                    width: 6,
                  ),
                  Text("Import Data"),
                ],
              ),
            ),
            PopupMenuItem(
              value: MenuItems.export,
              child: Row(
                children: const [
                  Icon(
                    Icons.upload,
                    color: Colors.indigo,
                  ),
                  SizedBox(
                    width: 6,
                  ),
                  Text("Export Data"),
                ],
              ),
            ),
            PopupMenuItem(
              value: MenuItems.sync,
              child: Row(
                children: const [
                  Icon(
                    Icons.import_export,
                    color: Colors.indigo,
                  ),
                  SizedBox(
                    width: 6,
                  ),
                  Text("Sync Data"),
                ],
              ),
            ),
          ]),
    );
  }

  loadData() async {
    try {
      // ^ CHECK PERMISSION
      PermissionController.requestManageStorage();

      // ^ GET FILE FROM DOWNLOADS
      final directory = Directory('/storage/emulated/0/Download/');
      const fileName = "reading.xlsx";

      var file = File(directory.path + fileName);

      var isFile = await file.exists();

      if (isFile) {
        // ^ SAVE IT TO A LOCAL VARIABLE
        List<String> rowDetail = [];

        var excelBytes = File(file.path).readAsBytesSync();
        var excelDecoder =
            SpreadsheetDecoder.decodeBytes(excelBytes, update: true);

        for (var table in excelDecoder.tables.keys) {
          for (var row in excelDecoder.tables[table]!.rows) {
            rowDetail.add('$row'.replaceAll('[', '').replaceAll(']', ''));
          }
        }

        insertIntoDb(rowDetail);
      } else {
        const snackBar = SnackBar(
          content: Text(
            "The file specified is not found in the device",
          ),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    } catch (e) {
      var snackBar = SnackBar(
        content: Text(
          e.toString(),
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  void showAlert() {
    QuickAlert.show(
      context: context,
      backgroundColor: Colors.red[100]!,
      text:
          "Are you sure you want to replace all the data, Any made progress will be erased!",
      type: QuickAlertType.confirm,
      onConfirmBtnTap: () => loadData(),
      autoCloseDuration: const Duration(seconds: 5),
    );
  }

  void insertIntoDb(rowDetail) {
    // Remove Previous data
    objectbox.removeReadings();
    // objectbox.removeLocationHistories();

    // DateFormat dateFormat = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS");
    // insert new data
    for (var i = 1; i < rowDetail.length; i++) {
      var data = rowDetail[i].split(',');
      // format date
      try {
        Reading reading = Reading(
          portion: data[0],
          meterReadingUnit: data[1],
          // meterReader: data[2],
          businessPartner: data[3],
          legacyAccNo: data[4],
          businessPartnerName: data[5],
          installation: data[6],
          rateCategory: data[7],
          device: data[8],
          register: int.parse(data[9]),
          scheduledMRDate: data[10],
          unitOfMeasure: data[11],
        );
        // print("Reading object created successfully: $reading");
        objectbox.putReading(reading);
      } catch (e) {
        print(e);
      }
    }

    // Navigator.pushNamed(context, '/reading');
  }

  exportData() async {
    try {
      // ^ export current database data to downloads folder
// Create a new Excel document.
      final XLSIO.Workbook workbook = XLSIO.Workbook();
//Accessing worksheet via index.
      final XLSIO.Worksheet sheet = workbook.worksheets[0];

// ADD THE HEADERS
      sheet.getRangeByName('A1').setText('Portion');
      sheet.getRangeByName('B1').setText('Meter Reading Unit');
      sheet.getRangeByName('C1').setText('Meter Reader');
      sheet.getRangeByName('D1').setText('Business Partner');
      sheet.getRangeByName('E1').setText('Lg.Acc.Num');
      sheet.getRangeByName('F1').setText('Business Partner Name');
      sheet.getRangeByName('G1').setText('Installation');
      sheet.getRangeByName('H1').setText('Rate Category');
      sheet.getRangeByName('I1').setText('Device');
      sheet.getRangeByName('J1').setText('Register');
      sheet.getRangeByName('K1').setText('Sched. MR Date');
      sheet.getRangeByName('L1').setText('Unit of Measure');
      sheet.getRangeByName('M1').setText('Meter Reading Date');
      sheet.getRangeByName('N1').setText('Meter Reading Record');
      sheet.getRangeByName('O1').setText('Meter Reading Note');

// GET ALL DATA FROM OBJECT BOX
      List<Reading> readings = objectbox.readingBox.getAll();

      var i = 2;
      for (var reading in readings) {
        sheet.getRangeByName('A$i').setText((reading.portion).toString());
        sheet
            .getRangeByName('B$i')
            .setText((reading.meterReadingUnit).toString());
        sheet.getRangeByName('C$i').setText((reading.meterReader).toString());
        sheet
            .getRangeByName('D$i')
            .setText((reading.businessPartner).toString());
        sheet.getRangeByName('E$i').setText((reading.legacyAccNo).toString());
        sheet
            .getRangeByName('F$i')
            .setText((reading.businessPartnerName).toString());
        sheet.getRangeByName('G$i').setText((reading.installation).toString());
        sheet.getRangeByName('H$i').setText((reading.rateCategory).toString());
        sheet.getRangeByName('I$i').setText((reading.device).toString());
        sheet.getRangeByName('J$i').setText((reading.register).toString());
        sheet
            .getRangeByName('K$i')
            .setText((reading.scheduledMRDate).toString());
        sheet.getRangeByName('L$i').setText((reading.unitOfMeasure).toString());
        sheet.getRangeByName('M$i').setText((reading.readingDate).toString());
        sheet.getRangeByName('N$i').setText((reading.meterReading).toString());
        sheet
            .getRangeByName('O$i')
            .setText((reading.meterReadingNote).toString());

        i += 1;
      }

      final List<int> bytes = workbook.saveAsStream();

      final directory = Directory('/storage/emulated/0/Download/');
      const fileName = "GeneratedReadings.xlsx";
      final file = File(directory.path + fileName);

      file.writeAsBytes(bytes);

      //Dispose the workbook.
      workbook.dispose();

      const snackBar = SnackBar(
        content: Text(
          "Data exported successfully",
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } catch (e) {
      var snackBar = SnackBar(
        content: Text(
          e.toString(),
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  _search(String query) async {
    setState(() {
      readings = objectbox.searchReadings(query);
    });
  }
}
