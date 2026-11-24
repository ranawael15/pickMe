import 'package:flutter/material.dart';
import 'package:pick_me/features/auth/logic/provider/auth_provider.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:pick_me/pick_me_app.dart';

import 'core/config/supabase_config.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: SupabaseConfig.supabaseUrl,
    publishableKey: SupabaseConfig.supabasepublishableKey,
  );

  runApp(ChangeNotifierProvider(
      create: (context) => AuthProvider(),
      child: const PickMeApp()));
}
