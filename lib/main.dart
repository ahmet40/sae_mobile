import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'modele/modele_local/bd/database.dart';
import 'modele/modele_supabase/bd/utilistaeurService.dart';
import './page/connexion.dart';

const supabaseurl = 'https://kucvmvquijdxvngmgdjb.supabase.co';
const apikey =
    'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imt1Y3ZtdnF1aWpkeHZuZ21nZGpiIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MTI0OTkwMjYsImV4cCI6MjAyODA3NTAyNn0.imnxBVUYFsbp5DVINZiH9grqFlPIbUWc_dA7trfmtLk';

final supabase = Supabase.instance.client;
Future<void> main() async {
  await Supabase.initialize(url: supabaseurl, anonKey: apikey);
  DatabaseService.instance.database;
  runApp(Connexion());
}

