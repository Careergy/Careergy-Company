import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

import './screens/profile_screen.dart';
import './screens/support_screen.dart';
import './screens/auth/auth_screen.dart';
import './screens/home_screen.dart';

import './models/company.dart';
import './providers/auth_provider.dart';

import 'firebase_options.dart';
import 'constants.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.hasData || false) {
          return MaterialApp(
            title: 'Careergy | Company',
            theme: ThemeData(
              primaryColor: primaryColor,
              accentColor: accentCanvasColor,
            ),
            home: MultiProvider(
              providers: [
                ChangeNotifierProvider.value(
                  value: AuthProvider(),
                ),
                ChangeNotifierProvider.value(
                  value: Company(),
                ),
              ],
              child: const MyHomePage(
                title: 'Careergy',
              ),
            ),
            routes: {
              '/profile': (ctx) => const profileScreen(),
              '/support': (ctx) => const SupportScreen(),
            },
          );
        } else {
          return MaterialApp(
            home: MultiProvider(
              providers: [
                ChangeNotifierProvider.value(
                  value: AuthProvider(),
                ),
              ],
              child: const AuthScreen(),
            ),
          );
        }
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: accentCanvasColor,
      // floatingActionButton: Padding(
      //   padding: const EdgeInsets.only(top: 7, right: 20),
      //   child: ElevatedButton(
      //     onPressed: () async {
      //       await AuthProvider().logout();
      //     },
      //     style: ButtonStyle(
      //       shape: MaterialStateProperty.all(const CircleBorder()),
      //       padding: MaterialStateProperty.all(const EdgeInsets.all(20)),
      //       backgroundColor: MaterialStateProperty.all(
      //           const Color.fromARGB(255, 109, 0, 0)), // <-- Button color
      //       overlayColor: MaterialStateProperty.resolveWith<Color?>(
      //         (states) {
      //           if (states.contains(MaterialState.pressed)) {
      //             return actionColor; // <-- Splash color
      //           }
      //         },
      //       ),
      //     ),
      //     child: const Icon(Icons.power_settings_new_rounded),
      //   ),
      // ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      body: HomeScreen(),
    );
  }
}
