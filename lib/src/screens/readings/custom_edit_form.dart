import 'package:flutter/material.dart';
import 'package:hhu_assist/src/res/strings.dart';
import 'package:hhu_assist/src/screens/widgets/custom_dialogue.dart';
import 'package:hhu_assist/main.dart';
import 'package:hhu_assist/src/data/models/model.dart';
import 'package:hhu_assist/src/controller/haversine.dart';

class CustomEditForm extends StatefulWidget {
  final EditScreenArguments args;
  CustomEditForm({super.key, required this.args});

  @override
  State<CustomEditForm> createState() => _CustomEditFormState();
}

class _CustomEditFormState extends State<CustomEditForm> {
  final _formKey = GlobalKey<FormState>();

  String _selectedRemark = "";
  final _custIdController = TextEditingController();
  final _custName = TextEditingController();
  final _deviceId = TextEditingController();
  final _legacyAccNo = TextEditingController();
  final _meterReadingUnit = TextEditingController();
  final _currentLocation = TextEditingController();
  final _prevLocation = TextEditingController();
  final _readingRegistryOne = TextEditingController();
  final _readingRegistryTwo = TextEditingController();
  final _readingRegistryThree = TextEditingController();

  List<Reading?> readings = [];

  bool isAllowed = true;
  late double? currentLat = 0.0;
  late double? currentLong = 0.0;

  @override
  void initState() {
    super.initState();
    readings = objectbox.getReadingsByCustomerId(widget.args.customerId);
    if (readings != null) {
      _custIdController.text = readings[0]!.customerId;
      _custName.text = readings[0]!.customerName;
      _deviceId.text = readings[0]!.deviceId;
      _legacyAccNo.text = readings[0]!.customerId;
      _meterReadingUnit.text = readings[0]!.meterReadingUnit;
    }
    _currentLocation.text =
        "${widget.args.currentLat} , ${widget.args.currentLong}";
    _prevLocation.text = widget.args.previousLocation;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Enter Reading"),
      ),
      body: readingForm(context),
    );
  }

  Form readingForm(BuildContext context) {
    return Form(
      key: _formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            // Form Fields

            TextFormField(
              readOnly: true,
              controller: _custIdController,
              decoration: const InputDecoration(
                prefixIcon: Icon(
                  Icons.person,
                ),
                labelText: 'Customer Id',
              ),
            ),
            TextFormField(
              readOnly: true,
              controller: _custName,
              decoration: const InputDecoration(
                prefixIcon: Icon(
                  Icons.person,
                ),
                labelText: 'Customer Name',
              ),
            ),
            TextFormField(
              readOnly: true,
              controller: _legacyAccNo,
              decoration: const InputDecoration(
                prefixIcon: Icon(
                  Icons.book,
                ),
                labelText: 'Legacy Acc. No.',
              ),
            ),
            TextFormField(
              readOnly: true,
              controller: _meterReadingUnit,
              decoration: const InputDecoration(
                prefixIcon: Icon(
                  Icons.electric_meter_outlined,
                ),
                labelText: 'Meter Reading Unit',
              ),
            ),
            TextFormField(
              readOnly: true,
              controller: _deviceId,
              decoration: const InputDecoration(
                prefixIcon: Icon(
                  Icons.dashboard_outlined,
                ),
                labelText: 'Device Id',
              ),
            ),
            Container(
              color: widget.args.isInAllowedDistance
                  ? Color.fromARGB(255, 113, 230, 138)
                  : Color.fromARGB(255, 240, 132, 132),
              child: TextFormField(
                // enabled: false,
                readOnly: true,
                controller: _currentLocation,
                decoration: const InputDecoration(
                  prefixIcon: Icon(
                    Icons.location_pin,
                  ),
                  labelText: 'Current Location',
                ),
              ),
            ),
            TextFormField(
              readOnly: true,
              controller: _prevLocation,
              decoration: const InputDecoration(
                prefixIcon: Icon(
                  Icons.location_searching,
                ),
                labelText: 'Previous Location',
              ),
            ),
            TextFormField(
              readOnly: widget.args.isInAllowedDistance ? false : true,
              controller: _readingRegistryOne,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                prefixIcon: Icon(
                  Icons.person,
                ),
                labelText: 'Reading Registry One',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Reading entry can not be empty';
                }
                return null;
              },
            ),

            if (readings.length == 3)
              Column(
                children: [
                  TextFormField(
                    controller: _readingRegistryTwo,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(
                        Icons.track_changes_outlined,
                      ),
                      labelText: 'Reading registry two',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your name';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _readingRegistryThree,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(
                        Icons.person,
                      ),
                      labelText: 'Reading registry three',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your name';
                      }
                      return null;
                    },
                  ),
                ],
              ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Text("Anomalies"),
                DropdownButtonFormField<String>(
                  onChanged: (String? newValue) {
                    if (newValue != null) {
                      setState(() {
                        _selectedRemark = newValue;
                      });
                    }
                  },
                  items: readingMeterRemarks
                      .map<DropdownMenuItem<String>>((String remark) {
                    return DropdownMenuItem(
                      value: remark,
                      child: Text(remark),
                    );
                  }).toList(),
                  decoration: const InputDecoration(
                    labelText: "Anomalies",
                    border: OutlineInputBorder(),
                  ),
                ),
              ],
            ),
            // Submit Button
            ElevatedButton(
              onPressed: () {
                final isValidForm = _formKey.currentState!.validate();

                // Save Location if not Exists
                if (isValidForm) {
                  // update record based on customer id and registry
                  // if there is no location record a single location data
                  if (!widget.args.hasHistory) {
                    print("Saving Location Here!");
                    final readings = objectbox
                        .getReadingsByCustomerId(widget.args.customerId);
                    objectbox.addLocationHistory(widget.args.currentLat,
                        widget.args.currentLong, readings[0]!);
                  } else {
                    print("Location exists!");
                  }

                  var readingDate = DateTime.now();
                  // check if the registries  and update accordingly
                  if (_readingRegistryOne.text != "") {
                    var readingRegOne = objectbox.getReadingByRegistry(
                        readings[0]!.customerId, 1);
                    if (readingRegOne != null) {
                      readingRegOne.status = true;
                      readingRegOne.readingDate = readingDate;
                      // readingRegOne.anomalies = _selectedRemark;
                      readingRegOne.meterReading =
                          double.parse(_readingRegistryOne.text.toString());

                      objectbox.putReading(readingRegOne);
                    }
                  }

                  if (_readingRegistryTwo.text != "") {
                    var readingRegTwo = objectbox.getReadingByRegistry(
                        readings[0]!.customerId, 2);
                    if (readingRegTwo != null) {
                      readingRegTwo.status = true;
                      readingRegTwo.readingDate = readingDate;
                      // readingRegTwo.anomalies = _selectedRemark;
                      readingRegTwo.meterReading =
                          double.parse(_readingRegistryTwo.text.toString());

                      objectbox.putReading(readingRegTwo);
                    }
                  }

                  if (_readingRegistryThree.text != "") {
                    var readingRegThree = objectbox.getReadingByRegistry(
                        readings[0]!.customerId, 3);
                    if (readingRegThree != null) {
                      readingRegThree.status = true;
                      readingRegThree.readingDate = readingDate;
                      // readingRegThree.anomalies = _selectedRemark;
                      readingRegThree.meterReading =
                          double.parse(_readingRegistryThree.text.toString());

                      objectbox.putReading(readingRegThree);
                    }
                  }

                  CustomDialog.show(
                      context, "Success", "Record saved successfully");

                  Navigator.pushNamed(context, '/readings');
                }
              },
              child: const Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
