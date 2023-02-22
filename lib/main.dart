import 'package:careergy_mobile/screens/profile_screen.dart';

import '../models/user.dart';
import '../providers/auth_provider.dart';
import '../screens/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';
import './screens/auth/auth_screen.dart';

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
    return MaterialApp(
      title: 'Careergy | Admin',
      theme: ThemeData(primaryColor: const Color.fromARGB(255, 34, 22, 112)),
      home: MultiProvider(
        providers: [
          ChangeNotifierProvider.value(
            value: AuthProvider(),
          ),
        ],
        child: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.hasData || false) {
              // to save time add (|| true)
              return MyHomePage(
                title: 'Careergy',
              );
            } else {
              return AuthScreen();
            }
          },
        ),
      ),
      routes: {
        '/profile': (ctx) => const profileScreen(),
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
    final auth = Provider.of<AuthProvider>(context);
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          backgroundColor: Theme.of(context).primaryColor,
          actions: [
            PopupMenuButton<int>(
              child: const Padding(
                padding: const EdgeInsets.only(right: 20.0),
                child: Icon(Icons.menu),
              ),
              itemBuilder: (context) => [
                // PopupMenuItem 2
                PopupMenuItem(
                  value: 2,
                  // row with two children
                  child: Row(
                    children: [
                      Icon(Icons.chrome_reader_mode),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "About",
                        style: TextStyle(color: Colors.white),
                      )
                    ],
                  ),
                ),
                PopupMenuItem(
                  value: 3,
                  // row with two children
                  child: Row(
                    children: [
                      Icon(Icons.logout_rounded),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Logout",
                        style: TextStyle(color: Colors.white),
                      )
                    ],
                  ),
                ),
              ],
              offset: Offset(0, 100),
              color: Theme.of(context).primaryColor,
              elevation: 2,
              // shape: CircleBorder(eccentricity: 20),
              // on selected we show the dialog box
              onSelected: (value) {
                // if value 1 show dialog
                if (value == 1) {
                  // _showDialog(context);
                  // if value 2 show dialog
                } else if (value == 2) {
                  // _showDialog(context);
                } else if (value == 3) {
                  auth.logout();
                }
              },
            ),
          ],
        ),
        body: HomeScreen());
  }
}
