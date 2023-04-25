import 'package:careergy_mobile/screens/dashboard_screen.dart';
import 'package:careergy_mobile/screens/jobs_screen.dart';
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
  State<HomeScreen> createState() => _HomeScreenState('/dashboard');
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
          elevation: 5,
          width: media.size.width * 0.2,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 7),
            child: Column(
              children: [
                SidebarButton(
                    btnName: 'Dashboard',
                    routeName: '/dashboard',
                    func: switchPage,
                    selected: currentPage == '/dashboard'),
                SidebarButton(
                    btnName: 'Applications',
                    routeName: '/applications',
                    func: switchPage,
                    selected: currentPage == '/applications'),
                SidebarButton(
                    btnName: 'Jobs',
                    routeName: '/jobs',
                    func: switchPage,
                    selected: currentPage == '/jobs'),
                SidebarButton(
                    btnName: 'Search',
                    routeName: '/search',
                    func: switchPage,
                    selected: currentPage == '/search'),
                SidebarButton(
                    btnName: 'Profile',
                    routeName: '/profile',
                    func: switchPage,
                    selected: currentPage == '/profile'),
              ],
            ),
          ),
        ),
        const SizedBox(
          width: 1,
        ),
        SizedBox(
          height: media.size.height - AppBar().preferredSize.height,
          width: (media.size.width * 0.8) - 1,
          child: currentPage == '/profile'
              ? const profileScreen()
              : currentPage == '/applications'
                  ? const NotificationsScreen()
                  : currentPage == '/search'
                      ? const SearchScreen()
                      : currentPage == '/dashboard'
                          ? const DashboardScreen()
                          : currentPage == '/jobs'
                              ? const JobsScreen()
                              : const Center(),
        ),
      ],
    );
  }

  void switchPage(String page) {
    setState(() {
      currentPage = page;
    });
  }
}
