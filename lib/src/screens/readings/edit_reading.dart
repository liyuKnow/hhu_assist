import "dart:io";
import 'package:flutter/material.dart';
import 'package:hhu_assist/src/controller/haversine.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:location/location.dart';
// import 'package:geolocator/geolocator.dart';

import 'package:hhu_assist/main.dart';
import 'package:hhu_assist/src/data/models/model.dart';
import 'package:hhu_assist/src/controller/permissions_controller.dart';

class EditReading extends StatefulWidget {
  final EditScreenArguments args;

  const EditReading({super.key, required this.args});

  @override
  State<EditReading> createState() => _EditReadingState();
}

class _EditReadingState extends State<EditReading> {
  GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  Reading? reading;
  bool isAllowed = true;
  late double? currentLat = 0;
  late double? currentLong = 0;

  @override
  void initState() {
    super.initState();
    reading = objectbox.getReadingByCustomerId(widget.args.customerId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Reading"),
        centerTitle: true,
        automaticallyImplyLeading: true,
      ),
      body: Form(
        key: globalKey,
        child: _formUI(),
      ),
      bottomNavigationBar: SizedBox(
        height: 110,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            FormHelper.submitButton(
              "Save",
              () async {
                if (validateAndEdit()) {
                  reading!.status = true;
                  reading!.readingDate = DateTime.now();

                  objectbox.putReading(reading!);

                  LocationHistory? locationHistory =
                      await objectbox.getLocationHistory(reading!.customerId);

                  if (locationHistory == null) {
                    PermissionController.requestLocation();

                    var location = Location();
                    final loc = await location.getLocation();

                    if (loc != null) {
                      objectbox.addLocationHistory(
                          loc.latitude!, loc.longitude!, reading!);
                    }
                  }

                  // print('id : ${reading!.id}');
                  // print('customerName : ${reading!.customerName}');
                  // print('deviceId : ${reading!.deviceId}');
                  // print('meterReadingUnit : ${reading!.meterReadingUnit}');
                  // print('legacy : ${reading!.legacy}');
                  // print('status : ${reading!.status}');
                  // print('meterReading : ${reading!.meterReading}');
                  // print('readingDate : ${reading!.readingDate}');
                  // print('fieldPhoto : ${reading!.fieldPhoto}');
                  // print('appearanceValue : ${reading!.appearanceValue}');
                  // print('registry : ${reading!.registry}');

                  FormHelper.showSimpleAlertDialog(
                    context,
                    "HHU Helper",
                    "Reading Updated Successfully!",
                    "Ok",
                    () {
                      Navigator.pushNamed(context, '/readings');
                    },
                  );
                }
              },
              borderRadius: 10,
              btnColor: Colors.green[300]!,
              borderColor: Colors.green[400]!,
            ),
            FormHelper.submitButton(
              "Cancel",
              () {},
              borderRadius: 10,
              btnColor: Colors.grey[400]!,
              borderColor: Colors.grey[400]!,
            )
          ],
        ),
      ),
    );
  }

  _formUI() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            FormHelper.inputFieldWidgetWithLabel(
              context,
              initialValue: reading!.customerName,
              "customerName",
              "CustomerName",
              "Customer Name",
              (onValidate) {
                return null;
              },
              (onSaved) {},
              showPrefixIcon: true,
              borderRadius: 10,
              isReadonly: true,
              hintColor: Colors.black38,
              fontSize: 14,
              labelFontSize: 14,
              paddingLeft: 0,
              paddingRight: 0,
              prefixIcon: const Icon(Icons.person),
              prefixIconPaddingLeft: 10,
              borderColor: Colors.red[200]!,
              labelFontColor: Colors.black45,
              borderFocusColor: Colors.red[200]!,
            ),
            const SizedBox(
              height: 4,
            ),
            FormHelper.inputFieldWidgetWithLabel(
              context,
              initialValue: reading!.customerId,
              "CustomerId",
              "CustomerId",
              "Customer Id",
              (onValidate) {
                return null;
              },
              (onSaved) {},
              borderRadius: 10,
              isReadonly: true,
              hintColor: Colors.black38,
              fontSize: 14,
              labelFontSize: 14,
              paddingLeft: 0,
              paddingRight: 0,
              showPrefixIcon: true,
              prefixIcon: const Icon(Icons.devices),
              prefixIconPaddingLeft: 10,
              borderColor: Colors.red[200]!,
              labelFontColor: Colors.black45,
              borderFocusColor: Colors.red[200]!,
            ),
            const SizedBox(
              height: 4,
            ),
            FormHelper.inputFieldWidgetWithLabel(
              context,
              "meterReading",
              "Meter Reading",
              "Meter reading in KWH",
              isReadonly: widget.args.isInAllowedDistance,
              backgroundColor: widget.args.isInAllowedDistance
                  ? Colors.red[200]!
                  : Colors.white,
              (onValidate) {
                if (onValidate.isEmpty) {
                  return "* Meter Reading is Required";
                }

                if (!isNumeric(onValidate)) {
                  return "* Meter reading can not include characters";
                }
                return null;
              },
              (onSaved) {
                reading!.meterReading = double.parse(onSaved.toString().trim());
              },
              borderRadius: 10,
              hintColor: Colors.black45,
              isNumeric: true,
              fontSize: 14,
              paddingLeft: 0,
              paddingRight: 0,
              showPrefixIcon: true,
              prefixIcon: const Icon(Icons.electric_meter),
              prefixIconPaddingLeft: 10,
              labelFontSize: 14,
            ),
            const SizedBox(
              height: 30,
            ),
            _picPicker(
              "",
              // model.fieldPhoto ?? "",
              (file) => {
                setState(() {
                  // model.fieldPhoto = file.path;
                  // model.hasPhoto = 1;
                }),
              },
            ),
          ],
        ),
      ),
    );
  }

  bool validateAndEdit() {
    final form = globalKey.currentState;

    if (form!.validate()) {
      form.save();
      return true;
    }

    return false;
  }

  bool isNumeric(String s) {
    if (s == null) {
      return false;
    }
    return double.tryParse(s) != null;
  }

  _picPicker(String fileName, Function onFilePicked) {
    Future<XFile?> _imageFile;
    ImagePicker _picker = ImagePicker();

    return Column(
      children: [
        fileName != ""
            ? Image.file(
                File(fileName),
                width: 300,
                height: 300,
              )
            : Image.asset(
                "assets/placeholder_350x250.png",
                width: 300,
                height: 300,
                fit: BoxFit.cover,
              ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () {
                  _imageFile = _picker.pickImage(source: ImageSource.camera);
                  _imageFile.then((file) async {
                    onFilePicked(file);
                  });
                },
                child: Row(
                  children: const [
                    Icon(
                      Icons.camera,
                      size: 35,
                    ),
                    Text("Take Field Photo")
                  ],
                )),
          ],
        )
      ],
    );
  }
}
