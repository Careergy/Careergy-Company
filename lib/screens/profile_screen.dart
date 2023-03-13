// import 'dart:html';
// import 'dart:ui';

// import 'dart:html';
import 'dart:io';
import 'dart:typed_data';

import 'package:careergy_mobile/constants.dart';
import 'package:careergy_mobile/models/company.dart';
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

import 'package:file_picker/file_picker.dart';
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
    final info = Provider.of<Company>(context);

    return FutureBuilder(
        future: Provider.of<Company>(context).getCompanyInfo(),
        builder: (ctx, snapshot) {
          return currentPage == '/editProfile'
              ? const editProfile()
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
                                  padding: const EdgeInsets.only(
                                      top: 50, bottom: 30, right: 50),
                                  child: Column(
                                    // mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'Email',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20),
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 15),
                                        child: Text(
                                          info.email,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.normal,
                                              fontSize: 20),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 30,
                                      ),
                                      const Text(
                                        'Phone Number',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20),
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 15),
                                        child: Text(
                                          info.phone ?? 'Not Availabla',
                                          style: const TextStyle(
                                              fontWeight: FontWeight.normal,
                                              fontSize: 20),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 30,
                                      ),
                                      const Text(
                                        'About Company',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20),
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      const Padding(
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
                                  padding: const EdgeInsets.only(
                                      top: 50, bottom: 30, right: 50, left: 30),
                                  child: Column(
                                    // mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      FittedBox(
                                        fit: BoxFit.fill,
                                        child: CircleAvatar(
                                          radius: 120,
                                          child: ClipOval(
                                            child: (info.hasPhoto)
                                                ? info.photo
                                                : const Image(
                                                    image: AssetImage(
                                                        '/avatarPlaceholder.png'),
                                                  ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          info.name,
                                          style: const TextStyle(
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
                    padding: const EdgeInsets.all(32),
                    // transformAlignment: Alignment.bottomRight,
                    margin: const EdgeInsets.only(left: 800, right: 60),

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
        });
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
  Map<String, dynamic> _infoData = {
    'email': '',
    'name': '',
    'phone': '',
    'photoUrl': null
  };
  bool _isLoading = false;
  bool _isInitialized = false;
  String? currentPage;
  Image? photo;

  TextEditingController? nameCtrl;
  TextEditingController? emailCtrl;
  TextEditingController? phoneCtrl;

  _editProfileState(this.currentPage);
  @override
  Widget build(BuildContext context) {
    final info = Provider.of<Company>(context);
    if (!_isInitialized) {
      nameCtrl =
          TextEditingController.fromValue(TextEditingValue(text: info.name));
      emailCtrl =
          TextEditingController.fromValue(TextEditingValue(text: info.email));
      phoneCtrl = TextEditingController.fromValue(
          TextEditingValue(text: info.phone ?? ''));
      _isInitialized = true;
    }
    if (photo == null) {
      print('object');
      photo = info.hasPhoto ? info.photo : const Image(image: AssetImage('/avatarPlaceholder.png'));
    }
    return currentPage == '/profile'
        ? const profileScreen()
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
                            padding: const EdgeInsets.only(
                                top: 100, bottom: 30, right: 50, left: 30),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
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
                                    onChanged: (value) {
                                      _infoData['email'] = value;
                                    },
                                    controller: emailCtrl,
                                  ),
                                ),
                                const SizedBox(
                                  height: 30,
                                ),
                                const Text(
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
                                    onChanged: (value) {
                                      _infoData['phone'] = value;
                                    },
                                    controller: phoneCtrl,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 50, bottom: 30, right: 50),
                            child: Column(
                              // mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                SizedBox(
                                  height: 240,
                                  width: 240,
                                  child: Stack(
                                    children: [
                                      ClipOval(
                                        child: photo ??
                                            const Image(
                                                image: AssetImage(
                                                    '/avatarPlaceholder.png')),
                                      ),
                                      Positioned(
                                        bottom: 15,
                                        right: 20,
                                        child: MaterialButton(
                                          minWidth: 30,
                                          onPressed: () {
                                            setState(() {
                                              pickFile();
                                              print(photo);
                                            });
                                          },
                                          child: const Icon(
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
                                          const Text(
                                            'Company Name*',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          SizedBox(
                                            width: 250,
                                            child: CustomTextField(
                                              label: "Company Name",
                                              hint: "Enter Company Name",
                                              onChanged: (value) {
                                                _infoData['name'] = value;
                                              },
                                              controller: nameCtrl,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Column(
                                        children: [
                                          const Text(
                                            'Abbreviation (Optional)',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 13),
                                          ),
                                          const SizedBox(
                                            height: 15,
                                          ),
                                          SizedBox(
                                            width: 150,
                                            child: CustomTextField(
                                              label: "Abbreviation",
                                              hint:
                                                  "Enter Company Abbreviation",
                                              onChanged: (value) {},
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
                        padding: const EdgeInsets.only(
                            left: 30, bottom: 30, right: 50),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
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
                                onChanged: (value) {},
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
                              onPressed: () async {
                                setState(() {
                                  _isLoading = true;
                                });
                                _infoData['name'] = nameCtrl!.text;
                                _infoData['email'] = emailCtrl!.text;
                                _infoData['phone'] = phoneCtrl!.text;

                                // print(_infoData);
                                await info.setCompanyInfo(_infoData);
                                setState(() {
                                  _isLoading = false;
                                  currentPage = '/profile';
                                  // save the image in the database
                                });
                              },
                              child: _isLoading
                                  ? const CircularProgressIndicator()
                                  : const Text('Save'),
                            ),
                            const SizedBox(
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
    final result = await FilePicker.platform.pickFiles(
        allowMultiple: false,
        type: FileType.custom,
        allowedExtensions: ['png', 'jpg', 'jpeg']);

    // final result2 = await

    if (result == null) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('No File Selected!')));
      return;
    }

    final Uint8List? bytes = result.files.single.bytes;
    final fileName = result.files.single.name;

    _infoData['photoUrl'] = {
      'bytes': bytes,
      'fileName': fileName,
    };

    setState(() {
      photo = Image.memory(bytes!);
    });
  }
}
