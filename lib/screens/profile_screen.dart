import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:file_picker/file_picker.dart';

import '../widgets/custom_textfieldform.dart';

import '../models/company.dart';

import '../constants.dart';

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
                  backgroundColor: accentCanvasColor,
                  body: ListView(
                    children: [
                      Stack(
                        alignment: AlignmentDirectional.bottomStart,
                        clipBehavior: Clip.none,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 40, right: 15, left: 15),
                            child: Container(
                              width: double.infinity,
                              height: 150,
                              decoration: const BoxDecoration(
                                color: primaryColor,
                                borderRadius: BorderRadius.all(Radius.circular(20)),
                              ),
                            ),
                          ),
                          Positioned(
                            top: MediaQuery.of(context).size.height * 0.02,
                            left: 40,
                            child: Container(
                              padding: const EdgeInsets.all(5),
                              child: FittedBox(
                                fit: BoxFit.fill,
                                child: CircleAvatar(
                                  radius: 120,
                                  child: ClipOval(
                                    child: info.photoUrl == null ||
                                            info.photoUrl == '' ||
                                            info.photoUrl!.substring(0, 4) !=
                                                'http'
                                        ? info.photo
                                        : Image.network(
                                            info.photoUrl ?? '',
                                            loadingBuilder: (context, child,
                                                loadingProgress) {
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
                            ),
                          ),
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 20, left: 310),
                            child: Text(
                              info.name ?? '',
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 30,
                                  color: white),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: ElevatedButton(
                                style: const ButtonStyle(
                                    backgroundColor:
                                        MaterialStatePropertyAll(primaryColor),
                                    shape: MaterialStatePropertyAll(
                                        RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(20))))),
                                child: Row(
                                  children: const [
                                    Padding(
                                      padding: EdgeInsets.only(right: 15),
                                      child: Text(
                                        'Edit',
                                        style: TextStyle(
                                          fontWeight: FontWeight.normal,
                                          fontSize: 15,
                                        ),
                                      ),
                                    ),
                                    Icon(
                                      Icons.edit,
                                      color: Colors.white,
                                    ),
                                  ],
                                ),
                                onPressed: () {
                                  setState(() {
                                    currentPage = '/editProfile';
                                  });
                                }),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 45,
                      ),
                      Container(
                        height: 0.5,
                        color: Colors.white24,
                      ),
                      Container(
                        decoration:
                            const BoxDecoration(color: accentCanvasColor),
                        padding: const EdgeInsets.symmetric(
                            vertical: 20, horizontal: 75),
                        child: Column(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.email,
                                          color: kBlue,
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 15.0),
                                          child: Text(
                                            info.email ?? '',
                                            style: const TextStyle(
                                                fontWeight: FontWeight.normal,
                                                fontSize: 20,
                                                color: Colors.white70),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 30,
                                    ),
                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.phone,
                                          color: kBlue,
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 15),
                                          child: Text(
                                            info.phone ?? 'Not Available',
                                            style: const TextStyle(
                                                fontWeight: FontWeight.normal,
                                                fontSize: 20,
                                                color: Colors.white70),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16),
                                  child: SizedBox(
                                    width: 1,
                                    height: 200,
                                    child:
                                        Container(color: Colors.grey.shade200),
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'About Company',
                                      style: TextStyle(
                                          fontWeight: FontWeight.normal,
                                          fontSize: 20,
                                          color: white),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 15),
                                      child: SizedBox(
                                        width: 500,
                                        child: Text(
                                          info.bio == ''
                                              ? 'No Bio'
                                              : info.bio ?? 'No Bio',
                                          style: TextStyle(
                                              fontWeight: info.bio == ''
                                                  ? FontWeight.w100
                                                  : FontWeight.normal,
                                              fontSize: 20,
                                              color: Colors.grey),
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                          ],
                        ),
                      ),
                    ],
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
  TextEditingController? bioCtrl;

  _editProfileState(this.currentPage);
  @override
  Widget build(BuildContext context) {
    final info = Provider.of<Company>(context);
    if (!_isInitialized) {
      nameCtrl = TextEditingController.fromValue(
          TextEditingValue(text: info.name ?? ''));
      emailCtrl = TextEditingController.fromValue(
          TextEditingValue(text: info.email ?? ''));
      phoneCtrl = TextEditingController.fromValue(
          TextEditingValue(text: info.phone ?? ''));
      bioCtrl = TextEditingController.fromValue(
          TextEditingValue(text: info.bio ?? ''));
      _isInitialized = true;
    }
    photo ??= info.hasPhoto
          ? info.photo
          : const Image(image: AssetImage('/avatarPlaceholder.png'));
    return currentPage == '/profile'
        ? const profileScreen()
        : Scaffold(
            backgroundColor: accentCanvasColor,
            body: ListView(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                bottom: 30, right: 50, left: 30),
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
                                onChanged: (value) {
                                  _infoData['bio'] = value;
                                },
                                controller: bioCtrl,
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
