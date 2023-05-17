// GENERATED CODE - DO NOT MODIFY BY HAND
// This code was generated by ObjectBox. To update it run the generator again:
// With a Flutter package, run `flutter pub run build_runner build`.
// With a Dart package, run `dart run build_runner build`.
// See also https://docs.objectbox.io/getting-started#generate-objectbox-code

// ignore_for_file: camel_case_types
// coverage:ignore-file

import 'dart:typed_data';

import 'package:flat_buffers/flat_buffers.dart' as fb;
import 'package:objectbox/internal.dart'; // generated code can access "internal" functionality
import 'package:objectbox/objectbox.dart';
import 'package:objectbox_flutter_libs/objectbox_flutter_libs.dart';

import 'src/data/models/model.dart';

export 'package:objectbox/objectbox.dart'; // so that callers only have to import this file

final _entities = <ModelEntity>[
  ModelEntity(
      id: const IdUid(1, 4932777587796331270),
      name: 'LocationHistory',
      lastPropertyId: const IdUid(7, 8378862003170688961),
      flags: 0,
      properties: <ModelProperty>[
        ModelProperty(
            id: const IdUid(1, 2455557651877514806),
            name: 'id',
            type: 6,
            flags: 1),
        ModelProperty(
            id: const IdUid(4, 1490551286180173595),
            name: 'lat',
            type: 8,
            flags: 0),
        ModelProperty(
            id: const IdUid(5, 394847147705920889),
            name: 'long',
            type: 8,
            flags: 0),
        ModelProperty(
            id: const IdUid(6, 569100776779908244),
            name: 'customerId',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(7, 8378862003170688961),
            name: 'readingId',
            type: 11,
            flags: 520,
            indexId: const IdUid(3, 4664444247261234699),
            relationTarget: 'Reading')
      ],
      relations: <ModelRelation>[],
      backlinks: <ModelBacklink>[]),
  ModelEntity(
      id: const IdUid(2, 5431337627199601995),
      name: 'Reading',
      lastPropertyId: const IdUid(27, 5965708964885691293),
      flags: 0,
      properties: <ModelProperty>[
        ModelProperty(
            id: const IdUid(1, 4550566228231795758),
            name: 'id',
            type: 6,
            flags: 1),
        ModelProperty(
            id: const IdUid(5, 2226428783302653604),
            name: 'meterReadingUnit',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(7, 7785402635414115558),
            name: 'status',
            type: 1,
            flags: 0),
        ModelProperty(
            id: const IdUid(8, 1484140066894793914),
            name: 'meterReading',
            type: 8,
            flags: 0),
        ModelProperty(
            id: const IdUid(9, 3830343330401124790),
            name: 'readingDate',
            type: 10,
            flags: 0),
        ModelProperty(
            id: const IdUid(11, 1988584154774614072),
            name: 'hasPhoto',
            type: 6,
            flags: 0),
        ModelProperty(
            id: const IdUid(12, 6220451012263725017),
            name: 'fieldPhoto',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(16, 3522321180328951932),
            name: 'portion',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(17, 1380633695344285171),
            name: 'meterReader',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(18, 5991669769217963155),
            name: 'legacyAccNo',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(19, 2387465720053648796),
            name: 'businessPartner',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(20, 5092903525596811505),
            name: 'businessPartnerName',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(21, 1747351095516612712),
            name: 'installation',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(22, 8770100175717837947),
            name: 'device',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(23, 5676008111892394466),
            name: 'register',
            type: 6,
            flags: 0),
        ModelProperty(
            id: const IdUid(24, 4242723859886190115),
            name: 'scheduledMRDate',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(25, 8045684426375267127),
            name: 'unitOfMeasure',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(26, 565585693179136089),
            name: 'rateCategory',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(27, 5965708964885691293),
            name: 'meterReadingNote',
            type: 9,
            flags: 0)
      ],
      relations: <ModelRelation>[],
      backlinks: <ModelBacklink>[]),
  ModelEntity(
      id: const IdUid(3, 1150387250112367065),
      name: 'Todo',
      lastPropertyId: const IdUid(3, 7145783835259576838),
      flags: 0,
      properties: <ModelProperty>[
        ModelProperty(
            id: const IdUid(1, 8287293781157392618),
            name: 'id',
            type: 6,
            flags: 1),
        ModelProperty(
            id: const IdUid(2, 2857033119413673002),
            name: 'title',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(3, 7145783835259576838),
            name: 'completed',
            type: 1,
            flags: 0)
      ],
      relations: <ModelRelation>[],
      backlinks: <ModelBacklink>[])
];

/// Open an ObjectBox store with the model declared in this file.
Future<Store> openStore(
        {String? directory,
        int? maxDBSizeInKB,
        int? fileMode,
        int? maxReaders,
        bool queriesCaseSensitiveDefault = true,
        String? macosApplicationGroup}) async =>
    Store(getObjectBoxModel(),
        directory: directory ?? (await defaultStoreDirectory()).path,
        maxDBSizeInKB: maxDBSizeInKB,
        fileMode: fileMode,
        maxReaders: maxReaders,
        queriesCaseSensitiveDefault: queriesCaseSensitiveDefault,
        macosApplicationGroup: macosApplicationGroup);

/// ObjectBox model definition, pass it to [Store] - Store(getObjectBoxModel())
ModelDefinition getObjectBoxModel() {
  final model = ModelInfo(
      entities: _entities,
      lastEntityId: const IdUid(3, 1150387250112367065),
      lastIndexId: const IdUid(3, 4664444247261234699),
      lastRelationId: const IdUid(0, 0),
      lastSequenceId: const IdUid(0, 0),
      retiredEntityUids: const [],
      retiredIndexUids: const [9072938860174077880, 2906547492720396183],
      retiredPropertyUids: const [
        2044593263589492031,
        4228717222709387174,
        8614374387751331549,
        1674156170337999711,
        3586492801889185079,
        6952670803355897433,
        2348985825963805482,
        1871662094985102402,
        2198891144491561017,
        5220363658845121145
      ],
      retiredRelationUids: const [],
      modelVersion: 5,
      modelVersionParserMinimum: 5,
      version: 1);

  final bindings = <Type, EntityDefinition>{
    LocationHistory: EntityDefinition<LocationHistory>(
        model: _entities[0],
        toOneRelations: (LocationHistory object) => [object.reading],
        toManyRelations: (LocationHistory object) => {},
        getId: (LocationHistory object) => object.id,
        setId: (LocationHistory object, int id) {
          object.id = id;
        },
        objectToFB: (LocationHistory object, fb.Builder fbb) {
          final customerIdOffset = fbb.writeString(object.customerId);
          fbb.startTable(8);
          fbb.addInt64(0, object.id);
          fbb.addFloat64(3, object.lat);
          fbb.addFloat64(4, object.long);
          fbb.addOffset(5, customerIdOffset);
          fbb.addInt64(6, object.reading.targetId);
          fbb.finish(fbb.endTable());
          return object.id;
        },
        objectFromFB: (Store store, ByteData fbData) {
          final buffer = fb.BufferContext(fbData);
          final rootOffset = buffer.derefObject(0);

          final object = LocationHistory(
              const fb.Float64Reader().vTableGet(buffer, rootOffset, 10, 0),
              const fb.Float64Reader().vTableGet(buffer, rootOffset, 12, 0),
              const fb.StringReader(asciiOptimization: true)
                  .vTableGet(buffer, rootOffset, 14, ''),
              id: const fb.Int64Reader().vTableGet(buffer, rootOffset, 4, 0));
          object.reading.targetId =
              const fb.Int64Reader().vTableGet(buffer, rootOffset, 16, 0);
          object.reading.attach(store);
          return object;
        }),
    Reading: EntityDefinition<Reading>(
        model: _entities[1],
        toOneRelations: (Reading object) => [],
        toManyRelations: (Reading object) => {},
        getId: (Reading object) => object.id,
        setId: (Reading object, int id) {
          object.id = id;
        },
        objectToFB: (Reading object, fb.Builder fbb) {
          final meterReadingUnitOffset =
              fbb.writeString(object.meterReadingUnit);
          final fieldPhotoOffset = object.fieldPhoto == null
              ? null
              : fbb.writeString(object.fieldPhoto!);
          final portionOffset = fbb.writeString(object.portion);
          final meterReaderOffset = object.meterReader == null
              ? null
              : fbb.writeString(object.meterReader!);
          final legacyAccNoOffset = fbb.writeString(object.legacyAccNo);
          final businessPartnerOffset = fbb.writeString(object.businessPartner);
          final businessPartnerNameOffset =
              fbb.writeString(object.businessPartnerName);
          final installationOffset = fbb.writeString(object.installation);
          final deviceOffset = fbb.writeString(object.device);
          final scheduledMRDateOffset = fbb.writeString(object.scheduledMRDate);
          final unitOfMeasureOffset = fbb.writeString(object.unitOfMeasure);
          final rateCategoryOffset = fbb.writeString(object.rateCategory);
          final meterReadingNoteOffset = object.meterReadingNote == null
              ? null
              : fbb.writeString(object.meterReadingNote!);
          fbb.startTable(28);
          fbb.addInt64(0, object.id);
          fbb.addOffset(4, meterReadingUnitOffset);
          fbb.addBool(6, object.status);
          fbb.addFloat64(7, object.meterReading);
          fbb.addInt64(8, object.readingDate?.millisecondsSinceEpoch);
          fbb.addInt64(10, object.hasPhoto);
          fbb.addOffset(11, fieldPhotoOffset);
          fbb.addOffset(15, portionOffset);
          fbb.addOffset(16, meterReaderOffset);
          fbb.addOffset(17, legacyAccNoOffset);
          fbb.addOffset(18, businessPartnerOffset);
          fbb.addOffset(19, businessPartnerNameOffset);
          fbb.addOffset(20, installationOffset);
          fbb.addOffset(21, deviceOffset);
          fbb.addInt64(22, object.register);
          fbb.addOffset(23, scheduledMRDateOffset);
          fbb.addOffset(24, unitOfMeasureOffset);
          fbb.addOffset(25, rateCategoryOffset);
          fbb.addOffset(26, meterReadingNoteOffset);
          fbb.finish(fbb.endTable());
          return object.id;
        },
        objectFromFB: (Store store, ByteData fbData) {
          final buffer = fb.BufferContext(fbData);
          final rootOffset = buffer.derefObject(0);
          final readingDateValue =
              const fb.Int64Reader().vTableGetNullable(buffer, rootOffset, 20);
          final object = Reading(
              id: const fb.Int64Reader().vTableGet(buffer, rootOffset, 4, 0),
              status: const fb.BoolReader()
                  .vTableGet(buffer, rootOffset, 16, false),
              meterReading: const fb.Float64Reader()
                  .vTableGetNullable(buffer, rootOffset, 18),
              meterReader: const fb.StringReader(asciiOptimization: true)
                  .vTableGetNullable(buffer, rootOffset, 36),
              readingDate: readingDateValue == null
                  ? null
                  : DateTime.fromMillisecondsSinceEpoch(readingDateValue),
              hasPhoto: const fb.Int64Reader()
                  .vTableGetNullable(buffer, rootOffset, 24),
              fieldPhoto: const fb.StringReader(asciiOptimization: true)
                  .vTableGetNullable(buffer, rootOffset, 26),
              legacyAccNo: const fb.StringReader(asciiOptimization: true)
                  .vTableGet(buffer, rootOffset, 38, ''),
              businessPartner: const fb.StringReader(asciiOptimization: true)
                  .vTableGet(buffer, rootOffset, 40, ''),
              businessPartnerName: const fb.StringReader(asciiOptimization: true)
                  .vTableGet(buffer, rootOffset, 42, ''),
              installation:
                  const fb.StringReader(asciiOptimization: true).vTableGet(buffer, rootOffset, 44, ''),
              rateCategory: const fb.StringReader(asciiOptimization: true).vTableGet(buffer, rootOffset, 54, ''),
              device: const fb.StringReader(asciiOptimization: true).vTableGet(buffer, rootOffset, 46, ''),
              register: const fb.Int64Reader().vTableGet(buffer, rootOffset, 48, 0),
              scheduledMRDate: const fb.StringReader(asciiOptimization: true).vTableGet(buffer, rootOffset, 50, ''),
              unitOfMeasure: const fb.StringReader(asciiOptimization: true).vTableGet(buffer, rootOffset, 52, ''),
              meterReadingNote: const fb.StringReader(asciiOptimization: true).vTableGetNullable(buffer, rootOffset, 56),
              portion: const fb.StringReader(asciiOptimization: true).vTableGet(buffer, rootOffset, 34, ''),
              meterReadingUnit: const fb.StringReader(asciiOptimization: true).vTableGet(buffer, rootOffset, 12, ''));

          return object;
        }),
    Todo: EntityDefinition<Todo>(
        model: _entities[2],
        toOneRelations: (Todo object) => [],
        toManyRelations: (Todo object) => {},
        getId: (Todo object) => object.id,
        setId: (Todo object, int id) {
          object.id = id;
        },
        objectToFB: (Todo object, fb.Builder fbb) {
          final titleOffset =
              object.title == null ? null : fbb.writeString(object.title!);
          fbb.startTable(4);
          fbb.addInt64(0, object.id);
          fbb.addOffset(1, titleOffset);
          fbb.addBool(2, object.completed);
          fbb.finish(fbb.endTable());
          return object.id;
        },
        objectFromFB: (Store store, ByteData fbData) {
          final buffer = fb.BufferContext(fbData);
          final rootOffset = buffer.derefObject(0);

          final object = Todo(
              id: const fb.Int64Reader().vTableGet(buffer, rootOffset, 4, 0),
              title: const fb.StringReader(asciiOptimization: true)
                  .vTableGetNullable(buffer, rootOffset, 6),
              completed: const fb.BoolReader()
                  .vTableGetNullable(buffer, rootOffset, 8));

          return object;
        })
  };

  return ModelDefinition(model, bindings);
}

/// [LocationHistory] entity fields to define ObjectBox queries.
class LocationHistory_ {
  /// see [LocationHistory.id]
  static final id =
      QueryIntegerProperty<LocationHistory>(_entities[0].properties[0]);

  /// see [LocationHistory.lat]
  static final lat =
      QueryDoubleProperty<LocationHistory>(_entities[0].properties[1]);

  /// see [LocationHistory.long]
  static final long =
      QueryDoubleProperty<LocationHistory>(_entities[0].properties[2]);

  /// see [LocationHistory.customerId]
  static final customerId =
      QueryStringProperty<LocationHistory>(_entities[0].properties[3]);

  /// see [LocationHistory.reading]
  static final reading =
      QueryRelationToOne<LocationHistory, Reading>(_entities[0].properties[4]);
}

/// [Reading] entity fields to define ObjectBox queries.
class Reading_ {
  /// see [Reading.id]
  static final id = QueryIntegerProperty<Reading>(_entities[1].properties[0]);

  /// see [Reading.meterReadingUnit]
  static final meterReadingUnit =
      QueryStringProperty<Reading>(_entities[1].properties[1]);

  /// see [Reading.status]
  static final status =
      QueryBooleanProperty<Reading>(_entities[1].properties[2]);

  /// see [Reading.meterReading]
  static final meterReading =
      QueryDoubleProperty<Reading>(_entities[1].properties[3]);

  /// see [Reading.readingDate]
  static final readingDate =
      QueryIntegerProperty<Reading>(_entities[1].properties[4]);

  /// see [Reading.hasPhoto]
  static final hasPhoto =
      QueryIntegerProperty<Reading>(_entities[1].properties[5]);

  /// see [Reading.fieldPhoto]
  static final fieldPhoto =
      QueryStringProperty<Reading>(_entities[1].properties[6]);

  /// see [Reading.portion]
  static final portion =
      QueryStringProperty<Reading>(_entities[1].properties[7]);

  /// see [Reading.meterReader]
  static final meterReader =
      QueryStringProperty<Reading>(_entities[1].properties[8]);

  /// see [Reading.legacyAccNo]
  static final legacyAccNo =
      QueryStringProperty<Reading>(_entities[1].properties[9]);

  /// see [Reading.businessPartner]
  static final businessPartner =
      QueryStringProperty<Reading>(_entities[1].properties[10]);

  /// see [Reading.businessPartnerName]
  static final businessPartnerName =
      QueryStringProperty<Reading>(_entities[1].properties[11]);

  /// see [Reading.installation]
  static final installation =
      QueryStringProperty<Reading>(_entities[1].properties[12]);

  /// see [Reading.device]
  static final device =
      QueryStringProperty<Reading>(_entities[1].properties[13]);

  /// see [Reading.register]
  static final register =
      QueryIntegerProperty<Reading>(_entities[1].properties[14]);

  /// see [Reading.scheduledMRDate]
  static final scheduledMRDate =
      QueryStringProperty<Reading>(_entities[1].properties[15]);

  /// see [Reading.unitOfMeasure]
  static final unitOfMeasure =
      QueryStringProperty<Reading>(_entities[1].properties[16]);

  /// see [Reading.rateCategory]
  static final rateCategory =
      QueryStringProperty<Reading>(_entities[1].properties[17]);

  /// see [Reading.meterReadingNote]
  static final meterReadingNote =
      QueryStringProperty<Reading>(_entities[1].properties[18]);
}

/// [Todo] entity fields to define ObjectBox queries.
class Todo_ {
  /// see [Todo.id]
  static final id = QueryIntegerProperty<Todo>(_entities[2].properties[0]);

  /// see [Todo.title]
  static final title = QueryStringProperty<Todo>(_entities[2].properties[1]);

  /// see [Todo.completed]
  static final completed =
      QueryBooleanProperty<Todo>(_entities[2].properties[2]);
}
