import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import "package:image_picker/image_picker.dart";
import 'package:dropdown_search/dropdown_search.dart';
import 'package:path/path.dart' as path;
import "package:intl/intl.dart";
import 'package:hhu_assist/main.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({super.key});

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  File? image;
  List<String> items = [];
  String selectedCustomerId = "";

  @override
  void initState() {
    items = objectbox.getCustomerIds();
    super.initState();
  }

  Future saveImageToDownloads() async {
    try {
      if (selectedCustomerId.isNotEmpty) {
        final image = await ImagePicker().pickImage(source: ImageSource.camera);

        if (image == null) return null;

        final oldPath = image.path;
        final extension = path.extension(oldPath);
        final timestamp = DateTime.now();

        // Rename image
        final newImgName =
            '${selectedCustomerId}_${customTimeStamp(timestamp)}$extension';

        // get or create hhu directory
        final hhuDirectory =
            Directory('/storage/emulated/0/Download/HHU Helper');

        if (!await hhuDirectory.exists()) {
          await hhuDirectory.create();
        }

        final newImgPath = path.join(hhuDirectory.path, newImgName);

        final newImg = await File(oldPath).copy(newImgPath);

        // Preview with state
        setState(() => this.image = newImg);

        const snackBar = SnackBar(
          content: Text(
            'Image saved successfully',
          ),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      } else {
        const snackBar = SnackBar(
          content: Text(
            'Please select a customer id',
          ),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    } on PlatformException catch (e) {
      print('Failed to Pick Image : $e');
    }
  }

  String customTimeStamp(DateTime dateTime) {
    final formatter = DateFormat('EEE, MMM d, y h:mm a');
    return formatter.format(dateTime);
  }

  void itemSelectionChanged(String? item) {
    selectedCustomerId = item!;
    print(selectedCustomerId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('take Image')),
      body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                DropdownSearch<String>(
                  mode: Mode.MENU,
                  showSelectedItems: true,
                  items: items,
                  dropdownSearchDecoration: const InputDecoration(
                    labelText: "Business partner Id",
                    hintText: "Business partner id number",
                  ),
                  showSearchBox: true,
                  onChanged: itemSelectionChanged,
                  searchFieldProps: const TextFieldProps(
                    cursorColor: Colors.blue,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: ElevatedButton(
                          onPressed: () => Navigator.pushNamed(context, '/'),
                          child: Text('Cancel'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.grey[300],
                            foregroundColor: Colors.black,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8.0),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: ElevatedButton.icon(
                          onPressed: () => saveImageToDownloads(),
                          icon: const Icon(Icons.camera_alt),
                          label: const Text('Open Camera'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                image != null
                    ? Image.file(
                        image!,
                        width: 300,
                        height: 300,
                      )
                    : Image.asset(
                        "assets/placeholder_350x250.png",
                        width: 300,
                        height: 300,
                        fit: BoxFit.cover,
                      ),
              ],
            ),
          )),
    );
  }
}
