import '../database.dart';

class PointsRulesTable extends SupabaseTable<PointsRulesRow> {
  @override
  String get tableName => 'points_rules';

  @override
  PointsRulesRow createRow(Map<String, dynamic> data) => PointsRulesRow(data);
}

class PointsRulesRow extends SupabaseDataRow {
  PointsRulesRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => PointsRulesTable();

  String get id => getField<String>('id')!;
  set id(String value) => setField<String>('id', value);

  String get tournamentId => getField<String>('tournament_id')!;
  set tournamentId(String value) => setField<String>('tournament_id', value);

  int get pointsCorrectMatchWinner =>
      getField<int>('points_correct_match_winner')!;
  set pointsCorrectMatchWinner(int value) =>
      setField<int>('points_correct_match_winner', value);

  int get pointsCorrectScoreline => getField<int>('points_correct_scoreline')!;
  set pointsCorrectScoreline(int value) =>
      setField<int>('points_correct_scoreline', value);

  int get pointsCorrectCupWinner => getField<int>('points_correct_cup_winner')!;
  set pointsCorrectCupWinner(int value) =>
      setField<int>('points_correct_cup_winner', value);

  DateTime get createdAt => getField<DateTime>('created_at')!;
  set createdAt(DateTime value) => setField<DateTime>('created_at', value);
}
