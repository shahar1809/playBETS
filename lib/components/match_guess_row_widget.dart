import '/auth/supabase_auth/auth_util.dart';
import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'match_guess_row_model.dart';
export 'match_guess_row_model.dart';

class MatchGuessRowWidget extends StatefulWidget {
  const MatchGuessRowWidget({
    super.key,
    required this.matchId,
    this.homeShort,
    this.awayShort,
    this.homeLogoUrl,
    this.awayLogoUrl,
  });

  final String matchId; // <-- make non-null (you already pass id!)
  final String? homeShort;
  final String? awayShort;
  final String? homeLogoUrl;
  final String? awayLogoUrl;

  @override
  State<MatchGuessRowWidget> createState() => _MatchGuessRowWidgetState();
}

class _MatchGuessRowWidgetState extends State<MatchGuessRowWidget> {
  late MatchGuessRowModel _model;

  bool _loaded = false;
  MatchPredictionsRow? _existingPrediction;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => MatchGuessRowModel());

    // Don't hardcode "0" here forever. We'll load real values from Supabase.
    _model.homeGuessTextController ??= TextEditingController();
    _model.homeGuessFocusNode ??= FocusNode();

    _model.awayGuessTextController ??= TextEditingController();
    _model.awayGuessFocusNode ??= FocusNode();

    _loadExistingPrediction();
  }

  Future<void> _loadExistingPrediction() async {
    // If not logged in yet, just default to 0.
    if (currentUserUid.isEmpty) {
      _model.homeGuessTextController.text = '0';
      _model.awayGuessTextController.text = '0';
      safeSetState(() => _loaded = true);
      return;
    }

    final rows = await MatchPredictionsTable().queryRows(
      queryFn: (q) => q
          .eq('user_id', currentUserUid)
          .eq('match_id', widget.matchId)
          .limit(1),
    );

    _existingPrediction = rows.isNotEmpty ? rows.first : null;

    // Populate the fields from DB (or default to 0)
    _model.homeGuessTextController.text =
        (_existingPrediction?.predictedHomeScore ?? 0).toString();
    _model.awayGuessTextController.text =
        (_existingPrediction?.predictedAwayScore ?? 0).toString();

    safeSetState(() => _loaded = true);
  }

  int _parseScore(String s) {
    // keep it safe: empty/non-numeric => 0
    return int.tryParse(s.trim()) ?? 0;
  }

  Future<void> _savePrediction() async {
    if (currentUserUid.isEmpty) return;

    final home = _parseScore(_model.homeGuessTextController.text);
    final away = _parseScore(_model.awayGuessTextController.text);

    // If we already have a row -> update
    if (_existingPrediction != null) {
      await MatchPredictionsTable().update(
        data: {
          'predicted_home_score': home,
          'predicted_away_score': away,
        },
        matchingRows: (rows) => rows
            .eq('user_id', currentUserUid)
            .eq('match_id', widget.matchId),
      );
      return;
    }

    // Otherwise insert new row, then keep local cache so we update next time
    await MatchPredictionsTable().insert({
      'user_id': currentUserUid,
      'match_id': widget.matchId,
      'predicted_home_score': home,
      'predicted_away_score': away,
    });

    // Refresh local cache so we don't keep inserting duplicates
    final rows = await MatchPredictionsTable().queryRows(
      queryFn: (q) => q
          .eq('user_id', currentUserUid)
          .eq('match_id', widget.matchId)
          .limit(1),
    );
    _existingPrediction = rows.isNotEmpty ? rows.first : null;
  }

  void _debouncedSave(String key) {
    EasyDebounce.debounce(
      key,
      const Duration(milliseconds: 600),
      () async {
        await _savePrediction();
      },
    );
  }

  @override
  void dispose() {
    _model.maybeDispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // While loading, still render — but avoid overwriting controllers.
    // (_loaded only matters if you want to show a shimmer/spinner. Optional.)
    return Container(
      width: 425.45,
      height: 100.0,
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).secondaryBackground,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(10.0, 0.0, 0.0, 0.0),
            child: Container(
              width: 40.0,
              height: 40.0,
              clipBehavior: Clip.antiAlias,
              decoration: const BoxDecoration(shape: BoxShape.circle),
              child: Image.network(
                widget.homeLogoUrl ?? '',
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => const SizedBox.shrink(),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(5.0, 0.0, 0.0, 0.0),
            child: Text(
              valueOrDefault<String>(widget.homeShort, 'home'),
              style: FlutterFlowTheme.of(context).bodyMedium.override(
                    font: GoogleFonts.inter(),
                    letterSpacing: 0.0,
                  ),
            ),
          ),

          // HOME SCORE
          Expanded(
            child: SizedBox(
              width: 200.0,
              child: TextFormField(
                controller: _model.homeGuessTextController,
                focusNode: _model.homeGuessFocusNode,
                onChanged: (_) => _debouncedSave('home_${widget.matchId}'),
                onEditingComplete: () async {
                  await _savePrediction();
                  FocusScope.of(context).unfocus();
                },
                onFieldSubmitted: (_) async {
                  await _savePrediction();
                },
                keyboardType: TextInputType.number,
                autofocus: false,
                enabled: true,
                decoration: InputDecoration(
                  isDense: true,
                  hintText: '0',
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Color(0x00000000)),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Color(0x00000000)),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  filled: true,
                  fillColor: FlutterFlowTheme.of(context).secondaryBackground,
                ),
                style: FlutterFlowTheme.of(context).bodyMedium.override(
                      font: GoogleFonts.inter(),
                      letterSpacing: 0.0,
                    ),
                textAlign: TextAlign.center,
                cursorColor: FlutterFlowTheme.of(context).primaryText,
                validator:
                    _model.homeGuessTextControllerValidator.asValidator(context),
              ),
            ),
          ),

          // AWAY SCORE
          Expanded(
            child: SizedBox(
              width: 200.0,
              child: TextFormField(
                controller: _model.awayGuessTextController,
                focusNode: _model.awayGuessFocusNode,
                onChanged: (_) => _debouncedSave('away_${widget.matchId}'),
                onEditingComplete: () async {
                  await _savePrediction();
                  FocusScope.of(context).unfocus();
                },
                onFieldSubmitted: (_) async {
                  await _savePrediction();
                },
                keyboardType: TextInputType.number,
                autofocus: false,
                enabled: true,
                decoration: InputDecoration(
                  isDense: true,
                  hintText: '0',
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Color(0x00000000)),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Color(0x00000000)),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  filled: true,
                  fillColor: FlutterFlowTheme.of(context).secondaryBackground,
                ),
                style: FlutterFlowTheme.of(context).bodyMedium.override(
                      font: GoogleFonts.inter(),
                      letterSpacing: 0.0,
                    ),
                textAlign: TextAlign.center,
                cursorColor: FlutterFlowTheme.of(context).primaryText,
                validator:
                    _model.awayGuessTextControllerValidator.asValidator(context),
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 5.0, 0.0),
            child: Text(
              valueOrDefault<String>(widget.awayShort, 'away'),
              style: FlutterFlowTheme.of(context).bodyMedium.override(
                    font: GoogleFonts.inter(),
                    letterSpacing: 0.0,
                  ),
            ),
          ),
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 10.0, 0.0),
            child: Container(
              width: 40.0,
              height: 40.0,
              clipBehavior: Clip.antiAlias,
              decoration: const BoxDecoration(shape: BoxShape.circle),
              child: Image.network(
                widget.awayLogoUrl ?? '',
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => const SizedBox.shrink(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
