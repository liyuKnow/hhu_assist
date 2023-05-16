import 'package:flutter_test/flutter_test.dart';
import 'package:hhu_assist/objectbox.g.dart';
import 'package:hhu_assist/src/data/models/model.dart';
import 'package:objectbox/objectbox.dart';
import 'dart:io';

void main() {
  late Store store;
  late Directory tempDir;

  setUp(() async {
    // Create a temporary directory for testing
    tempDir = await Directory.systemTemp.createTemp();

    // Initialize the ObjectBox store for testing
    store = Store(getObjectBoxModel(), directory: tempDir.path);
  });

  tearDown(() {
    // Close the ObjectBox store after testing
    store.close();

    // Delete the temporary directory
    tempDir.deleteSync(recursive: true);
  });

  test('Database schema is updated correctly', () async {
    // Create a new Reading object with the updated constructor
    final reading = Reading(
      legacyAccNo: '12345',
      businessPartner: 'John Doe',
      businessPartnerName: 'John Doe Inc.',
      installation: '123 Main St.',
      device: 'Meter 1',
      register: 'Register 1',
      scheduledMRDate: DateTime.now(),
      unitOfMeasure: 'kWh',
      portion: 'Portion 1',
      meterReadingUnit: 'kWh',
    );

    // Insert the Reading object into the database
    final box = store.box<Reading>();
    final id = box.put(reading);

    // Retrieve the Reading object from the database
    final retrievedReading = box.get(id);

    // Verify that the Reading object was inserted and retrieved correctly
    expect(retrievedReading, isNotNull);
    expect(retrievedReading!.legacyAccNo, equals('12345'));
    expect(retrievedReading.businessPartner, equals('John Doe'));
    expect(retrievedReading.businessPartnerName, equals('John Doe Inc.'));
    expect(retrievedReading.installation, equals('123 Main St.'));
    expect(retrievedReading.device, equals('Meter 1'));
    expect(retrievedReading.register, equals('Register 1'));
    expect(retrievedReading.scheduledMRDate, equals(reading.scheduledMRDate));
    expect(retrievedReading.unitOfMeasure, equals('kWh'));
    expect(retrievedReading.portion, equals('Portion 1'));
    expect(retrievedReading.meterReadingUnit, equals('kWh'));
  });
}
