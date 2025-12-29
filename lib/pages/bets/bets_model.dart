import '/backend/supabase/supabase.dart';
import '/components/match_guess_row_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'bets_widget.dart' show BetsWidget;
import 'package:flutter/material.dart';

class BetsModel extends FlutterFlowModel<BetsWidget> {
  ///  State fields for stateful widgets in this page.

  Stream<List<MatchesWithTeamsRow>>? listViewSupabaseStream;
  // Models for MatchGuessRow dynamic component.
  late FlutterFlowDynamicModels<MatchGuessRowModel> matchGuessRowModels;

  @override
  void initState(BuildContext context) {
    matchGuessRowModels = FlutterFlowDynamicModels(() => MatchGuessRowModel());
  }

  @override
  void dispose() {
    matchGuessRowModels.dispose();
  }
}
