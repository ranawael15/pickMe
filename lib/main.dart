import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:pick_me/pick_me_app.dart';

import 'core/config/supabase_config.dart';
import 'core/theme/cubit/theme_cubit.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: SupabaseConfig.supabaseUrl,
    publishableKey: SupabaseConfig.supabasepublishableKey,
  );

  runApp(
    BlocProvider(create: (context) => ThemeCubit(), child: const PickMeApp()),
  );
}
