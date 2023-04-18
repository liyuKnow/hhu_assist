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
              // enabled: false,
              readOnly: true,
              // initialValue: "Default Values",
              controller: _custIdController,
              decoration: const InputDecoration(
                prefixIcon: Icon(
                  Icons.person,
                ),
                labelText: 'Customer Id',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your name';
                }
                return null;
              },
              // onSaved: (value) {
              //   print(value);
              //   _custIdController = value;
              // },
            ),
            TextFormField(
              // enabled: false,
              readOnly: true,
              // initialValue: "Default Values",
              controller: _custName,
              decoration: const InputDecoration(
                prefixIcon: Icon(
                  Icons.person,
                ),
                labelText: 'Customer Name',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your name';
                }
                return null;
              },
              // onSaved: (value) {
              //   print(value);
              //   _custIdController = value;
              // },
            ),
            TextFormField(
              // enabled: false,
              readOnly: true,
              // initialValue: "Device",
              controller: _legacyAccNo,
              decoration: const InputDecoration(
                prefixIcon: Icon(
                  Icons.book,
                ),
                labelText: 'Legacy Acc. No.',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your name';
                }
                return null;
              },
            ),
            TextFormField(
              // enabled: false,
              readOnly: true,
              // initialValue: "Device",
              controller: _meterReadingUnit,
              decoration: const InputDecoration(
                prefixIcon: Icon(
                  Icons.electric_meter_outlined,
                ),
                labelText: 'Meter Reading Unit',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your name';
                }
                return null;
              },
            ),
            TextFormField(
              // enabled: false,
              readOnly: true,
              // initialValue: "Device",
              controller: _deviceId,
              decoration: const InputDecoration(
                prefixIcon: Icon(
                  Icons.dashboard_outlined,
                ),
                labelText: 'Device Id',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your name';
                }
                return null;
              },
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
                  fillColor: Colors.amber,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
              ),
            ),
            TextFormField(
              // enabled: false,
              readOnly: true,
              // initialValue: "Device",
              controller: _prevLocation,
              decoration: const InputDecoration(
                prefixIcon: Icon(
                  Icons.location_searching,
                ),
                labelText: 'Previous Location',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your name';
                }
                return null;
              },
            ),
            TextFormField(
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
                  return 'Please enter your name';
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
                const Text("Remark"),
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
                    labelText: "Remark",
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
                  // CustomDialog.show(context, "Success",
                  //     "Customer Id: ${_custIdController.text}");

                  // update record based on customer id and registry
                  // if there is no location record a single location data
                  if (!widget.args.hasHistory) {
                    print("Saving Location Here!");
                    final reading = objectbox
                        .getReadingByCustomerId(widget.args.customerId);
                    objectbox.addLocationHistory(widget.args.currentLat,
                        widget.args.currentLong, reading!);
                  } else {
                    print("Location exists!");
                  }
                }

                // check if the registries  and update accordingly
                if (_readingRegistryOne.text != "") {}

                if (_readingRegistryTwo.text != "") {}

                if (_readingRegistryThree.text != "") {}
              },
              child: const Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
