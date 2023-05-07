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
  bool isClicked = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF3E3E61),
      // appBar: AppBar(
      //   title: Text(widget.title),
      //   backgroundColor: Theme.of(context).primaryColor,
      //   actions: [
      //     PopupMenuButton<int>(
      //       itemBuilder: (context) => [
      //         // PopupMenuItem 2
      //         PopupMenuItem(
      //           value: 2,
      //           // row with two children
      //           child: Row(
      //             children: const [
      //               Icon(Icons.chrome_reader_mode),
      //               SizedBox(
      //                 width: 10,
      //               ),
      //               Text(
      //                 "About",
      //                 style: TextStyle(color: Colors.white),
      //               )
      //             ],
      //           ),
      //         ),
      //         PopupMenuItem(
      //           value: 3,
      //           // row with two children
      //           child: Row(
      //             children: const [
      //               Icon(Icons.logout_rounded),
      //               SizedBox(
      //                 width: 10,
      //               ),
      //               Text(
      //                 "Logout",
      //                 style: TextStyle(color: Colors.white),
      //               )
      //             ],
      //           ),
      //         ),
      //       ],
      //       offset: const Offset(0, 100),
      //       color: Theme.of(context).primaryColor,
      //       elevation: 2,
      //       // shape: CircleBorder(eccentricity: 20),
      //       // on selected we show the dialog box
      //       onSelected: (value) {
      //         // if value 1 show dialog
      //         if (value == 1) {
      //           // _showDialog(context);
      //           // if value 2 show dialog
      //         } else if (value == 2) {
      //           // _showDialog(context);
      //         } else if (value == 3) {
      //           auth.logout();
      //         }
      //       },
      //       child: const Padding(
      //         padding: EdgeInsets.only(right: 20.0),
      //         child: Icon(Icons.menu),
      //       ),
      //     ),
      //   ],
      // ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(top: 15),
        child: ElevatedButton(
          onPressed: () async {
            await AuthProvider().logout();
          },
          style: ButtonStyle(
            shape: MaterialStateProperty.all(const CircleBorder()),
            padding: MaterialStateProperty.all(const EdgeInsets.all(20)),
            backgroundColor:
                MaterialStateProperty.all(const Color.fromARGB(255, 109, 0, 0)), // <-- Button color
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
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      body: const HomeScreen(),
    );
  }
}
