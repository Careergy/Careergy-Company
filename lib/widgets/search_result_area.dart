import 'package:careergy_mobile/constants.dart';
import 'package:careergy_mobile/screens/search_applicant_profile.dart';
import 'package:flutter/material.dart';
import 'package:textfield_tags/textfield_tags.dart';

import '../screens/applicant_search_screan.dart';

import '../models/applicant.dart';

class SearchResultArea extends StatefulWidget {
  SearchResultArea({
    super.key,
    required this.interestsController,
    required this.jobTitleController,
    required this.locationsController,
    required this.majorSkillsController,
    required this.majorsController,
    required this.softSkillsController,
  });

  TextfieldTagsController majorsController;
  TextfieldTagsController jobTitleController;
  TextfieldTagsController majorSkillsController;
  TextfieldTagsController softSkillsController;
  TextfieldTagsController interestsController;
  TextfieldTagsController locationsController;

  @override
  State<SearchResultArea> createState() => _SearchResultAreaState();
}

class _SearchResultAreaState extends State<SearchResultArea> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController(initialScrollOffset: 10.0);
  }

  List<Applicant>? result;

  Future load() async {
    result = await Applicant.getSearchResults(
      widget.majorsController.getTags,
      widget.jobTitleController.getTags,
      widget.majorSkillsController.getTags,
      widget.softSkillsController.getTags,
      widget.interestsController.getTags,
      widget.locationsController.getTags,
    );
  }

  @override
  Widget build(BuildContext context) {
    load();
    return FutureBuilder(
      future: load(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else {
          // print(result![0].name);
          return result == null
              ? const Center()
              : result!.isEmpty
                  ? const Center(child: Text('No Results'))
                  : Scrollbar(
                      controller: _scrollController,
                      child: SingleChildScrollView(
                        controller: _scrollController,
                        child: ListView.builder(
                          itemCount: result!.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            // print(widget.userList);
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: ListTile(
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 6),
                                minLeadingWidth: 50,
                                leading: CircleAvatar(
                                    radius: 30,
                                    backgroundImage: result![index].photoUrl ==
                                                null ||
                                            result![index].photoUrl!
                                                    .substring(0, 4) !=
                                                'http'
                                        ? null
                                        : NetworkImage(
                                            result![index].photoUrl ??
                                                ''),
                                    child: result![index].photoUrl ==
                                                null ||
                                            result![index].photoUrl!
                                                    .substring(0, 4) !=
                                                'http'
                                        ? ClipOval(
                                            child: result![index].photo)
                                        : null),
                                title: Text(result![index].name ?? '',
                                    style: const TextStyle(color: white)),
                                subtitle: Text(
                                    result![index].bio!.length > 40
                                        ? '${result![index].bio!.substring(0, 40)}...'
                                        : result![index].bio!,
                                    style: const TextStyle(color: white)),
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) =>
                                        ApplicantSearchProfileScreen(applicant: result![index])
                                  ));
                                },
                                hoverColor: actionColor,
                                tileColor: canvasColor,
                                shape: const RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20))),
                              ),
                            );
                          },
                        ),
                      ),
                    );
        }
      },
    );
  }
}
