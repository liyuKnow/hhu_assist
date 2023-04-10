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
  final _readingRegistryOne = TextEditingController();
  final _readingRegistryTwo = TextEditingController();
  final _readingRegistryThree = TextEditingController();

  List<Reading?> readings = [];

  bool isAllowed = true;
  late double? currentLat = 0;
  late double? currentLong = 0;

  @override
  void initState() {
    super.initState();
    readings = objectbox.getReadingsByCustomerId(widget.args.customerId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Form"),
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
              // controller: _custIdController,
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
              // controller: _custIdController,
              decoration: const InputDecoration(
                prefixIcon: Icon(
                  Icons.person,
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
              // controller: _custIdController,
              decoration: const InputDecoration(
                prefixIcon: Icon(
                  Icons.person,
                ),
                labelText: 'Meter Reading',
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
              // controller: _custIdController,
              decoration: const InputDecoration(
                prefixIcon: Icon(
                  Icons.person,
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
            TextFormField(
              // enabled: false,
              readOnly: true,
              // initialValue: "Device",
              // controller: _custIdController,
              decoration: const InputDecoration(
                prefixIcon: Icon(
                  Icons.person,
                ),
                labelText: 'Current Location',
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
              // controller: _custIdController,
              decoration: const InputDecoration(
                prefixIcon: Icon(
                  Icons.person,
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
              onSaved: (value) {
                print(value);
              },
            ),
            if (readings.length == 3)
              Column(
                children: [
                  TextFormField(
                    controller: _readingRegistryTwo,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(
                        Icons.person,
                      ),
                      labelText: 'Reading registry two',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your name';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      print(value);
                    },
                  ),
                  TextFormField(
                    controller: _readingRegistryThree,
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
                    onSaved: (value) {
                      print(value);
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

                if (isValidForm) {
                  //   _formKey.currentState?.save();
                  CustomDialog.show(context, "Success",
                      "Customer Id: ${_custIdController.text}");

                  print("Customer Id: ${_custIdController.text}");
                  print("Reading Registry One: ${_readingRegistryOne.text}");
                  print("Reading Registry Two: ${_readingRegistryTwo.text}");
                  print(
                      "Reading Registry Three: ${_readingRegistryThree.text}");
                  // newDialogue(context,
                  //     contentText: 'Name: $_name\nEmail: $_email');
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




// body: ListView.builder(
      //   itemCount: readings.length,
      //   itemBuilder: ((context, index) {
      //     // return ListTile(title: Text(readings[index]!.customerId.toString()));
      //     return ListTile(
      //       title: Text(
      //         readings[index]!.customerId,
      //         style: const TextStyle(
      //           fontSize: 18.0,
      //           fontWeight: FontWeight.bold,
      //         ),
      //       ),
      //       subtitle: Text(
      //         'Subtitle for item $index',
      //         style: const TextStyle(
      //           fontSize: 14.0,
      //           color: Colors.grey,
      //         ),
      //       ),
      //       leading: CircleAvatar(
      //         child: Text(
      //           readings[index]!.customerName,
      //           style: const TextStyle(
      //             fontWeight: FontWeight.bold,
      //           ),
      //         ),
      //       ),
      //       trailing: Icon(Icons.arrow_forward),
      //       onTap: () {
      //         // Handle tap on list item
      //       },
      //     );
      //   }),
      // ),