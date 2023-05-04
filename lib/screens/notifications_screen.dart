import 'package:careergy_mobile/models/application.dart';
import 'package:careergy_mobile/screens/applicant_profile_screen.dart';
import 'package:careergy_mobile/screens/appointment_screen.dart';
import 'package:careergy_mobile/screens/profile_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:careergy_mobile/models/Applicant.dart';

import '../constants.dart';
import '../widgets/custom_textfieldform.dart';
import 'package:toggle_switch/toggle_switch.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  List<Application> applicantList = [];

  List<List<String>> tmpList = [
    ['Aqeel Almosa', 'aqeelalmosa@gmail.com', 'pending'],
    ['Mohatdy Alehlal', 'Mohtady.Alhelal@gmail.com', 'pending'],
    ['Ali Jumah', 'Alijumah@gmail.com', 'waiting']
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      body: ListView.builder(
          itemCount: tmpList.length,
          itemBuilder: (context, index) {
            print(tmpList[index][0]);
            InkWell(
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: (MediaQuery.of(context).size.width * 0.3) - 1,
                        child: ListTile(
                          title: Text('${tmpList[index][0]}'),
                          subtitle: Text('${tmpList[index][1]}'),
                          leading: CircleAvatar(
                            child: ClipOval(
                                child: Image.asset("/avatarPlaceholder.png")),
                            radius: 50,
                          ),
                          mouseCursor: MouseCursor.defer,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            margin: EdgeInsets.only(right: 20),
                            padding: EdgeInsets.symmetric(
                                vertical: 4, horizontal: 10),
                            decoration: BoxDecoration(
                                color: Colors.blueGrey,
                                borderRadius: BorderRadius.circular(20)),
                            child: Text(
                              '${tmpList[index][2]}',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 15),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AppointmentScreen(),
                    ));
              },
            );
            bottomNavigationBar:
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(kBlue)),
                onPressed: () {},
                child: Text(
                  "History",
                  style: TextStyle(),
                ),
              ),
            );
          }),
    ));
  }
}
