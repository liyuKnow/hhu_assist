import 'package:flutter/material.dart';
import 'package:hhu_assist/src/controller/permissions_controller.dart';

import 'package:location/location.dart';
import 'package:hhu_assist/src/data/models/model.dart';
import 'package:hhu_assist/main.dart';
import 'package:hhu_assist/src/controller/haversine.dart';

class ReadingCard extends StatefulWidget {
  final Reading reading;
  const ReadingCard({super.key, required this.reading});

  @override
  State<ReadingCard> createState() => _ReadingCardState();
}

class _ReadingCardState extends State<ReadingCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (() async {
        bool hasHistory = false;
        bool isInAllowedDistance = false;

        LocationHistory? locationHistory =
            await objectbox.getLocationHistory(widget.reading.customerId);

        if (locationHistory != null) {
          hasHistory = true;
          // get current location data
          PermissionController.requestLocation();

          var location = Location();
          final loc = await location.getLocation();

          var distance = Haversine.haversine(
            locationHistory.lat,
            locationHistory.long,
            loc.latitude,
            loc.longitude,
          );

          isInAllowedDistance = (distance < 50) ? true : false;
        }

        EditScreenArguments args = EditScreenArguments(
          widget.reading.customerId,
          hasHistory,
          isInAllowedDistance,
        );

        Navigator.pushNamed(context, '/multi_edit', arguments: args);
        // Navigator.pushNamed(context, '/edit_reading', arguments: args);
      }),
      child: Container(
        height: 120,
        margin: const EdgeInsets.all(5),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: const Color.fromARGB(255, 243, 243, 243),
            boxShadow: const [
              BoxShadow(
                  color: Color.fromARGB(255, 168, 168, 168),
                  blurRadius: 5,
                  offset: Offset(1, 2))
            ]),
        child: Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.reading.customerName,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    Text("Customer Id : ${widget.reading.customerId}"),
                    Text("device Id : ${widget.reading.deviceId}"),
                    Text(" status : ${widget.reading.status}"),
                    Text(" Registry : ${widget.reading.registry}"),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
