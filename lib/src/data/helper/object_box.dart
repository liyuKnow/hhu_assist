import "package:hhu_assist/src/data/models/model.dart";
import 'package:hhu_assist/objectbox.g.dart';

class ObjectBox {
  // DEFINE STORE
  late final Store store;

  late final Box<Reading> readingBox;
  late final Box<LocationHistory> locationHistoryBox;
  // CREATE BOXES
  ObjectBox._create(this.store) {
    readingBox = Box<Reading>(store);
    locationHistoryBox = Box<LocationHistory>(store);
  }

  // CREATE AN INSTANCE OF OBJECTBOX TO USE THROUGHOUT THE APP.
  static Future<ObjectBox> create() async {
    final store = await openStore();
    return ObjectBox._create(store);
  }

  // CRUD OPERATIONS
  void putReading(Reading reading) {
    readingBox.put(reading);
  }

  Stream<List<Reading>> getReadings() {
    final builder = readingBox.query();
    return builder.watch(triggerImmediately: true).map((query) => query.find());
  }

  Stream<List<Reading>> searchReadings(String q) {
    final builder = readingBox.query(
      Reading_.customerId.contains(q) | Reading_.deviceId.contains(q),
    );
    // final builder = readingBox.query();
    return builder.watch(triggerImmediately: true).map((query) => query.find());
  }

  removeReadings() {
    var query = readingBox.query().build();
    query.remove();
  }

  removeLocationHistories() {
    var query = locationHistoryBox.query().build();
    query.remove();
  }

  Reading? getReadingByCustomerId(String customerId) {
    Query<Reading> query =
        readingBox.query(Reading_.customerId.contains(customerId)).build();
    Reading? reading = query.findUnique();
    return reading;
  }

  List<Reading?> getReadingsByCustomerId(String customerId) {
    Query<Reading> query =
        readingBox.query(Reading_.customerId.equals(customerId)).build();
    List<Reading> readings = query.find();
    query.close();

    return readings;
  }

  List<LocationHistory>? getLocations() {
    final query = locationHistoryBox.query().build();
    List<LocationHistory> locations = query.find();
    query.close();
    return locations;
  }

  LocationHistory? getLocationHistory(String customerId) {
    final query = locationHistoryBox
        .query(LocationHistory_.customerId.equals(customerId))
        .build();
    LocationHistory? locations = query.findUnique();
    query.close();
    return locations;
  }

  void addLocationHistory(double lat, double long, Reading reading) {
    LocationHistory locationHistory =
        LocationHistory(lat, long, reading.customerId);
    locationHistory.reading.target = reading;

    locationHistoryBox.put(locationHistory);
  }
}
