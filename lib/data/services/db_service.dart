import '../entities/entities_exports.dart';

import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

const schemas = [
  TaskEntitySchema,
  ArchivedTaskEntitySchema,
  CategoryEntitySchema,
  FinishedTaskEntitySchema,
  OverdueTaskEntitySchema,
  RepeatedTaskEntitySchema
];

class DbService {
  static final dbService = DbService._();

  static late Isar _db;

  static Future<void> initDb() async {
    final dir = await getApplicationDocumentsDirectory();

    _db = await Isar.open(
      schemas,
      directory: dir.path,
    );
  }

  DbService._();
}

final db = DbService._db;
