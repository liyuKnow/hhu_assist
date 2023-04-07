import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hhu_assist/src/controller/haversine.dart';
import 'package:hhu_assist/src/controller/permissions_controller.dart';
import 'package:hhu_assist/src/data/models/model.dart';
import 'package:hhu_assist/main.dart';
import 'package:location/location.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QRScreen extends StatefulWidget {
  const QRScreen({super.key});

  @override
  State<QRScreen> createState() => _QRScreenState();
}

class _QRScreenState extends State<QRScreen> {
  final qrkey = GlobalKey(debugLabel: 'QR');
  var flashOn = false;

  QRViewController? controller;
  Barcode? barcode;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  void reassemble() async {
    super.reassemble();

    if (Platform.isAndroid) {
      await controller!.pauseCamera();
    }

    controller!.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Scan a QR Code"),
        centerTitle: true,
      ),
      body: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          buildQrView(context),
          Positioned(
            bottom: 10,
            child: checkMeterId(),
          ),
          Positioned(
            top: 10,
            child: buildControlButtons(),
          ),
        ],
      ),
    );
  }

  Widget buildQrView(BuildContext context) => QRView(
        key: qrkey,
        onQRViewCreated: onQRViewCreated,
        overlay: QrScannerOverlayShape(
          cutOutSize: MediaQuery.of(context).size.width * 0.8,
          borderRadius: 10,
          borderWidth: 10,
          borderLength: 20,
          borderColor: Colors.blue,
        ),
      );

  void onQRViewCreated(QRViewController controller) {
    setState(() => this.controller = controller);

    controller.scannedDataStream.listen(
      (barcode) => setState(() {
        this.barcode = barcode;
      }),
    );
  }

  // ^ Make this a function and show error or proceed to edit page based on barcode state
  checkMeterId() {
    if (barcode != null) {
      //  check if barcode is valid id or throw error
      try {
        var customerId = barcode!.code.toString();

        Reading? reading = objectbox.getReadingByCustomerId(customerId);

        if (reading != null) {
          //   bool hasHistory = false;
          //   bool isInAllowedDistance = false;

          //   LocationHistory? locationHistory =
          //       await objectbox.getLocationHistory(customerId);

          //   if (locationHistory != null) {
          //     hasHistory = true;
          //     // get current location data
          //     PermissionController.requestLocation();

          //     var location = Location();
          //     final loc = await location.getLocation();

          //     var distance = Haversine.haversine(
          //       locationHistory.lat,
          //       locationHistory.long,
          //       loc.latitude,
          //       loc.longitude,
          //     );

          //     isInAllowedDistance = (distance < 50) ? true : false;
          //   }

          EditScreenArguments args = EditScreenArguments(
            "2001320409",
            false,
            false,
          );
          Navigator.pushNamed(context, '/edit_reading', arguments: args);
        } else {
          print("Reading didnt match error");
          // const snackBar = SnackBar(
          //   content: Text(
          //     "The scanned customer id does not match any reading record",
          //   ),
          // );
          // ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      } catch (e) {
        print("Error : ${e.toString()}");
        // var snackBar = SnackBar(
        //   content: Text(
        //     "Error : ${e.toString()}",
        //   ),
        // );
        // ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    }
    return Row();
  }

  Widget buildResult() => Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.white24,
        ),
        child: Text(
          barcode != null ? 'Result : ${barcode!.code}' : 'scan a code!',
          maxLines: 3,
        ),
      );

  Widget buildControlButtons() => Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.white24,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            IconButton(
              onPressed: () async {
                await controller?.toggleFlash();
                setState(() {
                  flashOn = !flashOn;
                });
              },
              icon: flashOn
                  ? const Icon(Icons.flash_on)
                  : const Icon(Icons.flash_off),
            ),
          ],
        ),
      );
}
