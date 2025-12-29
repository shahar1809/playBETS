import '../database.dart';

class UserPointsTable extends SupabaseTable<UserPointsRow> {
  @override
  String get tableName => 'user_points';

  @override
  UserPointsRow createRow(Map<String, dynamic> data) => UserPointsRow(data);
}

class UserPointsRow extends SupabaseDataRow {
  UserPointsRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => UserPointsTable();

  String get tournamentId => getField<String>('tournament_id')!;
  set tournamentId(String value) => setField<String>('tournament_id', value);

  String get userId => getField<String>('user_id')!;
  set userId(String value) => setField<String>('user_id', value);

  int get points => getField<int>('points')!;
  set points(int value) => setField<int>('points', value);

  DateTime get updatedAt => getField<DateTime>('updated_at')!;
  set updatedAt(DateTime value) => setField<DateTime>('updated_at', value);
}
