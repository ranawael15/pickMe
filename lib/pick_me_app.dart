import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:pick_me/features/admin/home_admin.dart';
import 'package:pick_me/features/auth/presentation/screens/forget_password.dart';
import 'package:pick_me/features/auth/presentation/screens/login_screen.dart';
import 'package:pick_me/features/auth/presentation/screens/register_Screen.dart';
import 'package:pick_me/features/auth/presentation/screens/splash_screen.dart';
import 'package:pick_me/features/home/presentation/screens/home_screen.dart';

import 'features/home/trip_request/logic/cubit/trip_request_cubit.dart';

import 'features/trip_planning/data/repos/place_repo.dart';
import 'features/trip_planning/logic/cubit/trip_planning_cubit.dart';
import 'features/trip_planning/logic/planner_service.dart';
import 'package:pick_me/features/admin/destinations/logic/cubit/destinations_cubit.dart';
import 'package:pick_me/features/admin/dashboard/presentation/screens/admin_dashboard_screen.dart';
import 'package:pick_me/features/admin/destinations/presentation/screens/destinations_screen.dart';
import 'package:pick_me/features/admin/destinations/presentation/screens/destination_form_screen.dart';

class PickMeApp extends StatelessWidget {
  const PickMeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(393, 852),
      minTextAdapt: true,
      splitScreenMode: true,
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => TripRequestCubit()),

          BlocProvider(
            create: (context) => PlannerCubit(
              placeRepository: PlaceRepository(
                supabase: Supabase.instance.client,
              ),
              plannerService: PlannerService(),
            ),
          ),
          BlocProvider(
            create: (context) => DestinationsCubit(),
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
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
              return AdminDashboardScreen(
                onNavigate: (index) {
                  if (index == 1) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const DestinationsScreen(),
                      ),
                    );
                  } else if (index == 2) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const DestinationFormScreen(),
                      ),
                    );
                  }
                },
              );
            },
            '/forgot-password': (context) => const ForgotPasswordScreen(),
          },
          home: SplashScreen(),
        ),
      ),
    );
  }
}
