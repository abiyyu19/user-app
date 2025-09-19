/*
  source: 
  - https://drift.simonbinder.eu/setup/#database-class
  - https://drift.simonbinder.eu/dart_api/tables/#defining-tables
*/

import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:path_provider/path_provider.dart';

part 'app_drift.g.dart';

class LocalUsers extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get email => text()();
  TextColumn get username => text()();
  TextColumn get password => text()();
  TextColumn get avatar => text()();
}

@DriftDatabase(tables: [LocalUsers])
class AppDatabase extends _$AppDatabase {
  AppDatabase([final QueryExecutor? executor]) : super(executor ?? _openConnection());

  @override
  int get schemaVersion => 1;

  static QueryExecutor _openConnection() => driftDatabase(
    name: 'my_database',
    native: const DriftNativeOptions(
      // By default, `driftDatabase` from `package:drift_flutter` stores the
      // database files in `getApplicationDocumentsDirectory()`.
      databaseDirectory: getApplicationSupportDirectory,
    ),
    // If you need web support, see https://drift.simonbinder.eu/platforms/web/
  );

  Future<List<LocalUser>> get allUsers => select(localUsers).get();
}
