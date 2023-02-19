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
                SidebarButton(btnName: 'Profile'),
                SidebarButton(btnName: 'Search'),
                SidebarButton(btnName: 'Jobs'),
                SidebarButton(btnName: 'Applicants List'),
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
