import 'dart:html';
import 'dart:ui';

import 'package:careergy_mobile/constants.dart';
import 'package:careergy_mobile/widgets/custom_textfieldform.dart';
import 'package:careergy_mobile/widgets/sidebar_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'notifications_screen.dart';
import '../widgets/custom_drawer.dart';

import '../providers/auth_provider.dart';
import 'package:provider/provider.dart';

import 'package:image_picker_web/image_picker_web.dart';

// import 'package:file_picker/file_picker.dart';
// import 'package:open_file/open_file.dart';

class profileScreen extends StatefulWidget {
  const profileScreen({super.key});

  @override
  State<profileScreen> createState() => _profileScreenState('/profile');
}

class _profileScreenState extends State<profileScreen> {
  String? currentPage;
  _profileScreenState(this.currentPage);
  @override
  Widget build(BuildContext context) {
    return currentPage == '/editProfile'
        ? editProfile()
        : Scaffold(
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
                            padding:
                                EdgeInsets.only(top: 50, bottom: 30, right: 50),
                            child: Column(
                              // mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text(
                                  'Email',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 15),
                                  child: Text(
                                    'email@gmail.com',
                                    style: TextStyle(
                                        fontWeight: FontWeight.normal,
                                        fontSize: 20),
                                  ),
                                ),
                                const SizedBox(
                                  height: 30,
                                ),
                                Text(
                                  'Phone Number',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 15),
                                  child: Text(
                                    '0551234566',
                                    style: TextStyle(
                                        fontWeight: FontWeight.normal,
                                        fontSize: 20),
                                  ),
                                ),
                                const SizedBox(
                                  height: 30,
                                ),
                                Text(
                                  'About Company',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 15),
                                  child: SizedBox(
                                    width: 500,
                                    child: Text(
                                      'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
                                      style: TextStyle(
                                          fontWeight: FontWeight.normal,
                                          fontSize: 20),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                top: 50, bottom: 30, right: 50, left: 30),
                            child: Column(
                              // mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                CircleAvatar(
                                  radius: 120,
                                  child: ClipOval(
                                    child: Image(
                                      image:
                                          AssetImage('/avatarPlaceholder.png'),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    'Company Name',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            bottomNavigationBar: Container(
              padding: EdgeInsets.all(32),
              // transformAlignment: Alignment.bottomRight,
              margin: EdgeInsets.only(left: 800, right: 60),

              child: ElevatedButton(
                  child: const Text('Edit'),
                  onPressed: () {
                    setState(() {
                      currentPage = '/editProfile';
                      // get profile info from database and show them
                    });
                  }),
            ),
          );
  }
}
//................Edit profile screen ...................
//.......................................................

class editProfile extends StatefulWidget {
  const editProfile({super.key});

  @override
  State<editProfile> createState() => _editProfileState('/editprofile');
}

class _editProfileState extends State<editProfile> {
  String? currentPage;
  Image? photo = Image(
    image: AssetImage('/avatarPlaceholder.png'),
  );

  _editProfileState(this.currentPage);
  @override
  Widget build(BuildContext context) {
    return currentPage == '/profile'
        ? profileScreen()
        : Scaffold(
            body: ListView(
              children: [
                Container(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                                top: 100, bottom: 30, right: 50, left: 30),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Email*',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                SizedBox(
                                  width: 300,
                                  child: CustomTextField(
                                    label: "Email",
                                    hint: "Enter Email",
                                  ),
                                ),
                                const SizedBox(
                                  height: 30,
                                ),
                                Text(
                                  'Phone Number*',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                SizedBox(
                                  width: 200,
                                  child: CustomTextField(
                                    label: "Phone Number",
                                    hint: "Enter Phone",
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Padding(
                            padding:
                                EdgeInsets.only(top: 50, bottom: 30, right: 50),
                            child: Column(
                              // mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                  height: 240,
                                  width: 240,
                                  child: Stack(
                                    children: [
                                      ClipOval(
                                        child: FittedBox(
                                          child: photo,
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                      Positioned(
                                        bottom: 15,
                                        right: 20,
                                        child: MaterialButton(
                                          minWidth: 30,
                                          onPressed: () => {pickFile()},
                                          child: Icon(
                                            Icons.camera_alt,
                                            size: 30,
                                            color: kBlue,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      Column(
                                        children: [
                                          Text(
                                            'Company Name*',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          SizedBox(
                                            width: 250,
                                            child: CustomTextField(
                                              label: "Company Name",
                                              hint: "Enter Company Name",
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Column(
                                        children: [
                                          Text(
                                            'Abbreviation (Optional)',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 13),
                                          ),
                                          SizedBox(
                                            height: 15,
                                          ),
                                          SizedBox(
                                            width: 150,
                                            child: CustomTextField(
                                              label: "Abbreviation",
                                              hint:
                                                  "Enter Company Abbreviation",
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding:
                            EdgeInsets.only(left: 30, bottom: 30, right: 50),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'About Company*',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            SizedBox(
                              width: 500,
                              child: CustomTextField(
                                label: "About Company",
                                hint: "Enter Bio",
                                maxLines: 10,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(32.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  currentPage = '/profile';
                                  // save the image in the database
                                });
                              },
                              child: const Text('Save'),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            TextButton(
                              onPressed: () {
                                setState(() {
                                  currentPage = '/profile';
                                });
                              },
                              child: const Text('Cancel'),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
  }

  Future<void> pickFile() async {
    Image? result = await ImagePickerWeb.getImageAsWidget();
    setState(() {
      if (result != null) {
        photo = result;
      }
    });
  }
}
