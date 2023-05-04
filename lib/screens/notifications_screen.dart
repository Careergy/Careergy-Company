import 'package:careergy_mobile/screens/appointment_screen.dart';
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
  late List<Applicant> userList = [];

  List<Applicant> applicantList = [
    // Applicant(
    //     name: "Mohatdy Alehlal",
    //     email: "Mohtady.Alhelal@gmail.com",
    //     phone: "0566304423",
    //     photoUrl: ""),
    // Applicant(
    //     name: "Aqeel Almosa",
    //     email: "Aqeel.Almosa@gmail.com",
    //     phone: "0500000000",
    //     photoUrl: "")
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        // body: ListView.builder(
        //   itemCount: applicantList.length,
        //   itemBuilder: (context, index) {
        //     Applicant applicant = applicantList[index];
        body: InkWell(
          child: Card(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: (MediaQuery.of(context).size.width * 0.3) - 1,
                    child: ListTile(
                      title: Text("Aqeel Almosa"),
                      subtitle: Text('aqeelalmosa@gmail.com'),
                      leading: CircleAvatar(
                        child: ClipOval(
                            child: Image.asset("/avatarPlaceholder.png")),
                        radius: 50,
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () {},
                        child: Text("Decline"),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const AppointmentScreen()),
                          );
                        },
                        child: Text("Accept"),
                      ),
                    ],
                  ),
                  // ToggleSwitch(
                  //   minHeight: 40.0,
                  //   minWidth: 100.0,
                  //   initialLabelIndex: 0,
                  //   cornerRadius: 20.0,
                  //   activeFgColor: Colors.white,
                  //   inactiveBgColor: Colors.grey,
                  //   inactiveFgColor: Colors.white,
                  //   totalSwitches: 3,
                  //   labels: ["Pending", "Accept", "Decline"],
                  //   borderWidth: 2.0,
                  //   borderColor: [Colors.white],
                  //   activeBgColors: [
                  //     [Colors.orange],
                  //     [Color.fromARGB(255, 33, 194, 38)],
                  //     [Color.fromARGB(255, 235, 57, 45)]
                  //   ],
                  // ),
                ],
              ),
            ),
          ),
          onTap: () {
            print("object");
          },
        ),
      ),
    );
  }
}
