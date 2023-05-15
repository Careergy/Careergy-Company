import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

// import './search_screen.dart';
import './file_view_screen.dart';

import '../models/applicant.dart';

import '../constants.dart';

class ApplicantSearchProfileScreen extends StatefulWidget {
  ApplicantSearchProfileScreen({super.key, this.toggle, this.applicant});

  Applicant? applicant;
  Function? toggle;

  @override
  State<ApplicantSearchProfileScreen> createState() => _ApplicantSearchProfileScreenState();
}

class _ApplicantSearchProfileScreenState extends State<ApplicantSearchProfileScreen> {
  _ApplicantSearchProfileScreenState();

  final ScrollController _scrollbarController = ScrollController();

  List<bool> isSelected = [true, false];
  bool isPersonalShowed = true;
  bool downloaded = false;

  Future getApplicantInfo(String id) async {
    if (!downloaded) {
      widget.applicant!.briefcv = await Applicant.getBriefCV(id);
      // print(widget.applicant!.briefcv!['majors']);
      downloaded = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: accentCanvasColor,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(top: 15),
        child: ElevatedButton(
            style: ButtonStyle(
              shape: MaterialStateProperty.all(const CircleBorder()),
              padding: MaterialStateProperty.all(const EdgeInsets.all(20)),
              backgroundColor:
                  MaterialStateProperty.all(primaryColor), // <-- Button color
              overlayColor: MaterialStateProperty.resolveWith<Color?>(
                (states) {
                  if (states.contains(MaterialState.pressed)) {
                    return actionColor; // <-- Splash color
                  }
                },
              ),
            ),
            onPressed: () => Navigator.of(context).pop(),
            child: const Icon(Icons.arrow_back_rounded)),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniStartTop,
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
          padding: const EdgeInsets.only(top: 8.0),
          decoration: const BoxDecoration(
            color: canvasColor,
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          child: Column(
            children: [
              Container(
                height: 45,
                width: deviceSize.width * 0.2,
                decoration: const BoxDecoration(
                  color: titleBackground,
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                child: const Center(
                    child: Text('Applicant Profile',
                        style: TextStyle(
                            color: white,
                            fontSize: 18,
                            fontWeight: FontWeight.w800))),
              ),
              const SizedBox(height: 8),
              divider,
              FutureBuilder(
                future: getApplicantInfo(widget.applicant!.uid),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else {
                    return Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: SizedBox(
                        height: deviceSize.height * 0.72,
                        child: Scrollbar(
                          controller: _scrollbarController,
                          child: SingleChildScrollView(
                            controller: _scrollbarController,
                            child: Column(
                              // mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 10, left: 50, bottom: 20),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: <Widget>[
                                      FittedBox(
                                        fit: BoxFit.fill,
                                        child: CircleAvatar(
                                            radius: 90,
                                            backgroundImage: widget.applicant!
                                                            .photoUrl ==
                                                        null ||
                                                    widget.applicant!.photoUrl!
                                                            .substring(0, 4) !=
                                                        'http'
                                                ? null
                                                : NetworkImage(
                                                    widget.applicant!.photoUrl ??
                                                        ''),
                                            child: widget.applicant!.photoUrl == null ||
                                                    widget.applicant!.photoUrl!
                                                            .substring(0, 4) !=
                                                        'http'
                                                ? ClipOval(child: widget.applicant!.photo)
                                                : null),
                                      ),
                                      const SizedBox(
                                        width: 40,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          widget.applicant!.name ?? '',
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 30,
                                              color: white),
                                        ),
                                      ),
                                      // const Padding(
                                      //   padding: EdgeInsets.all(8.0),
                                      //   child: Icon(
                                      //     Icons.email,
                                      //     color: kBlue,
                                      //   ),
                                      // ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 30,
                                ),
                                divider,
                                const SizedBox(
                                  height: 10,
                                ),
                                Center(
                                  child: ToggleButtons(
                                    borderRadius: BorderRadius.circular(10),
                                    borderColor: Colors.white,
                                    selectedColor: kBlue,
                                    disabledColor: Colors.white,
                                    textStyle: const TextStyle(fontSize: 20),
                                    selectedBorderColor: kBlue,
                                    disabledBorderColor: Colors.grey,
                                    isSelected: isSelected,
                                    onPressed: (int index) {
                                      setState(() {
                                        for (int buttonIndex = 0;
                                            buttonIndex < isSelected.length;
                                            buttonIndex++) {
                                          if (buttonIndex == index) {
                                            isSelected[buttonIndex] = true;
                                          } else {
                                            isSelected[buttonIndex] = false;
                                          }
                                        }
                                      });
                                    },
                                    children: const <Widget>[
                                      SizedBox(
                                        width: 350,
                                        child: Center(
                                          child: Padding(
                                            padding: EdgeInsets.all(3.0),
                                            child: Text('Personal Info',
                                                style: TextStyle(color: white)),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 350,
                                        child: Center(
                                          child: Padding(
                                            padding: EdgeInsets.all(3.0),
                                            child: Text('Applicant Info',
                                                style: TextStyle(color: white)),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 30,
                                ),
                                isSelected[0]
                                    ? Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 50),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            // const Text(
                                            //   'About',
                                            //   style: TextStyle(
                                            //     fontWeight: FontWeight.bold,
                                            //     fontSize: 20,
                                            //     color: Colors.white60,
                                            //   ),
                                            // ),
                                            // const SizedBox(
                                            //   height: 20,
                                            // ),
                                            // SizedBox(
                                            //   width: 500,
                                            //   child: Text(
                                            //     widget.applicant!.bio == ''
                                            //         ? 'Not Available'
                                            //         : widget.applicant!.bio ??
                                            //             'Not Available',
                                            //     style: const TextStyle(
                                            //       fontWeight: FontWeight.normal,
                                            //       fontSize: 20,
                                            //       color: white,
                                            //     ),
                                            //   ),
                                            // ),
                                            // const SizedBox(
                                            //   height: 30,
                                            // ),
                                            // const Text(
                                            //   'Email',
                                            //   style: TextStyle(
                                            //     fontWeight: FontWeight.bold,
                                            //     fontSize: 20,
                                            //     color: Colors.white60,
                                            //   ),
                                            // ),
                                            // const SizedBox(
                                            //   height: 20,
                                            // ),
                                            // Text(
                                            //   widget.applicant!.email ?? '',
                                            //   style: const TextStyle(
                                            //     fontWeight: FontWeight.normal,
                                            //     fontSize: 20,
                                            //     color: white,
                                            //   ),
                                            // ),
                                            // const SizedBox(
                                            //   height: 30,
                                            // ),
                                            // const Text(
                                            //   'Phone Number',
                                            //   style: TextStyle(
                                            //     fontWeight: FontWeight.bold,
                                            //     fontSize: 20,
                                            //     color: Colors.white60,
                                            //   ),
                                            // ),
                                            // const SizedBox(
                                            //   height: 20,
                                            // ),
                                            // Text(
                                            //   widget.applicant!.phone == ''
                                            //       ? 'Not Available'
                                            //       : widget.applicant!.phone ??
                                            //           'Not Available',
                                            //   style: const TextStyle(
                                            //     fontWeight: FontWeight.normal,
                                            //     fontSize: 20,
                                            //     color: white,
                                            //   ),
                                            // ),
                                            // const SizedBox(
                                            //   height: 30,
                                            // ),
                                            Container(
                                              decoration: const BoxDecoration(
                                                  color: canvasColor),
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 50),
                                              child: Column(
                                                children: [
                                                  Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        children: [
                                                          Row(
                                                            children: [
                                                              const Icon(
                                                                Icons.email,
                                                                color: kBlue,
                                                              ),
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .only(
                                                                        left:
                                                                            15.0),
                                                                child: Text(
                                                                  widget.applicant!
                                                                          .email ??
                                                                      'No Email',
                                                                  style: const TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .normal,
                                                                      fontSize:
                                                                          20,
                                                                      color: Colors
                                                                          .white70),
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
                                                                    const EdgeInsets
                                                                            .only(
                                                                        left:
                                                                            15),
                                                                child: Text(
                                                                  widget.applicant!
                                                                          .phone ??
                                                                      'No Phone Number',
                                                                  style: const TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .normal,
                                                                      fontSize:
                                                                          20,
                                                                      color: Colors
                                                                          .white70),
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
                                                                Icons
                                                                    .pin_drop_rounded,
                                                                color: kBlue,
                                                              ),
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .only(
                                                                        left:
                                                                            15),
                                                                child: Text(
                                                                  widget.applicant!
                                                                              .address ==
                                                                          ''
                                                                      ? 'No Address'
                                                                      : widget.applicant!
                                                                              .address ??
                                                                          'No Address',
                                                                  style: const TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .normal,
                                                                      fontSize:
                                                                          20,
                                                                      color: Colors
                                                                          .white70),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        width: 100,
                                                        height:
                                                            deviceSize.height *
                                                                0.29,
                                                        child: Center(
                                                          child: Container(
                                                              width: 1,
                                                              color: Colors.grey
                                                                  .shade200),
                                                        ),
                                                      ),
                                                      Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        children: [
                                                          // const Text(
                                                          //   'About The Company:',
                                                          //   style: TextStyle(
                                                          //       fontWeight: FontWeight.normal,
                                                          //       fontSize: 20,
                                                          //       color: white),
                                                          // ),
                                                          // const SizedBox(
                                                          //   height: 20,
                                                          // ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    left: 15),
                                                            child: SizedBox(
                                                              width: deviceSize
                                                                      .width *
                                                                  0.37,
                                                              child: Text(
                                                                widget.applicant!
                                                                            .bio ==
                                                                        ''
                                                                    ? 'No Bio'
                                                                    : widget.applicant!
                                                                            .bio ??
                                                                        'No Bio',
                                                                style:
                                                                    TextStyle(
                                                                  fontWeight: widget
                                                                              .applicant!
                                                                              .bio ==
                                                                          ''
                                                                      ? FontWeight
                                                                          .w100
                                                                      : FontWeight
                                                                          .normal,
                                                                  fontSize: 20,
                                                                  color: Colors
                                                                      .grey,
                                                                ),
                                                                textAlign:
                                                                    TextAlign
                                                                        .justify,
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    : Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 50),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            widget.applicant?.briefcv == null
                                                ? const SizedBox(
                                                    height: 100,
                                                    child: Center(
                                                      child: Text('No Brief CV',
                                                          style: TextStyle(
                                                              color: white)),
                                                    ),
                                                  )
                                                : Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      const Text(
                                                        '\tMajors:',
                                                        style: TextStyle(
                                                          color: Colors.white60,
                                                          fontSize: 20,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width:
                                                            deviceSize.width *
                                                                0.45,
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(10.0),
                                                          child: Wrap(
                                                              children: widget
                                                                      .applicant!
                                                                      .briefcv![
                                                                          'majors']!
                                                                      .isEmpty
                                                                  ? [
                                                                      const Text(
                                                                        'Not Data',
                                                                        style:
                                                                            TextStyle(
                                                                          color:
                                                                              Colors.white54,
                                                                          fontSize:
                                                                              14,
                                                                        ),
                                                                      )
                                                                    ]
                                                                  : widget
                                                                      .applicant!
                                                                      .briefcv![
                                                                          'majors']!
                                                                      .map((e) =>
                                                                          Padding(
                                                                            padding:
                                                                                const EdgeInsets.all(10),
                                                                            child:
                                                                                Container(
                                                                              height: 35,
                                                                              width: 200,
                                                                              padding: const EdgeInsets.symmetric(horizontal: 10),
                                                                              decoration: const BoxDecoration(
                                                                                color: primaryColor,
                                                                                borderRadius: BorderRadius.all(Radius.circular(20)),
                                                                              ),
                                                                              child: Center(child: Text(e, style: const TextStyle(color: white))),
                                                                            ),
                                                                          ))
                                                                      .toList()),
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                          height: 20),
                                                      const Text(
                                                        '\tJob Titles:',
                                                        style: TextStyle(
                                                          color: Colors.white60,
                                                          fontSize: 20,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 500,
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(10.0),
                                                          child: Wrap(
                                                              children: widget
                                                                      .applicant!
                                                                      .briefcv![
                                                                          'job_title']!
                                                                      .isEmpty
                                                                  ? [
                                                                      const Text(
                                                                        'Not Data',
                                                                        style:
                                                                            TextStyle(
                                                                          color:
                                                                              Colors.white54,
                                                                          fontSize:
                                                                              14,
                                                                        ),
                                                                      )
                                                                    ]
                                                                  : widget
                                                                      .applicant!
                                                                      .briefcv![
                                                                          'job_title']!
                                                                      .map((e) =>
                                                                          Padding(
                                                                            padding:
                                                                                const EdgeInsets.all(10),
                                                                            child:
                                                                                Container(
                                                                              height: 35,
                                                                              width: 200,
                                                                              padding: const EdgeInsets.symmetric(horizontal: 10),
                                                                              decoration: const BoxDecoration(
                                                                                color: primaryColor,
                                                                                borderRadius: BorderRadius.all(Radius.circular(20)),
                                                                              ),
                                                                              child: Center(child: Text(e, style: const TextStyle(color: white))),
                                                                            ),
                                                                          ))
                                                                      .toList()),
                                                        ),
                                                      ),
                                                      const Text(
                                                        '\tMajor Skills:',
                                                        style: TextStyle(
                                                          color: Colors.white60,
                                                          fontSize: 20,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width:
                                                            deviceSize.width *
                                                                0.45,
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(10.0),
                                                          child: Wrap(
                                                              children: widget
                                                                      .applicant!
                                                                      .briefcv![
                                                                          'major_skills']!
                                                                      .isEmpty
                                                                  ? [
                                                                      const Text(
                                                                        'Not Data',
                                                                        style:
                                                                            TextStyle(
                                                                          color:
                                                                              Colors.white54,
                                                                          fontSize:
                                                                              14,
                                                                        ),
                                                                      )
                                                                    ]
                                                                  : widget
                                                                      .applicant!
                                                                      .briefcv![
                                                                          'major_skills']!
                                                                      .map((e) =>
                                                                          Padding(
                                                                            padding:
                                                                                const EdgeInsets.all(10),
                                                                            child:
                                                                                Container(
                                                                              height: 35,
                                                                              width: 200,
                                                                              padding: const EdgeInsets.symmetric(horizontal: 10),
                                                                              decoration: const BoxDecoration(
                                                                                color: primaryColor,
                                                                                borderRadius: BorderRadius.all(Radius.circular(20)),
                                                                              ),
                                                                              child: Center(child: Text(e, style: const TextStyle(color: white))),
                                                                            ),
                                                                          ))
                                                                      .toList()),
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                          height: 20),
                                                      const Text(
                                                        '\tSoft Skills:',
                                                        style: TextStyle(
                                                          color: Colors.white60,
                                                          fontSize: 20,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width:
                                                            deviceSize.width *
                                                                0.45,
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(10.0),
                                                          child: Wrap(
                                                              children: widget
                                                                      .applicant!
                                                                      .briefcv![
                                                                          'soft_skills']!
                                                                      .isEmpty
                                                                  ? [
                                                                      const Text(
                                                                        'Not Data',
                                                                        style:
                                                                            TextStyle(
                                                                          color:
                                                                              Colors.white54,
                                                                          fontSize:
                                                                              14,
                                                                        ),
                                                                      )
                                                                    ]
                                                                  : widget
                                                                      .applicant!
                                                                      .briefcv![
                                                                          'soft_skills']!
                                                                      .map((e) =>
                                                                          Padding(
                                                                            padding:
                                                                                const EdgeInsets.all(10),
                                                                            child:
                                                                                Container(
                                                                              height: 35,
                                                                              width: 200,
                                                                              padding: const EdgeInsets.symmetric(horizontal: 10),
                                                                              decoration: const BoxDecoration(
                                                                                color: primaryColor,
                                                                                borderRadius: BorderRadius.all(Radius.circular(20)),
                                                                              ),
                                                                              child: Center(child: Text(e, style: const TextStyle(color: white))),
                                                                            ),
                                                                          ))
                                                                      .toList()),
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                          height: 20),
                                                      const Text(
                                                        '\tInterests:',
                                                        style: TextStyle(
                                                          color: Colors.white60,
                                                          fontSize: 20,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width:
                                                            deviceSize.width *
                                                                0.45,
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(10.0),
                                                          child: Wrap(
                                                              children: widget
                                                                      .applicant!
                                                                      .briefcv![
                                                                          'intrests']!
                                                                      .isEmpty
                                                                  ? [
                                                                      const Text(
                                                                        'Not Data',
                                                                        style:
                                                                            TextStyle(
                                                                          color:
                                                                              Colors.white54,
                                                                          fontSize:
                                                                              14,
                                                                        ),
                                                                      )
                                                                    ]
                                                                  : widget
                                                                      .applicant!
                                                                      .briefcv![
                                                                          'intrests']!
                                                                      .map((e) =>
                                                                          Padding(
                                                                            padding:
                                                                                const EdgeInsets.all(10),
                                                                            child:
                                                                                Container(
                                                                              height: 35,
                                                                              width: 200,
                                                                              padding: const EdgeInsets.symmetric(horizontal: 10),
                                                                              decoration: const BoxDecoration(
                                                                                color: primaryColor,
                                                                                borderRadius: BorderRadius.all(Radius.circular(20)),
                                                                              ),
                                                                              child: Center(child: Text(e, style: const TextStyle(color: white))),
                                                                            ),
                                                                          ))
                                                                      .toList()),
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                          height: 20),
                                                      const Text(
                                                        '\tPrefered Locations:',
                                                        style: TextStyle(
                                                          color: Colors.white60,
                                                          fontSize: 20,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width:
                                                            deviceSize.width *
                                                                0.45,
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(10.0),
                                                          child: Wrap(
                                                              children: widget
                                                                      .applicant!
                                                                      .briefcv![
                                                                          'prefered_locations']!
                                                                      .isEmpty
                                                                  ? [
                                                                      const Text(
                                                                        'Not Data',
                                                                        style:
                                                                            TextStyle(
                                                                          color:
                                                                              Colors.white54,
                                                                          fontSize:
                                                                              14,
                                                                        ),
                                                                      )
                                                                    ]
                                                                  : widget
                                                                      .applicant!
                                                                      .briefcv![
                                                                          'prefered_locations']!
                                                                      .map((e) =>
                                                                          Padding(
                                                                            padding:
                                                                                const EdgeInsets.all(10),
                                                                            child:
                                                                                Container(
                                                                              height: 35,
                                                                              width: 200,
                                                                              padding: const EdgeInsets.symmetric(horizontal: 10),
                                                                              decoration: const BoxDecoration(
                                                                                color: primaryColor,
                                                                                borderRadius: BorderRadius.all(Radius.circular(20)),
                                                                              ),
                                                                              child: Center(child: Text(e, style: const TextStyle(color: white))),
                                                                            ),
                                                                          ))
                                                                      .toList()),
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                          height: 20),
                                                      const Text(
                                                        '\tOther Skills:',
                                                        style: TextStyle(
                                                          color: Colors.white60,
                                                          fontSize: 20,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width:
                                                            deviceSize.width *
                                                                0.45,
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(10.0),
                                                          child: Wrap(
                                                              children: widget
                                                                      .applicant!
                                                                      .briefcv![
                                                                          'other_skills']!
                                                                      .isEmpty
                                                                  ? [
                                                                      const Text(
                                                                        'Not Data',
                                                                        style:
                                                                            TextStyle(
                                                                          color:
                                                                              Colors.white54,
                                                                          fontSize:
                                                                              14,
                                                                        ),
                                                                      )
                                                                    ]
                                                                  : widget
                                                                      .applicant!
                                                                      .briefcv![
                                                                          'other_skills']!
                                                                      .map((e) =>
                                                                          Padding(
                                                                            padding:
                                                                                const EdgeInsets.all(10),
                                                                            child:
                                                                                Container(
                                                                              height: 35,
                                                                              width: 200,
                                                                              padding: const EdgeInsets.symmetric(horizontal: 10),
                                                                              decoration: const BoxDecoration(
                                                                                color: primaryColor,
                                                                                borderRadius: BorderRadius.all(Radius.circular(20)),
                                                                              ),
                                                                              child: Center(child: Text(e, style: const TextStyle(color: white))),
                                                                            ),
                                                                          ))
                                                                      .toList()),
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                          height: 20),
                                                    ],
                                                  ),

                                            // Row(
                                            //   children: [
                                            //     Column(
                                            //       crossAxisAlignment:
                                            //           CrossAxisAlignment.start,
                                            //       children: [
                                            //         const Text(
                                            //           'Major',
                                            //           style: TextStyle(
                                            //             color: Colors.white60,
                                            //             fontSize: 20,
                                            //           ),
                                            //         ),
                                            //         const SizedBox(
                                            //           height: 20,
                                            //         ),
                                            //         const Text(
                                            //           'info.major1',
                                            //           style: TextStyle(
                                            //               fontWeight:
                                            //                   FontWeight.normal,
                                            //               fontSize: 20),
                                            //         ),
                                            //         const Text(
                                            //           'info.major2',
                                            //           style: TextStyle(
                                            //               fontWeight:
                                            //                   FontWeight.normal,
                                            //               fontSize: 20),
                                            //         ),
                                            //       ],
                                            //     ),
                                            //     const SizedBox(
                                            //       width: 100,
                                            //     ),
                                            //     Column(
                                            //       crossAxisAlignment:
                                            //           CrossAxisAlignment.start,
                                            //       children: [
                                            //         const Text(
                                            //           'Major Skills',
                                            //           style: TextStyle(
                                            //               fontWeight:
                                            //                   FontWeight.bold,
                                            //               fontSize: 20),
                                            //         ),
                                            //         const SizedBox(
                                            //           height: 20,
                                            //         ),
                                            //         const Text(
                                            //           'info.major_skills1',
                                            //           style: TextStyle(
                                            //               fontWeight:
                                            //                   FontWeight.normal,
                                            //               fontSize: 20),
                                            //         ),
                                            //         const Text(
                                            //           'info.major_skills2',
                                            //           style: TextStyle(
                                            //               fontWeight:
                                            //                   FontWeight.normal,
                                            //               fontSize: 20),
                                            //         ),
                                            //       ],
                                            //     ),
                                            //   ],
                                            // ),
                                            // const SizedBox(
                                            //   height: 30,
                                            // ),
                                            // const Divider(),
                                            // Column(
                                            //   crossAxisAlignment:
                                            //       CrossAxisAlignment.start,
                                            //   children: [
                                            //     const Text(
                                            //       'Soft Skills',
                                            //       style: TextStyle(
                                            //           fontWeight:
                                            //               FontWeight.bold,
                                            //           fontSize: 20),
                                            //     ),
                                            //     const SizedBox(
                                            //       height: 20,
                                            //     ),
                                            //     const Text(
                                            //       'info.soft_skills1',
                                            //       style: TextStyle(
                                            //           fontWeight:
                                            //               FontWeight.normal,
                                            //           fontSize: 20),
                                            //     ),
                                            //     const Text(
                                            //       'info.soft_skills2',
                                            //       style: TextStyle(
                                            //           fontWeight:
                                            //               FontWeight.normal,
                                            //           fontSize: 20),
                                            //     ),
                                            //     const Text(
                                            //       'info.soft_skills3',
                                            //       style: TextStyle(
                                            //           fontWeight:
                                            //               FontWeight.normal,
                                            //           fontSize: 20),
                                            //     ),
                                            //   ],
                                            // ),
                                            // const Divider(),
                                            // Column(
                                            //   crossAxisAlignment:
                                            //       CrossAxisAlignment.start,
                                            //   children: [
                                            //     const Text(
                                            //       'Intrests',
                                            //       style: TextStyle(
                                            //           fontWeight:
                                            //               FontWeight.bold,
                                            //           fontSize: 20),
                                            //     ),
                                            //     const SizedBox(
                                            //       height: 20,
                                            //     ),
                                            //     const Text(
                                            //       'info.intrests1',
                                            //       style: TextStyle(
                                            //           fontWeight:
                                            //               FontWeight.normal,
                                            //           fontSize: 20),
                                            //     ),
                                            //     const Text(
                                            //       'info.intrests2',
                                            //       style: TextStyle(
                                            //           fontWeight:
                                            //               FontWeight.normal,
                                            //           fontSize: 20),
                                            //     ),
                                            //     const SizedBox(
                                            //       height: 30,
                                            //     ),
                                            //     const Text(
                                            //       'preferred locations',
                                            //       style: TextStyle(
                                            //           fontWeight:
                                            //               FontWeight.bold,
                                            //           fontSize: 20),
                                            //     ),
                                            //     const SizedBox(
                                            //       height: 20,
                                            //     ),
                                            //     const Text(
                                            //       'info.locations1',
                                            //       style: TextStyle(
                                            //           fontWeight:
                                            //               FontWeight.normal,
                                            //           fontSize: 20),
                                            //     ),
                                            //     const Text(
                                            //       'info.locations2',
                                            //       style: TextStyle(
                                            //           fontWeight:
                                            //               FontWeight.normal,
                                            //           fontSize: 20),
                                            //     ),
                                            //   ],
                                            // ),
                                            divider,
                                            const Text(
                                              'Attachments',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20,
                                                  color: white),
                                            ),
                                            const SizedBox(
                                              height: 20,
                                            ),
                                            Container(
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  border:
                                                      Border.all(color: kBlue)),
                                              child: ListTile(
                                                title: const Text(
                                                    'Attachment1.pdf'),
                                                leading: CircleAvatar(
                                                  backgroundColor: kBlue,
                                                  child: InkWell(
                                                    onTap: () {
                                                      Navigator.of(context)
                                                          .push(
                                                        MaterialPageRoute(
                                                          builder: (context) {
                                                            return const FileViewer();
                                                          },
                                                        ),
                                                      );
                                                    },
                                                    child: const ClipOval(
                                                      child: Icon(
                                                        Icons.download,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            Container(
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  border:
                                                      Border.all(color: kBlue)),
                                              child: ListTile(
                                                title: const Text(
                                                    'Attachment2.pdf'),
                                                leading: CircleAvatar(
                                                  backgroundColor: kBlue,
                                                  child: InkWell(
                                                    onTap: () {},
                                                    child: const ClipOval(
                                                      child: Icon(
                                                        Icons.download,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
