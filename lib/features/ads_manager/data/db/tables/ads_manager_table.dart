import 'package:drift/drift.dart';

class AdsManagerTable extends Table {
  IntColumn get id => integer()();
  IntColumn get functionCallCount => integer()();

  @override
  Set<Column<Object>>? get primaryKey => {id};
}
