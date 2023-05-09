import 'package:flutter/material.dart';



import '../constants.dart';


class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState('/dashboard');
}

class _DashboardScreenState extends State<DashboardScreen> {
  String? currentPage;
  bool isHovering = false;
  _DashboardScreenState(this.currentPage);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: accentCanvasColor,
      body: ListView(children: [
        Container(
          margin: const EdgeInsets.fromLTRB(50, 50, 50, 20),
          padding: const EdgeInsets.all(50),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: kBlue)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(
                    width: 160,
                    child: Text(
                      'This Month',
                      style: TextStyle(
                          fontSize: 25, fontFamily: 'Montserrat_bold'),
                    ),
                  ),
                  const SizedBox(
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
                          const SizedBox(
                            width: 150,
                            child: Text(
                              'Accepted',
                              style: TextStyle(
                                  fontSize: 20,
                                  fontFamily: 'Montserrat_regular'),
                            ),
                          ),
                          const SizedBox(
                            width: 80,
                          ),
                          const SizedBox(
                            width: 150,
                            child: Text(
                              'Rejected',
                              style: TextStyle(
                                  fontSize: 20,
                                  fontFamily: 'Montserrat_regular'),
                            ),
                          ),
                          const SizedBox(
                            width: 80,
                          ),
                          const SizedBox(
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
                          const SizedBox(
                            width: 150,
                            child: Text(
                              '150',
                              style: TextStyle(
                                  fontFamily: 'Montserrat_bold',
                                  fontSize: 50,
                                  color: kBlue),
                            ),
                          ),
                          const SizedBox(
                            width: 80,
                          ),
                          const SizedBox(
                            width: 150,
                            child: Text(
                              '30',
                              style: TextStyle(
                                  fontFamily: 'Montserrat_bold',
                                  fontSize: 50,
                                  color: kBlue),
                            ),
                          ),
                          const SizedBox(
                            width: 80,
                          ),
                          const SizedBox(
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
              const SizedBox(
                height: 50,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(
                    width: 160,
                    child: Text(
                      'Total',
                      style: TextStyle(
                          fontSize: 25, fontFamily: 'Montserrat_bold'),
                    ),
                  ),
                  const SizedBox(
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
                          const SizedBox(
                            width: 150,
                            child: Text(
                              'Applicants',
                              style: TextStyle(
                                  fontSize: 20,
                                  fontFamily: 'Montserrat_regular'),
                            ),
                          ),
                          const SizedBox(
                            width: 80,
                          ),
                          const SizedBox(
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
                          const SizedBox(
                            width: 150,
                            child: Text(
                              '5880',
                              style: TextStyle(
                                  fontFamily: 'Montserrat_bold',
                                  fontSize: 50,
                                  color: kBlue),
                            ),
                          ),
                          const SizedBox(
                            width: 80,
                          ),
                          const SizedBox(
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
                    isHovering ? const Color.fromARGB(255, 117, 150, 239) : kBlue,
              ),
              onPressed: () {
                setState(() {});
              },
              onHover: (value) {
                setState(() {
                  isHovering = value;
                });
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Text(
                    'Request for Authentication Mark',
                    style: TextStyle(color: Colors.white),
                  ),
                  const Icon(
                    Icons.check_circle,
                    color: Colors.white,
                  )
                ],
              )),
        )
      ]),
    );
  }
}