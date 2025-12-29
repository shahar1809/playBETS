import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'match_guess_row_widget.dart' show MatchGuessRowWidget;
import 'package:flutter/material.dart';

class MatchGuessRowModel extends FlutterFlowModel<MatchGuessRowWidget> {
  ///  Local state fields for this component.

  String? homeShort;

  String? awayShort;

  String? homeLogoUrl;

  String? awayLogoUrl;

  ///  State fields for stateful widgets in this component.

  // State field(s) for homeGuess widget.
  FocusNode? homeGuessFocusNode;
  TextEditingController? homeGuessTextController;
  String? Function(BuildContext, String?)? homeGuessTextControllerValidator;
  // Stores action output result for [Backend Call - Query Rows] action in homeGuess widget.
  List<MatchPredictionsRow>? queryResult;
  // State field(s) for awayGuess widget.
  FocusNode? awayGuessFocusNode;
  TextEditingController? awayGuessTextController;
  String? Function(BuildContext, String?)? awayGuessTextControllerValidator;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    homeGuessFocusNode?.dispose();
    homeGuessTextController?.dispose();

    awayGuessFocusNode?.dispose();
    awayGuessTextController?.dispose();
  }
}
