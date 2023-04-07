import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import "package:image_picker/image_picker.dart";
import 'package:path/path.dart' as path;
import "package:intl/intl.dart";

class CameraScreen extends StatefulWidget {
  const CameraScreen({super.key});

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  File? image;

  Future saveImageToDownloads() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.camera);

      if (image == null) return null;

      final oldPath = image.path;
      final extension = path.extension(oldPath);
      final timestamp = DateTime.now();

      // Rename image
      final newImgName = 'customer_Id_${customTimeStamp(timestamp)}$extension';

      // get or create hhu directory
      final hhuDirectory = Directory('/storage/emulated/0/Download/HHU_Assist');

      if (!await hhuDirectory.exists()) {
        await hhuDirectory.create();
      }

      final newImgPath = path.join(hhuDirectory.path, newImgName);

      final newImg = await File(oldPath).copy(newImgPath);

      // Preview with state
      setState(() => this.image = newImg);
    } on PlatformException catch (e) {
      print('Failed to Pick Image : $e');
    }
  }

  String customTimeStamp(DateTime dateTime) {
    final formatter = DateFormat('EEE, MMM d, y h:mm a');
    return formatter.format(dateTime);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('take Image')),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Insert Customer ID"),
              ),
              IconButton(
                onPressed: () => saveImageToDownloads(),
                icon: const Icon(Icons.camera),
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
        ));
  }
}
