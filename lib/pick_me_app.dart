import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pick_me/features/admin/home_admin.dart';
import 'package:pick_me/features/admin/profile/admin_profile.dart';
import 'package:pick_me/features/auth/logic/provider/auth_provider.dart';
import 'package:pick_me/features/auth/presentation/screens/forget_password.dart';
import 'package:pick_me/features/auth/presentation/screens/login_screen.dart';
import 'package:pick_me/features/auth/presentation/screens/register_Screen.dart';
import 'package:pick_me/features/auth/presentation/screens/splash_screen.dart';
import 'package:pick_me/features/home/presentation/screens/home_screen.dart';
import 'package:pick_me/features/home/trip_request/logic/cubit/trip_request_cubit.dart';
import 'package:pick_me/features/profile/presentation/screens/edit_profile.dart';
import 'package:pick_me/features/profile/presentation/screens/profile_screen.dart';
import 'package:pick_me/features/trip_history/presentation/screens/trip_history_screen.dart';
import 'package:pick_me/features/trip_planning/data/repos/place_repo.dart';
import 'package:pick_me/features/trip_planning/logic/cubit/trip_planning_cubit.dart';
import 'package:pick_me/features/trip_planning/logic/planner_service.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class PickMeApp extends StatelessWidget {
  const PickMeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(393, 852),
      minTextAdapt: true,
      splitScreenMode: true,

      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => AuthProvider(),
          ),
        ],

        child: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => TripRequestCubit(),
            ),

            BlocProvider(
              create: (context) => PlannerCubit(
                placeRepository: PlaceRepository(
                  supabase: Supabase.instance.client,
                ),
                plannerService: PlannerService(),
              ),
            ),
          ],

          child: MaterialApp(
            debugShowCheckedModeBanner: false,

            routes: {
              '/login': (context) => LoginScreen(),

              '/register': (context) => RegisterScreen(),

              '/home': (context) => const HomeScreen(),

              '/admin': (context) {
                return HomeAdmin();
              },
              "/profile":(context) =>
              const ProfileScreen(),
              "/admin_profile":(context) =>
              const AdminProfile(),

              "/edit_profile":(context) =>
               EditProfile(),
              "/trip_history":(context) =>
               TripHistory(),

              '/forgot-password': (context) =>
              const ForgotPasswordScreen(),
            },

            home: SplashScreen(),
          ),
        ),
      ),
    );
  }
}