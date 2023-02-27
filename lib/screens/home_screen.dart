import 'package:careergy_mobile/screens/edit_profile_screen.dart';
import 'package:careergy_mobile/screens/notifications_screen.dart';
import 'package:careergy_mobile/screens/profile_screen.dart';
import 'package:careergy_mobile/screens/search_screen.dart';
import 'package:careergy_mobile/widgets/sidebar_button.dart';

import '../providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState('/profile');
}

class _HomeScreenState extends State<HomeScreen> {
  String? currentPage;

  _HomeScreenState(this.currentPage);

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context, listen: false);
    final media = MediaQuery.of(context);
    return Row(
      children: [
        Drawer(
          elevation: 3,
          width: media.size.width * 0.2,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 7),
            child: Column(
              children: [
                SidebarButton(
                    btnName: 'Profile',
                    routeName: '/profile',
                    func: switchPage,
                    selected: currentPage == '/profile'),
                SidebarButton(
                    btnName: 'Notification',
                    routeName: '/notification',
                    func: switchPage,
                    selected: currentPage == '/notification'),
                SidebarButton(
                    btnName: 'Search',
                    routeName: '/search',
                    func: switchPage,
                    selected: currentPage == '/search'),
              ],
            ),
          ),
        ),
        SizedBox(
          height: media.size.height - AppBar().preferredSize.height,
          width: media.size.width * 0.8,
          child: currentPage == '/profile'
              ? profileScreen()
              : currentPage == '/notification'
                  ? NotificationsScreen()
                  : currentPage == '/search'
                      ? SearchScreen()
                      : currentPage == '/editProfile'
                          ? editProfileScreen()
                          : Center(),
        )
      ],
    );
  }

  void switchPage(String page) {
    setState(() {
      currentPage = page;
    });
  }
}
