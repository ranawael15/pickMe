import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pick_me/core/theme/app_colors.dart';
import 'package:pick_me/core/utils/auth_dialog.dart';
import 'package:pick_me/core/widgets/auth_button.dart';
import 'package:pick_me/features/trip_history/presentation/screens/test_screen.dart';
import 'package:pick_me/features/trip_history/services/trip_history_services.dart';

class TripHistory extends StatefulWidget {

  TripHistory({super.key});

  @override
  State<TripHistory> createState() => _TripHistoryState();
}

class _TripHistoryState extends State<TripHistory> {
  int selectedTab=0;
  final TripService tripService = TripService();
Future<void> completeTrip(String id) async {
  try {
    await tripService.updateTrip(id: id);

    if (!mounted) return;

   showAuthDialog(context, message: "Trip completed successfully!");

    setState(() {});
  } catch (e) {
    if (!mounted) return;

    showAuthDialog(context, message: "Something went wrong: $e");
  }
}
  @override
  Widget build(BuildContext context) {

    return DefaultTabController(
          animationDuration: Duration.zero,
          initialIndex: 0,
          length: 3,
          child: Scaffold(
            backgroundColor: AppColors.backgroundColor,
            appBar: AppBar(
              backgroundColor: AppColors.backgroundColor,
              title: Text("Trip history"),
            ),
            body: Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                spacing: 15,
                children: [
                  Text("All your planned journeys, bookings & completed\nEgyptian adventures"),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25
                      ),
                      color: Colors.white,
        
                    ),
                    child: TabBar(
                      splashFactory: NoSplash.splashFactory,
                      overlayColor: WidgetStateProperty.resolveWith<Color?>(
                            (Set<WidgetState> states) {
                          return states.contains(WidgetState.focused) ? null : Colors.transparent;
                        },
                      ),
                      labelColor: Colors.black,
                      unselectedLabelColor: Colors.black,
                      onTap: (index) {
                        selectedTab=index;
                        setState(() {
        
                        });
                      },
                      indicatorColor: Colors.transparent,
                      dividerColor: Colors.transparent,
                      tabs: <Widget>[
                        Tab(
                            child:Container(
                              padding: EdgeInsets.symmetric(vertical:7 ,horizontal: 15),
        
                              decoration: BoxDecoration(
                                  color: selectedTab==0?Color(0xffFFEEAB):Colors.transparent,
                                  borderRadius: BorderRadius.circular(25)
                              ),
                              child: Text("Confirmed",style: TextStyle(fontSize: 15),),
                            )
                        ),
                        Tab(
                            child:Container(
                              padding: EdgeInsets.symmetric(vertical: 7,horizontal: 15),
        
                              decoration: BoxDecoration(
                                  color: selectedTab==1?Color(0xffFFEEAB):Colors.transparent,
                                  borderRadius: BorderRadius.circular(25)
                              ),
                              child: Text("Cancelled",style: TextStyle(fontSize: 15)),
                            )
                        ),
                        Tab(
                            child:Container(
                              padding: EdgeInsets.symmetric(vertical: 7,horizontal: 15),

                              decoration: BoxDecoration(
                                  color: selectedTab==2?Color(0xffFFEEAB):Colors.transparent,
                                  borderRadius: BorderRadius.circular(25)
                              ),
                              child: Text("Completed",style: TextStyle(fontSize: 15)),
                            )
                        ),

        
                      ],
                    ),
                  ),
        
                  FutureBuilder(

                    future: tripService.getAllTrips(),
                    builder: (context, snapshot) {

                    if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                    child: CircularProgressIndicator(
                      color:AppColors.primary ,
                    ),
                    );
                    }

                    if (snapshot.hasError) {
                    return Center(
                    child: Text('Error: ${snapshot.error}'),
                    );
                    }

                    final allTrips = snapshot.data ?? [];




                    if (allTrips.isEmpty) {
                    return const Center(
                    child: Text('No trips found'),
                    );
                    }


                    final confirmedTrips = allTrips
                    .where((trip) => trip['status'] == 'Confirmed')
                    .toList();

                    final cancelledTrips = allTrips
                    .where((trip) => trip['status'] == 'Cancelled')
                    .toList();

                    final completedTrips = allTrips
                        .where((trip) => trip['status'] == 'Completed')
                        .toList();

                    print(completedTrips);



                    return Container(
                                            height: 550,
                        child:TabBarView(
                          physics: NeverScrollableScrollPhysics(),

                          children: <Widget>[

                            confirmedTrips.isEmpty
                                ? const Center(
                              child: Text('No trips found'),
                            )
                                : ListView.separated(
                                itemBuilder: (context, index) {
                                  final confirmedTrip = confirmedTrips[index];

                                  String rawDate = confirmedTrip["confirmed_at"];

                                  DateTime parsedDate = DateTime.parse(rawDate);

                                  String formattedDate = DateFormat('MMM d').format(parsedDate.toLocal());
                                  return Container(
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(25),
                                    color: Colors.white,

                                  ),
                                  child: FutureBuilder(
                                    future: tripService.getTripDetails(confirmedTrip["id"]),
                                    builder:  (context, snapshot) {
                                      if (snapshot.connectionState == ConnectionState.waiting) {
                                        return const Center(
                                          child: CircularProgressIndicator(
                                            color: AppColors.primary,
                                          ),
                                        );
                                      }

                                      if (snapshot.hasError) {
                                        return Center(
                                          child: Text('Error: ${snapshot.error}'),
                                        );
                                      }

                                      final confirmedTripPlaces = snapshot.data ?? [];

                                      return Row(
                                        children: [
                                          Image.asset("assets/images/pickme_small.png"),


                                                Expanded(
                                                  child: Column(
                                                  spacing: 5,
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      spacing:100,
                                                      children: [
                                                        Container(
                                                          padding: EdgeInsets.all(5),
                                                          decoration: BoxDecoration(
                                                              color: Color(0x66E9DBA0),
                                                              borderRadius: BorderRadius.circular(15)
                                                          ),
                                                          child: Row(
                                                            spacing: 5,
                                                            children: [
                                                              Icon(Icons.circle,size: 10,color: Color(0xff685E2F)),
                                                              Text("Completed",style: TextStyle(color: Color(0xff685E2F)),),
                                                            ],
                                                          ),
                                                        ),
                                                        Text(confirmedTrip["budget"].toString(),style: TextStyle(fontSize: 20,fontWeight: .bold),)

                                                      ],
                                                    ),
                                                    Text(confirmedTripPlaces.map((item) => '${item["place_name"]}').join(' & '),style: TextStyle(fontSize: 20,fontWeight: .bold)),
                                                    Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children: [
                                                        Text(formattedDate),
                                                        TextButton(
                                                            onPressed:(){
                                                              completeTrip(confirmedTrip["id"]);

                                                            },
                                                            child: Row(
                                                              children: [
                                                                Text("Mark as completed",
                                                                  style: TextStyle(
                                                                    color: AppColors.success
                                                                
                                                                  ),),
                                                                Icon(Icons.check,color: AppColors.success,)
                                                              ],
                                                            ))
                                                      ],
                                                    )
                                                  ],
                                                                                            ),
                                                )


                                        ],
                                      );
                                    }
                                  ),


                                ); },
                                separatorBuilder: (context, index) => SizedBox(
                                  height: 20,
                                ),
                                itemCount: confirmedTrips.length),


                            cancelledTrips.isEmpty
                                ? const Center(
                              child: Text('No trips found'),
                            )
                                :  ListView.separated(
                                itemBuilder: (context, index) {
                                  final canceledTrip = cancelledTrips[index];

                                  String rawDate = canceledTrip["confirmed_at"];

                                  DateTime parsedDate = DateTime.parse(rawDate);

                                  String formattedDate = DateFormat('MMM d').format(parsedDate.toLocal());
                                  return Container(
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(25),
                                      color: Colors.white,

                                    ),
                                    child: FutureBuilder(
                                        future: tripService.getTripDetails(canceledTrip["id"]),
                                        builder:  (context, snapshot) {


                                          if (snapshot.connectionState == ConnectionState.waiting) {
                                            return const Center(
                                              child: CircularProgressIndicator(
                                                color: AppColors.primary,
                                              ),
                                            );
                                          }

                                          if (snapshot.hasError) {
                                            return Center(
                                              child: Text('Error: ${snapshot.error}'),
                                            );
                                          }

                                          final cancelledTripPlaces = snapshot.data ?? [];


                                          return Row(
                                            children: [
                                              Image.asset("assets/images/pickme_small.png"),


                                              Expanded(
                                                child: Column(
                                                  spacing: 5,
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      spacing:100,
                                                      children: [
                                                        Container(
                                                          padding: EdgeInsets.all(5),
                                                          decoration: BoxDecoration(
                                                              color: Color(0x66E9DBA0),
                                                              borderRadius: BorderRadius.circular(15)
                                                          ),
                                                          child: Row(
                                                            spacing: 5,
                                                            children: [
                                                              Icon(Icons.circle,size: 10,color: Color(0xff685E2F)),
                                                              Text("Cancelled",style: TextStyle(color: Color(0xff685E2F)),),
                                                            ],
                                                          ),
                                                        ),
                                                        Text(canceledTrip["budget"].toString(),style: TextStyle(fontSize: 20,fontWeight: .bold),)

                                                      ],
                                                    ),
                                                    Text(cancelledTripPlaces.map((item) => '${item["place_name"]}').join(' & '),style: TextStyle(fontSize: 20,fontWeight: .bold)),
                                                        Text(formattedDate),


                                                  ],
                                                ),
                                              )


                                            ],
                                          );
                                        }
                                    ),


                                  ); },
                                separatorBuilder: (context, index) => SizedBox(
                                  height: 20,
                                ),
                                itemCount: cancelledTrips.length),

                            completedTrips.isEmpty
                                ? const Center(
                              child: Text('No trips found'),
                            )
                                :  ListView.separated(
                                itemBuilder: (context, index) {
                                  final completedTrip = completedTrips[index];

                                  String rawDate = completedTrip["completed_at"];

                                  DateTime parsedDate = DateTime.parse(rawDate);

                                  String formattedDate = DateFormat('MMM d').format(parsedDate.toLocal());
                                  return Container(
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(25),
                                      color: Colors.white,

                                    ),
                                    child: FutureBuilder(
                                        future: tripService.getTripDetails(completedTrip["id"]),
                                        builder:  (context, snapshot) {


                                          if (snapshot.connectionState == ConnectionState.waiting) {
                                            return const Center(
                                              child: CircularProgressIndicator(
                                                color: AppColors.primary,
                                              ),
                                            );
                                          }

                                          if (snapshot.hasError) {
                                            return Center(
                                              child: Text('Error: ${snapshot.error}'),
                                            );
                                          }

                                          final completeTripPlaces = snapshot.data ?? [];


                                          return Row(
                                            children: [
                                              Image.asset("assets/images/pickme_small.png"),


                                              Expanded(
                                                child: Column(
                                                  spacing: 5,
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      spacing:100,
                                                      children: [
                                                        Container(
                                                          padding: EdgeInsets.all(5),
                                                          decoration: BoxDecoration(
                                                              color: Color(0x66E9DBA0),
                                                              borderRadius: BorderRadius.circular(15)
                                                          ),
                                                          child: Row(
                                                            spacing: 5,
                                                            children: [
                                                              Icon(Icons.circle,size: 10,color: Color(0xff685E2F)),
                                                              Text("Completed",style: TextStyle(color: Color(0xff685E2F)),),
                                                            ],
                                                          ),
                                                        ),
                                                        Text(completedTrip["budget"].toString(),style: TextStyle(fontSize: 20,fontWeight: .bold),)

                                                      ],
                                                    ),
                                                    Text(completeTripPlaces.map((item) => '${item["place_name"]}').join(' & '),style: TextStyle(fontSize: 20,fontWeight: .bold)),
                                                        Text(formattedDate),

                                                  ],
                                                ),
                                              )


                                            ],
                                          );
                                        }
                                    ),


                                  ); },
                                separatorBuilder: (context, index) => SizedBox(
                                  height: 20,
                                ),
                                itemCount: completedTrips.length),


                          ],
                        ),


                      );
                    }
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: Color(0xffFFEAD7),

                    ),
                    padding: EdgeInsets.all(15),
                    height: 150,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: 25,
                      children: [
                        Text("Ready for your next journey?",style: TextStyle(fontSize: 20,fontWeight: .bold)),
                        AuthButton(onPressed: (){
                          Navigator.pushNamed(
                              context,
                              '/home'

                          );
                        }, text:" Return to home screen", color: AppColors.primary,icon: Icons.add_location_alt_outlined,)

                      ],
                    ),
                  )
        
        
                ],
              ),
            ),
          ),
        );

  }
}
