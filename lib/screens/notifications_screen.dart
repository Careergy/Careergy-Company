import 'package:careergy_mobile/models/Applicant.dart';
import 'package:careergy_mobile/models/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:toggle_switch/toggle_switch.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notifications'),
      ),
      body: ListView.builder(
        itemCount: applicantList.length,
        itemBuilder: (context, index) {
          Applicant applicant = applicantList[index];
          int Status;
          if (=="Accept")
          {
            Status=1;
          }
          else if (=="Decline")
          {
            Status=2;
          }
          else
          {
            Status=0;
          }
          return InkWell(
            child: Card(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: (MediaQuery.of(context).size.width * 0.3) - 1,
                      child: ListTile(
                        title: Text(applicant.Name),
                        subtitle: Text(applicant.email),
                        leading: CircleAvatar(
                          child: ClipOval(
                              child: Image.asset("/avatarPlaceholder.png")),
                          radius: 50,
                        ),
                      ),
                    ),
                    ToggleSwitch(
                      minHeight: 40.0,
                      minWidth: 100.0,
                      initialLabelIndex: Status,
                      cornerRadius: 20.0,
                      activeFgColor: Colors.white,
                      inactiveBgColor: Colors.grey,
                      inactiveFgColor: Colors.white,
                      totalSwitches: 3,
                      labels: ["Pending", "Accept", "Decline"],
                      borderWidth: 2.0,
                      borderColor: [Colors.white],
                      activeBgColors: [
                        [Colors.orange],
                        [Color.fromARGB(255, 33, 194, 38)],
                        [Color.fromARGB(255, 235, 57, 45)]
                      ],
                      onToggle: (index) {
                        print('switched to: $index');
                      },
                    ),
                  ],
                ),
              ),
            ),
            onTap: () {
              print("object");
            },
          );
        },
      ),
    );
  }
}
