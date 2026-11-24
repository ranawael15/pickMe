import 'package:flutter/material.dart';
import 'package:pick_me/core/theme/app_colors.dart';
import 'package:pick_me/core/widgets/auth_button.dart';

class TripHistory extends StatefulWidget {

   TripHistory({super.key});

  @override
  State<TripHistory> createState() => _TripHistoryState();
}

class _TripHistoryState extends State<TripHistory> {
  int selectedTab=0;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      animationDuration: Duration.zero,
      initialIndex: 0,
      length: 2,
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
                padding: EdgeInsets.symmetric(vertical: 15,horizontal: 25),

                decoration: BoxDecoration(
                  color: selectedTab==0?Color(0xffFFEEAB):Colors.transparent,
                  borderRadius: BorderRadius.circular(25)
                ),
                child: Text("Completed trips",style: TextStyle(fontSize: 15),),
              )
          ),
            Tab(
                child:Container(
                  padding: EdgeInsets.symmetric(vertical: 15,horizontal: 25),

                  decoration: BoxDecoration(
                      color: selectedTab==1?Color(0xffFFEEAB):Colors.transparent,
                      borderRadius: BorderRadius.circular(25)
                  ),
                  child: Text("Cancelled trips",style: TextStyle(fontSize: 15)),
                )
            ),

          ],
                                    ),
                ),

            Container(
              height: 550,
              child:TabBarView(
                children: <Widget>[
                  SingleChildScrollView(
                    child: Column(
                      spacing: 20,
                      children: [
                        Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: Colors.white,

                          ),
                          child: Row(
                            children: [
                              Image.asset("assets/images/pickme_small.png"),
                              Column(
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
                                      Text("2,400 EGP",style: TextStyle(fontSize: 20,fontWeight: .bold),)

                                    ],
                                  ),
                                  Text("Alexandria Seaside & Citadel",style: TextStyle(fontSize: 20,fontWeight: .bold)),
                                  Text("Oct 2")
                                ],
                              )
                            ],
                          ),


                        ),
                        Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: Colors.white,

                          ),
                          child: Row(
                            children: [
                              Image.asset("assets/images/pickme_small.png"),
                              Column(
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
                                      Text("2,400 EGP")

                                    ],
                                  ),
                                  Text("Alexandria Seaside & Citadel"),
                                  Text("Oct 2")
                                ],
                              )
                            ],
                          ),


                        ),
                        Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: Colors.white,

                          ),
                          child: Row(
                            children: [
                              Image.asset("assets/images/pickme_small.png"),
                              Column(
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
                                      Text("2,400 EGP")

                                    ],
                                  ),
                                  Text("Alexandria Seaside & Citadel"),
                                  Text("Oct 2")
                                ],
                              )
                            ],
                          ),


                        ),
                        Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: Colors.white,

                          ),
                          child: Row(
                            children: [
                              Image.asset("assets/images/pickme_small.png"),
                              Column(
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
                                      Text("2,400 EGP")

                                    ],
                                  ),
                                  Text("Alexandria Seaside & Citadel"),
                                  Text("Oct 2")
                                ],
                              )
                            ],
                          ),


                        ),






                      ],
                    ),
                  ),
                  SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.white,


                          ),
                          child: Row(
                            children: [
                              Image.asset("assets/images/pickme_small.png"),
                              Column(
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
                                      Text("2,400 EGP")

                                    ],
                                  ),
                                  Text("Alexandria Seaside & Citadel"),
                                  Text("Oct 2")
                                ],
                              )
                            ],
                          ),


                        ),
                      ],
                    ),
                  ),


                ],
              ),


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
