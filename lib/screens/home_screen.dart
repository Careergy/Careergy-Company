import 'dart:html';

import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
import 'package:sidebarx/sidebarx.dart';

import '../providers/auth_provider.dart';
import 'package:careergy_mobile/screens/dashboard_screen.dart';
import 'package:careergy_mobile/screens/jobs_screen.dart';
import 'package:careergy_mobile/screens/applications_screen.dart';
import 'package:careergy_mobile/screens/profile_screen.dart';
// import 'package:careergy_mobile/screens/search_screen.dart';
import './applicant_search_screan.dart';
// import 'package:careergy_mobile/widgets/sidebar_button.dart';

import '../constants.dart';


String _getTitleByIndex(int index) {
  switch (index) {
    case 0:
      return 'Home';
    case 1:
      return 'Search';
    case 2:
      return 'Applications';
    case 3:
      return 'Jobs';
    case 4:
      return 'Profile';
    default:
      return 'Not found page';
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState('/applications');
}

class _HomeScreenState extends State<HomeScreen> {
  String? currentPage;

  _HomeScreenState(this.currentPage);

  final _controller = SidebarXController(selectedIndex: 0, extended: true);
  final _key = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    // final auth = Provider.of<AuthProvider>(context, listen: false);
    final media = MediaQuery.of(context);
    return Row(
      children: [
        SidebarX(
          controller: _controller,
          theme: SidebarXTheme(
            margin: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: canvasColor,
              borderRadius: BorderRadius.circular(20),
            ),
            hoverColor: scaffoldBackgroundColor,
            textStyle: TextStyle(color: Colors.white.withOpacity(0.7)),
            selectedTextStyle: const TextStyle(color: Colors.white),
            itemTextPadding: const EdgeInsets.only(left: 30),
            selectedItemTextPadding: const EdgeInsets.only(left: 30),
            itemDecoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: canvasColor),
            ),
            selectedItemDecoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: actionColor.withOpacity(0.37),
              ),
              gradient: const LinearGradient(
                colors: [accentCanvasColor, canvasColor],
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.28),
                  blurRadius: 30,
                )
              ],
            ),
            iconTheme: IconThemeData(
              color: Colors.white.withOpacity(0.7),
              size: 20,
            ),
            selectedIconTheme: const IconThemeData(
              color: Colors.white,
              size: 20,
            ),
          ),
          extendedTheme: const SidebarXTheme(
            width: 200,
            decoration: BoxDecoration(
              color: canvasColor,
            ),
          ),
          footerDivider: divider,
          headerBuilder: (context, extended) {
            return const SizedBox(
              height: 100,
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: CircleAvatar(
                    radius: 50,
                    backgroundImage:
                        AssetImage('assets/avatarPlaceholder.png')),
              ),
            );
          },
          items: [
            SidebarXItem(
              icon: Icons.home,
              label: 'Home',
              onTap: () {
                debugPrint('Home');
              },
            ),
            const SidebarXItem(
              icon: Icons.search,
              label: 'Search',
            ),
            const SidebarXItem(
              icon: Icons.people_alt,
              label: 'Applications',
            ),
            const SidebarXItem(
              icon: Icons.work,
              label: 'Jobs',
            ),
            const SidebarXItem(
              icon: Icons.person,
              label: 'Profile',
            ),
          ],
        ),
        Expanded(
          child: Center(
            child: _ScreensExample(
              controller: _controller,
            ),
          ),
        ),
        // Drawer(
        //   elevation: 5,
        //   width: media.size.width * 0.2,
        //   child: Padding(
        //     padding: const EdgeInsets.symmetric(vertical: 7),
        //     child: Column(
        //       children: [
        //         SidebarButton(
        //             btnName: 'Dashboard',
        //             routeName: '/dashboard',
        //             func: switchPage,
        //             selected: currentPage == '/dashboard'),
        //         SidebarButton(
        //             btnName: 'Applications',
        //             routeName: '/applications',
        //             func: switchPage,
        //             selected: currentPage == '/applications'),
        //         SidebarButton(
        //             btnName: 'Jobs',
        //             routeName: '/jobs',
        //             func: switchPage,
        //             selected: currentPage == '/jobs'),
        //         SidebarButton(
        //             btnName: 'Search',
        //             routeName: '/search',
        //             func: switchPage,
        //             selected: currentPage == '/search'),
        //         SidebarButton(
        //             btnName: 'Profile',
        //             routeName: '/profile',
        //             func: switchPage,
        //             selected: currentPage == '/profile'),
        //       ],
        //     ),
        //   ),
        // ),
        // const SizedBox(
        //   width: 1,
        // ),
        // SizedBox(
        //   height: media.size.height - AppBar().preferredSize.height,
        //   width: (media.size.width * 0.8) - 1,
        //   child: currentPage == '/profile'
        //       ? const profileScreen()
        //       : currentPage == '/applications'
        //           ? const ApplicationsScreen()
        //           : currentPage == '/search'
        //               ? const ApplicantSearchScreen()
        //               : currentPage == '/dashboard'
        //                   ? const DashboardScreen()
        //                   : currentPage == '/jobs'
        //                       ? const JobsScreen()
        //                       : const Center(),
        // ),
      ],
    );
  }

  // void switchPage(String page) {
  //   setState(() {
  //     currentPage = page;
  //   });
  // }
}

class _ScreensExample extends StatelessWidget {
  const _ScreensExample({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final SidebarXController controller;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        final pageTitle = _getTitleByIndex(controller.selectedIndex);
        switch (controller.selectedIndex) {
          case 0:
            return const DashboardScreen();
          case 1:
            return const ApplicantSearchScreen();
          case 2:
            return const ApplicationsScreen();
          case 3:
            return const JobsScreen();
          case 4:
            return const profileScreen();
          default:
            return Text(
              pageTitle,
              style: theme.textTheme.headlineSmall,
            );
        }
      },
    );
  }
}
