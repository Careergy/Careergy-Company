import 'package:careergy_mobile/screens/notifications_screen.dart';
import 'package:careergy_mobile/screens/post_job_screen.dart';
import 'package:careergy_mobile/screens/profile_screen.dart';
import 'package:careergy_mobile/screens/search_screen.dart';
import 'package:careergy_mobile/widgets/sidebar_button.dart';

import '../providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context, listen: false);

    return Row(
      children: [
        Drawer(
          elevation: 3,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 7),
            child: Column(
              children: [
                ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const profileScreen()),
                      );
                    },
                    child: const Text('Profile',
                        style: TextStyle(color: Colors.white)),
                    style: ElevatedButton.styleFrom(
                        primary: Colors.blueAccent, //background color
                        padding:
                            EdgeInsets.all(20) //content padding inside button

                        )),
                ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SearchScreen()),
                      );
                    },
                    child: const Text('Search',
                        style: TextStyle(color: Colors.white)),
                    style: ElevatedButton.styleFrom(
                        primary: Colors.blueAccent, //background color
                        padding:
                            EdgeInsets.all(20) //content padding inside button
                        )),
                ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const NotificationsScreen()),
                      );
                    },
                    child: const Text('notification',
                        style: TextStyle(color: Colors.white)),
                    style: ElevatedButton.styleFrom(
                        primary: Colors.blueAccent, //background color
                        padding:
                            EdgeInsets.all(20) //content padding inside button
                        )),
                ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const postJobScreen()),
                      );
                    },
                    child: const Text('posts',
                        style: TextStyle(color: Colors.white)),
                    style: ElevatedButton.styleFrom(
                        primary: Colors.blueAccent, //background color
                        padding:
                            EdgeInsets.all(20) //content padding inside button
                        )),
              ],
            ),
          ),
        ),
        Center(
          child: Column(
            children: [
              Text(auth.auth.currentUser!.displayName ?? ''),
              Text(auth.auth.currentUser!.email ?? ''),
              ElevatedButton(
                  onPressed: auth.logout, child: const Text('Logout'))
            ],
            mainAxisAlignment: MainAxisAlignment.center,
          ),
        ),
      ],
    );
  }
}
