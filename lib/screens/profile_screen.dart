import 'package:careergy_mobile/widgets/sidebar_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'edit_profile_screen.dart';
import 'notifications_screen.dart';
import '../widgets/custom_drawer.dart';

import '../providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class profileScreen extends StatefulWidget {
  const profileScreen({super.key});

  @override
  State<profileScreen> createState() => _profileScreenState('/editProfile');
}

class _profileScreenState extends State<profileScreen> {
  String? currentPage;
  _profileScreenState(this.currentPage);
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context, listen: false);
    final media = MediaQuery.of(context);
    editProfileScreen func = const editProfileScreen();
    bool check = true;
    return Scaffold(
      body: ListView(
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 100, bottom: 30, right: 50),
                      child: Column(
                        // mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            'Email',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 15),
                            child: Text(
                              'email@gmail.com',
                              style: TextStyle(
                                  fontWeight: FontWeight.normal, fontSize: 20),
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Text(
                            'Phone Number',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 15),
                            child: Text(
                              '0551234566',
                              style: TextStyle(
                                  fontWeight: FontWeight.normal, fontSize: 20),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 50, bottom: 30, right: 50),
                      child: Column(
                        // mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          CircleAvatar(
                            radius: 100,
                            child: ClipOval(
                              child: Image(
                                image: AssetImage('/avatarPlaceholder.png'),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Company Name',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                ElevatedButton(
                    child: const Text('Edit'),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SizedBox(
                            height: media.size.height -
                                AppBar().preferredSize.height,
                            width: media.size.width * 0.8,
                            child: currentPage == '/editProfile'
                                ? const editProfileScreen()
                                : const Center(),
                          ),
                        ),
                      );
                    })
              ],
            ),
          ),
        ],
      ),
    );
  }

  void switchPage(String page) {
    setState(() {
      currentPage = page;
    });
  }
}
