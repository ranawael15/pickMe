import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pick_me/features/trip_history/services/trip_history_services.dart';

class TestScreen extends StatefulWidget {
  const TestScreen({super.key});

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  final TripService tripService = TripService();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: tripService.getTripDetails("b9fb10c2-3ac5-4959-bc57-88f5bc79016b"),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (snapshot.hasError) {
          return Center(
            child: Text('Error: ${snapshot.error}'),
          );
        }

        final allTrips = snapshot.data ?? [];
        print(allTrips);




        if (allTrips.isEmpty) {
          return const Center(
            child: Text('No trips found'),
          );
        }


        return Scaffold(body: Container());
      }
    );
  }
}
