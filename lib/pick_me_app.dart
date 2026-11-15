
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:pick_me/features/admin/home_admin.dart';
import 'package:pick_me/features/auth/logic/cubit/auth_cubit.dart' hide AuthState;
import 'package:pick_me/features/auth/presentation/screens/forget_password.dart';
import 'package:pick_me/features/auth/presentation/screens/login_screen.dart';
import 'package:pick_me/features/auth/presentation/screens/register_Screen.dart';
import 'package:pick_me/features/auth/presentation/screens/reset_password_screen.dart';
import 'package:pick_me/features/auth/presentation/screens/splash_screen.dart';
import 'package:pick_me/features/home/presentation/screens/home_screen.dart';

import 'package:pick_me/core/theme/app_theme.dart';
import 'package:pick_me/core/theme/cubit/theme_cubit.dart';
import 'package:pick_me/core/theme/cubit/theme_state.dart';

import 'generated/l10n/app_localizations.dart';

final GlobalKey<NavigatorState> navigatorKey =
GlobalKey<NavigatorState>();

class PickMeApp extends StatefulWidget {
  const PickMeApp({super.key});

  @override
  State<PickMeApp> createState() => _PickMeAppState();
}

class _PickMeAppState extends State<PickMeApp> {
  StreamSubscription<AuthState>? authSubscription;

  @override
  void initState() {
    super.initState();

    authSubscription =
        Supabase.instance.client.auth.onAuthStateChange.listen(
              (data) {
            debugPrint('Auth Event: ${data.event}');

            if (data.event == AuthChangeEvent.passwordRecovery) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                navigatorKey.currentState?.pushNamedAndRemoveUntil(
                  '/reset-password',
                      (route) => false,
                );
              });
            }
          },
          onError: (error, stackTrace) {
            debugPrint('Auth state error: $error');
          },
        );
  }

  @override
  void dispose() {
    authSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(393, 852),
      minTextAdapt: true,
      splitScreenMode: true,

      child: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, state) {
          return MaterialApp(
            navigatorKey: navigatorKey,
            debugShowCheckedModeBanner: false,

            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: state.themeMode,

            supportedLocales: const [
              Locale('en'),
              Locale('ar'),
            ],

            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],

            routes: {
              '/login': (context) => LoginScreen(),

              '/register': (context) => RegisterScreen(),

              '/home': (context) {
                final userName =
                    ModalRoute.of(context)!.settings.arguments as String? ??
                        'User';

                return HomeScreen(userName: userName);
              },

              '/admin': (context) {
                final userName =
                    ModalRoute.of(context)!.settings.arguments as String? ??
                        'Admin';

                return HomeAdmin(userName: userName);
              },

              '/forgot-password': (context) =>
              const ForgotPasswordScreen(),

              '/reset-password': (context) =>
              const ResetPasswordScreen(),
            },

            home: SplashScreen(),
          );
        },
      ),
    );
  }
}
