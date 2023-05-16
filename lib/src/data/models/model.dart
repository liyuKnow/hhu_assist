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

  String portion;
  String meterReadingUnit;
  String? meterReader;
  String legacyAccNo;
  String businessPartner;
  String businessPartnerName;
  String installation;
  String device;
  String register;
  DateTime scheduledMRDate;
  String unitOfMeasure;
  DateTime? readingDate;
  double? meterReading;
  String? appearanceValue;

  bool status;

  int? hasPhoto;
  String? fieldPhoto;

  // CONSTRUCTOR
  Reading({
    this.id = 0,
    this.status = false,
    this.meterReading,
    this.readingDate,
    this.hasPhoto,
    this.fieldPhoto,
    required this.legacyAccNo,
    required this.businessPartner,
    required this.businessPartnerName,
    required this.installation,
    required this.device,
    required this.register,
    required this.scheduledMRDate,
    required this.unitOfMeasure,
    this.appearanceValue,
    required this.portion,
    required this.meterReadingUnit,
  });
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
