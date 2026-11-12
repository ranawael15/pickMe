import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:pick_me/features/home/presentation/screens/home_screen.dart';
import 'package:pick_me/core/theme/app_theme.dart';
import 'package:pick_me/core/theme/cubit/theme_cubit.dart';
import 'package:pick_me/core/theme/cubit/theme_state.dart';
import 'generated/l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PickMeApp extends StatelessWidget {
  const PickMeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(393, 852),
      minTextAdapt: true,
      splitScreenMode: true,

      child: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,

            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: state.themeMode,

            supportedLocales: const [Locale('en'), Locale('ar')],

            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],

            home: HomeScreen(),
          );
        },
      ),
    );
  }
}
