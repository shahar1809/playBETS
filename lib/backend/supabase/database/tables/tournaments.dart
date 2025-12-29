import '../database.dart';

class TournamentsTable extends SupabaseTable<TournamentsRow> {
  @override
  String get tableName => 'tournaments';

  @override
  TournamentsRow createRow(Map<String, dynamic> data) => TournamentsRow(data);
}

class TournamentsRow extends SupabaseDataRow {
  TournamentsRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => TournamentsTable();

  String get id => getField<String>('id')!;
  set id(String value) => setField<String>('id', value);

  String get name => getField<String>('name')!;
  set name(String value) => setField<String>('name', value);

  String get season => getField<String>('season')!;
  set season(String value) => setField<String>('season', value);

  DateTime get startsAt => getField<DateTime>('starts_at')!;
  set startsAt(DateTime value) => setField<DateTime>('starts_at', value);

  DateTime? get endsAt => getField<DateTime>('ends_at');
  set endsAt(DateTime? value) => setField<DateTime>('ends_at', value);

  String? get winnerTeamId => getField<String>('winner_team_id');
  set winnerTeamId(String? value) => setField<String>('winner_team_id', value);

  DateTime get createdAt => getField<DateTime>('created_at')!;
  set createdAt(DateTime value) => setField<DateTime>('created_at', value);
}
