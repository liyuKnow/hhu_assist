import 'package:objectbox/objectbox.dart';
import 'package:hhu_assist/objectbox.g.dart';

@Entity()
class Todo {
  @Id()
  int id;
  String? title;
  bool? completed;

  Todo({this.id = 0, this.title, this.completed});
}

@Entity()
class Reading {
  @Id()
  int id;

  String customerName;
  String customerId;
  String deviceId;
  String meterReadingUnit;
  String? legacy;

  bool status;
  double? meterReading;
  DateTime? readingDate;

  int? hasPhoto;
  String? fieldPhoto;

  String? appearanceValue;

  int registry;

  // CONSTRUCTOR
  Reading({
    this.id = 0,
    this.status = false,
    this.meterReading,
    this.readingDate,
    this.hasPhoto,
    this.fieldPhoto,
    this.legacy,
    required this.customerName,
    required this.customerId,
    required this.deviceId,
    required this.meterReadingUnit,
    required this.registry,
  });

  // final owner = ToOne<Owner>();

  bool setFinished() {
    status = !status;
    return status;
  }

  String get getCustomerId => this.customerId;
}

@Entity()
class LocationHistory {
  @Id()
  int id;
  double lat;
  double long;
  String customerId;

  final reading = ToOne<Reading>();
  LocationHistory(this.lat, this.long, this.customerId, {this.id = 0});
}
