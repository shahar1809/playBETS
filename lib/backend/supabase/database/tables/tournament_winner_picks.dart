import '../database.dart';

class TournamentWinnerPicksTable
    extends SupabaseTable<TournamentWinnerPicksRow> {
  @override
  String get tableName => 'tournament_winner_picks';

  @override
  TournamentWinnerPicksRow createRow(Map<String, dynamic> data) =>
      TournamentWinnerPicksRow(data);
}

class TournamentWinnerPicksRow extends SupabaseDataRow {
  TournamentWinnerPicksRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => TournamentWinnerPicksTable();

  String get id => getField<String>('id')!;
  set id(String value) => setField<String>('id', value);

  String get userId => getField<String>('user_id')!;
  set userId(String value) => setField<String>('user_id', value);

  String get tournamentId => getField<String>('tournament_id')!;
  set tournamentId(String value) => setField<String>('tournament_id', value);

  String get pickedTeamId => getField<String>('picked_team_id')!;
  set pickedTeamId(String value) => setField<String>('picked_team_id', value);

  DateTime get createdAt => getField<DateTime>('created_at')!;
  set createdAt(DateTime value) => setField<DateTime>('created_at', value);
}
