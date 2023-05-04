import 'package:flutter/material.dart';
import 'package:textfield_tags/textfield_tags.dart';

import '../screens/applicant_profile_screen.dart';

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
                  : SizedBox(
                      height: MediaQuery.of(context).size.height * 0.4,
                      width: (MediaQuery.of(context).size.width * 0.8) - 1,
                      child: Scrollbar(
                        controller: _scrollController,
                        child: SingleChildScrollView(
                          controller: _scrollController,
                          child: ListView.builder(
                            itemCount: result!.length,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              // print(widget.userList);
                              return ListTile(
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 6),
                                leading: ClipOval(
                                  child: result![index].photoUrl == '' || result![index].photoUrl == null
                                      ? result![index].photo
                                      : Image.network(
                                          result![index].photoUrl ?? '',
                                          loadingBuilder: (context, child,
                                              loadingProgress) {
                                            if (loadingProgress == null) {
                                              return child;
                                            }
                                            return const CircularProgressIndicator(
                                                color: Colors.blue);
                                          },
                                        ),
                                ),
                                title: Text(result![index].name),
                                subtitle: Text(result![index].bio!.length > 20
                                    ? '${result![index].bio!.substring(0, 20)}...'
                                    : result![index].bio!),
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) =>
                                        ApplicantProfileScreen(
                                            applicant: result![index]),
                                  ));
                                },
                              );
                            },
                          ),
                        ),
                      ),
                    );
        }
      },
    );
  }
}
