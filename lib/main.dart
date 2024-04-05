import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'modele/modele_local/bd/database.dart';
import 'modele/modele_supabase/bd/utilistaeurService.dart';
import './page/connexion.dart';

const supabaseurl = 'https://ivqvbkryvyegommrevcf.supabase.co';
const apikey =
    'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Iml2cXZia3J5dnllZ29tbXJldmNmIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MTE2MjA2MDUsImV4cCI6MjAyNzE5NjYwNX0.yjdkuxy3_aa_cu63s37g9HWrVg0RDESciv0NQsV4gsU';

final supabase = Supabase.instance.client;
Future<void> main() async {
  await Supabase.initialize(url: supabaseurl, anonKey: apikey);
  DatabaseService.instance.database;
  runApp(Connexion());
}

