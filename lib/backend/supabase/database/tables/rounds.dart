import '../database.dart';

class RoundsTable extends SupabaseTable<RoundsRow> {
  @override
  String get tableName => 'rounds';

  @override
  RoundsRow createRow(Map<String, dynamic> data) => RoundsRow(data);
}

class RoundsRow extends SupabaseDataRow {
  RoundsRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => RoundsTable();

  String get id => getField<String>('id')!;
  set id(String value) => setField<String>('id', value);

  String get tournamentId => getField<String>('tournament_id')!;
  set tournamentId(String value) => setField<String>('tournament_id', value);

  String get name => getField<String>('name')!;
  set name(String value) => setField<String>('name', value);

  int get sortOrder => getField<int>('sort_order')!;
  set sortOrder(int value) => setField<int>('sort_order', value);

  DateTime get createdAt => getField<DateTime>('created_at')!;
  set createdAt(DateTime value) => setField<DateTime>('created_at', value);
}
