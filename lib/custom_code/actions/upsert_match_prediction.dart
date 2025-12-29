// Automatic FlutterFlow imports
import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

// an action that will check if a row exists in supabase, based on match id and user id uniqeness, if it exists update the homescore and awayscore it, if not - insert
import 'package:supabase_flutter/supabase_flutter.dart';

Future upsertMatchPrediction(
  String? matchId,
  String? homeScore,
  String? awayScore,
) async {
  if (matchId == null || homeScore == null || awayScore == null) {
    throw Exception('Match ID, home score, and away score cannot be null');
  }

  final supabase = Supabase.instance.client;
  final userId = supabase.auth.currentUser?.id;

  if (userId == null) {
    throw Exception('User must be authenticated');
  }

  try {
    // Check if prediction already exists
    final existingPrediction = await supabase
        .from('match_predictions')
        .select()
        .eq('match_id', matchId)
        .eq('user_id', userId)
        .maybeSingle();

    if (existingPrediction != null) {
      // Update existing prediction
      await supabase
          .from('match_predictions')
          .update({
            'home_score': int.parse(homeScore),
            'away_score': int.parse(awayScore),
            'updated_at': DateTime.now().toIso8601String(),
          })
          .eq('match_id', matchId)
          .eq('user_id', userId);
    } else {
      // Insert new prediction
      await supabase.from('match_predictions').insert({
        'match_id': matchId,
        'user_id': userId,
        'home_score': int.parse(homeScore),
        'away_score': int.parse(awayScore),
        'created_at': DateTime.now().toIso8601String(),
        'updated_at': DateTime.now().toIso8601String(),
      });
    }
  } catch (e) {
    throw Exception('Failed to upsert match prediction: $e');
  }
}
