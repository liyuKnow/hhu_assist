import 'package:flutter/material.dart';
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

  String? _name;
  String? _email;

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
      body: ListView.builder(
        itemCount: readings.length,
        itemBuilder: ((context, index) {
          // return ListTile(title: Text(readings[index]!.customerId.toString()));
          return ListTile(
            title: Text(
              readings[index]!.customerId,
              style: const TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Text(
              'Subtitle for item $index',
              style: const TextStyle(
                fontSize: 14.0,
                color: Colors.grey,
              ),
            ),
            leading: CircleAvatar(
              child: Text(
                readings[index]!.customerName,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            trailing: Icon(Icons.arrow_forward),
            onTap: () {
              // Handle tap on list item
            },
          );
        }),
      ),
      // body: readingForm(context),
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
              decoration: const InputDecoration(
                prefixIcon: Icon(
                  Icons.person,
                ),
                labelText: 'Name',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your name';
                }
                return null;
              },
              onSaved: (value) {
                print(value);
                _name = value;
              },
            ),
            ElevatedButton(
              onPressed: () {
                final isValidForm = _formKey.currentState!.validate();

                if (isValidForm) {
                  //   _formKey.currentState?.save();
                  CustomDialog.show(
                      context, "Success", "Name: $_name\nEmail: $_email");

                  print("Name: $_name\nEmail: $_email");
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
