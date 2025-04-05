import 'package:drift/drift.dart';

class AccountDetailsTable extends Table {
  IntColumn get id => integer()();
  TextColumn get username => text()();
  TextColumn get profilePath => text().nullable()();

  @override
  Set<Column<Object>>? get primaryKey => {id};
}
