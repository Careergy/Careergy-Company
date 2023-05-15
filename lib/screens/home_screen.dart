import 'dart:html';

import 'package:careergy_mobile/models/company.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final _controller = SidebarXController(
      selectedIndex: 0, extended: true);
  final _key = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final company = Provider.of<Company>(context);
    return Scaffold(
      backgroundColor: accentCanvasColor,
      body: Row(
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
              return SizedBox(
                height: 100,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: CircleAvatar(
                    backgroundColor: canvasColor,
                    radius: 50,
                    child: ClipOval(
                      child: company.photoUrl == null ||
                              company.photoUrl == '' ||
                              company.photoUrl!.substring(0, 4) != 'http'
                          ? company.photo
                          : Image.network(
                              company.photoUrl ?? '',
                              loadingBuilder:
                                  (context, child, loadingProgress) {
                                if (loadingProgress == null) {
                                  return child;
                                } else {
                                  return const CircularProgressIndicator();
                                }
                              },
                            ),
                    ),
                  ),
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
            child: _ScreensExample(
              controller: _controller,
            ),
          ),
        ],
      ),
    );
  }
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
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: accentCanvasColor,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: Padding(
          padding: EdgeInsets.only(
              top: 7.0,
              bottom: 3,
              right: size.width * 0.2,
              left: size.width * 0.2),
          child: AppBar(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20))),
            shadowColor: Colors.black26,
            backgroundColor: canvasColor,
            centerTitle: true,
            title: const Text(
              'Careergy',
              style: TextStyle(color: white, fontWeight: FontWeight.w800),
            ),
            notificationPredicate: (notification) {
              return true;
            },
            actions: [
              IconButton(
                  onPressed: () => null,
                  icon: Stack(children: [Icon(Icons.notifications)])),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: ElevatedButton(
                  onPressed: () async {
                    await AuthProvider().logout();
                  },
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all(const CircleBorder()),
                    // padding: MaterialStateProperty.all(const EdgeInsets.all(20)),
                    backgroundColor: MaterialStateProperty.all(
                        const Color.fromARGB(
                            255, 109, 0, 0)), // <-- Button color
                    overlayColor: MaterialStateProperty.resolveWith<Color?>(
                      (states) {
                        if (states.contains(MaterialState.pressed)) {
                          return actionColor; // <-- Splash color
                        }
                      },
                    ),
                  ),
                  child: const Icon(Icons.power_settings_new_rounded),
                ),
              ),
            ],
          ),
        ),
      ),
      body: AnimatedBuilder(
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
      ),
    );
  }
}
