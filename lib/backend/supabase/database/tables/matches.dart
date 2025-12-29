import '../database.dart';

class MatchesTable extends SupabaseTable<MatchesRow> {
  @override
  String get tableName => 'matches';

  @override
  MatchesRow createRow(Map<String, dynamic> data) => MatchesRow(data);
}

class MatchesRow extends SupabaseDataRow {
  MatchesRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => MatchesTable();

  String get id => getField<String>('id')!;
  set id(String value) => setField<String>('id', value);

  String get tournamentId => getField<String>('tournament_id')!;
  set tournamentId(String value) => setField<String>('tournament_id', value);

  String get roundId => getField<String>('round_id')!;
  set roundId(String value) => setField<String>('round_id', value);

  DateTime get startsAt => getField<DateTime>('starts_at')!;
  set startsAt(DateTime value) => setField<DateTime>('starts_at', value);

  DateTime get lockAt => getField<DateTime>('lock_at')!;
  set lockAt(DateTime value) => setField<DateTime>('lock_at', value);

  String get status => getField<String>('status')!;
  set status(String value) => setField<String>('status', value);

  int? get homeScore => getField<int>('home_score');
  set homeScore(int? value) => setField<int>('home_score', value);

  int? get awayScore => getField<int>('away_score');
  set awayScore(int? value) => setField<int>('away_score', value);

  String? get winnerTeamShort => getField<String>('winner_team_short');
  set winnerTeamShort(String? value) =>
      setField<String>('winner_team_short', value);

  DateTime get createdAt => getField<DateTime>('created_at')!;
  set createdAt(DateTime value) => setField<DateTime>('created_at', value);

  String? get homeTeamShort => getField<String>('home_team_short');
  set homeTeamShort(String? value) =>
      setField<String>('home_team_short', value);

  String? get awayTeamShort => getField<String>('away_team_short');
  set awayTeamShort(String? value) =>
      setField<String>('away_team_short', value);
}
