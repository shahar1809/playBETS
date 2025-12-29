import '../database.dart';

class MatchesWithTeamsTable extends SupabaseTable<MatchesWithTeamsRow> {
  @override
  String get tableName => 'matches_with_teams';

  @override
  MatchesWithTeamsRow createRow(Map<String, dynamic> data) =>
      MatchesWithTeamsRow(data);
}

class MatchesWithTeamsRow extends SupabaseDataRow {
  MatchesWithTeamsRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => MatchesWithTeamsTable();

  String? get id => getField<String>('id');
  set id(String? value) => setField<String>('id', value);

  DateTime? get startsAt => getField<DateTime>('starts_at');
  set startsAt(DateTime? value) => setField<DateTime>('starts_at', value);

  DateTime? get lockAt => getField<DateTime>('lock_at');
  set lockAt(DateTime? value) => setField<DateTime>('lock_at', value);

  String? get status => getField<String>('status');
  set status(String? value) => setField<String>('status', value);

  String? get homeTeamShort => getField<String>('home_team_short');
  set homeTeamShort(String? value) =>
      setField<String>('home_team_short', value);

  String? get awayTeamShort => getField<String>('away_team_short');
  set awayTeamShort(String? value) =>
      setField<String>('away_team_short', value);

  String? get homeLogo => getField<String>('home_logo');
  set homeLogo(String? value) => setField<String>('home_logo', value);

  String? get awayLogo => getField<String>('away_logo');
  set awayLogo(String? value) => setField<String>('away_logo', value);
}
