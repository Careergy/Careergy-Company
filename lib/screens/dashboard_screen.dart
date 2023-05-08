import 'package:careergy_mobile/constants.dart';
import 'package:careergy_mobile/screens/notifications_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../models/application.dart';
import '../providers/auth_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState('/dashboard');
}

class _DashboardScreenState extends State<DashboardScreen> {
  String? currentPage;
  bool isHovering = false;
  _DashboardScreenState(this.currentPage);
  // late final Future myFuture;
  // late final AggregateQuery count;
  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   myFuture = getApplicationsCount();
  // }

  // Future getApplicationsCount() async {
  //   count = await Application().getApplicationsCount();
  // }

  // Future refresh() async {
  //   await getApplicationsCount();
  //   setState(() {});
  // }

  @override
  Widget build(BuildContext context) {
    // return FutureBuilder(
    //   future: Provider.of<Application>(context).getApplicationsCount(),
    //   builder: (context, snapshot) {
    //     if (snapshot.connectionState == ConnectionState.waiting) {
    //       return const Center(child: CircularProgressIndicator());
    //     } else {
    return Scaffold(
      body: ListView(children: [
        Container(
          margin: EdgeInsets.fromLTRB(50, 50, 50, 20),
          padding: EdgeInsets.all(50),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: kBlue)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 160,
                    child: Text(
                      'This Month',
                      style: TextStyle(
                          fontSize: 25, fontFamily: 'Montserrat_bold'),
                    ),
                  ),
                  SizedBox(
                    width: 50,
                    child: Text(
                      '|',
                      style: TextStyle(fontSize: 80, color: kBlue),
                    ),
                  ),
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SizedBox(
                            width: 150,
                            child: Text(
                              'Accepted',
                              style: TextStyle(
                                  fontSize: 20,
                                  fontFamily: 'Montserrat_regular'),
                            ),
                          ),
                          SizedBox(
                            width: 80,
                          ),
                          SizedBox(
                            width: 150,
                            child: Text(
                              'Rejected',
                              style: TextStyle(
                                  fontSize: 20,
                                  fontFamily: 'Montserrat_regular'),
                            ),
                          ),
                          SizedBox(
                            width: 80,
                          ),
                          SizedBox(
                            width: 150,
                            child: Text(
                              'Jobs',
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SizedBox(
                            width: 150,
                            child: Text(
                              '150',
                              style: TextStyle(
                                  fontFamily: 'Montserrat_bold',
                                  fontSize: 50,
                                  color: kBlue),
                            ),
                          ),
                          SizedBox(
                            width: 80,
                          ),
                          SizedBox(
                            width: 150,
                            child: Text(
                              '30',
                              style: TextStyle(
                                  fontFamily: 'Montserrat_bold',
                                  fontSize: 50,
                                  color: kBlue),
                            ),
                          ),
                          SizedBox(
                            width: 80,
                          ),
                          SizedBox(
                            width: 150,
                            child: Text(
                              '23',
                              style: TextStyle(
                                  fontSize: 50,
                                  color: kBlue,
                                  fontFamily: 'Montserrat_bold'),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 50,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 160,
                    child: Text(
                      'Total',
                      style: TextStyle(
                          fontSize: 25, fontFamily: 'Montserrat_bold'),
                    ),
                  ),
                  SizedBox(
                    width: 50,
                    child: Text(
                      '|',
                      style: TextStyle(fontSize: 80, color: kBlue),
                    ),
                  ),
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SizedBox(
                            width: 150,
                            child: Text(
                              'Applications',
                              style: TextStyle(
                                  fontSize: 20,
                                  fontFamily: 'Montserrat_regular'),
                            ),
                          ),
                          SizedBox(
                            width: 80,
                          ),
                          SizedBox(
                            width: 150,
                            child: Text(
                              'Jobs',
                              style: TextStyle(
                                  fontSize: 20,
                                  fontFamily: 'Montserrat_regular'),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SizedBox(
                            width: 150,
                            child: Text(
                              "5880",
                              style: TextStyle(
                                  fontFamily: 'Montserrat_bold',
                                  fontSize: 50,
                                  color: kBlue),
                            ),
                          ),
                          SizedBox(
                            width: 80,
                          ),
                          SizedBox(
                            width: 150,
                            child: Text(
                              '120',
                              style: TextStyle(
                                  fontSize: 50,
                                  color: kBlue,
                                  fontFamily: 'Montserrat_bold'),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.only(
              left: 50, right: MediaQuery.of(context).size.width * 0.5),
          child: TextButton(
              style: TextButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                backgroundColor:
                    isHovering ? Color.fromARGB(255, 117, 150, 239) : kBlue,
              ),
              onPressed: () {
                setState(() {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => NotificationsScreen(),
                  //   ),
                  // );
                });
              },
              onHover: (value) {
                setState(() {
                  isHovering = value;
                });
              },
              child: Text(
                'show applications',
                style: TextStyle(color: Colors.white),
              )),
        )
      ]),
      //     );
      //   }
      // },
    );
  }
}
