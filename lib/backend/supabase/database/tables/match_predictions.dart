import '../database.dart';

class MatchPredictionsTable extends SupabaseTable<MatchPredictionsRow> {
  @override
  String get tableName => 'match_predictions';

  @override
  MatchPredictionsRow createRow(Map<String, dynamic> data) =>
      MatchPredictionsRow(data);
}

class MatchPredictionsRow extends SupabaseDataRow {
  MatchPredictionsRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => MatchPredictionsTable();

  String get id => getField<String>('id')!;
  set id(String value) => setField<String>('id', value);

  String get userId => getField<String>('user_id')!;
  set userId(String value) => setField<String>('user_id', value);

  String get matchId => getField<String>('match_id')!;
  set matchId(String value) => setField<String>('match_id', value);

  String? get predictedWinnerTeamId =>
      getField<String>('predicted_winner_team_id');
  set predictedWinnerTeamId(String? value) =>
      setField<String>('predicted_winner_team_id', value);

  int? get predictedHomeScore => getField<int>('predicted_home_score');
  set predictedHomeScore(int? value) =>
      setField<int>('predicted_home_score', value);

  int? get predictedAwayScore => getField<int>('predicted_away_score');
  set predictedAwayScore(int? value) =>
      setField<int>('predicted_away_score', value);

  DateTime get createdAt => getField<DateTime>('created_at')!;
  set createdAt(DateTime value) => setField<DateTime>('created_at', value);
}
