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
  State<QRScreen> createState() => QRScreenState();
}

class QRScreenState extends State<QRScreen> {
  final qrkey = GlobalKey(debugLabel: 'QR');
  var flashOn = false;

  QRViewController? controller;
  Barcode? barcode;

  bool hasLocation = false;
  double currentLat = 0.0;
  double currentLong = 0.0;
  String previousLocation = '';

  @override
  void initState() {
    super.initState();
    fetchLocation();
  }

  Future<void> fetchLocation() async {
    PermissionController.requestLocation();
    final location = Location();
    final loc = await location.getLocation();
    setState(() {
      hasLocation = true;
      currentLat = loc.latitude!;
      currentLong = loc.longitude!;
    });
  }

  Future<Widget> checkMeterId() async {
    if (barcode != null) {
      try {
        final customerId = barcode!.code.toString();
        final reading = await objectbox.getReadingByCustomerId(customerId);
        print("Found barcode : ${reading!.businessPartner}");
        if (reading != "") {
          final locationHistory =
              await objectbox.getLocationHistory(customerId);
          final hasHistory = locationHistory != null;
          final isInAllowedDistance = hasLocation && locationHistory != null
              ? Haversine.haversine(
                    locationHistory.lat,
                    locationHistory.long,
                    currentLat,
                    currentLong,
                  ) <
                  50
              : false;
          final args = EditScreenArguments(
            reading.businessPartner,
            hasHistory,
            isInAllowedDistance,
            currentLat,
            currentLong,
            previousLocation,
          );
          Navigator.pushNamed(context, '/multi_edit', arguments: args);
        } else {
          const snackBar = SnackBar(
            content: Text(
              'The scanned customer id does not match any reading record',
            ),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      } catch (e) {
        print('Error: $e');
      }
    }
    return const SizedBox();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scan a QR Code'),
        centerTitle: true,
      ),
      body: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          QRView(
            key: qrkey,
            onQRViewCreated: (controller) {
              this.controller = controller;
              controller.scannedDataStream.listen((barcode) {
                setState(() {
                  this.barcode = barcode;
                });
              });
            },
            overlay: QrScannerOverlayShape(
              cutOutSize: MediaQuery.of(context).size.width * 0.8,
              borderRadius: 10,
              borderWidth: 10,
              borderLength: 20,
              borderColor: Colors.blue,
            ),
          ),
          Positioned(
            bottom: 10,
            child: FutureBuilder<Widget>(
              future: checkMeterId(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else {
                  return snapshot.data ?? const SizedBox();
                }
              },
            ),
          ),
          Positioned(
            top: 10,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.white24,
              ),
              child: IconButton(
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
            ),
          ),
        ],
      ),
    );
  }
}
