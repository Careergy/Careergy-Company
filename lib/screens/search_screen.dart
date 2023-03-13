import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import '../models/user.dart';
import '../providers/keywords_provider.dart';

import '../widgets/Search_Textfield.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late List userList = [];

  Future<void> getSearchResults(Map<String, List<String>> mappingList) async {
    if (userList.isNotEmpty) {
      userList.clear();
    }
    List list = await User().getSearchResults(
        mappingList['job_titles'] as List<String>,
        mappingList['locations'] as List<String>,
        mappingList['level'] as List<String>);
    userList.addAll(list);
    // print(list);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    // final media = MediaQuery.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Search for Applicants', style: TextStyle(color: Colors.black45)),
        backgroundColor: Colors.white,
        shadowColor: Colors.black26,
        toolbarHeight: 30,
      ),
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SearchArea(getSearchResults: getSearchResults),
            const Divider(),
            SearchResultArea(userList: userList),
          ],
        ),
      ),
    );
  }
}

class SearchArea extends StatefulWidget {
  const SearchArea({super.key, required this.getSearchResults});

  final Function getSearchResults;

  @override
  State<SearchArea> createState() => _SearchAreaState();
}

class _SearchAreaState extends State<SearchArea> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  List<String> _kOptions = [];
  late String listType;
  Map<String, List<String>> _searchData = {
    'job_titles': [],
    'locations': [],
    'level': [],
    'other': []
  };

  var _isLoading = false;

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('An Error Occurred!'),
        content: Text(message),
        actions: <Widget>[
          TextButton(
            child: const Text('Okay'),
            onPressed: () {
              Navigator.of(ctx).pop();
            },
          )
        ],
      ),
    );
  }

  Future<List<String>> getKeywords(String type) async {
    if (_kOptions.isEmpty || (type != listType)) {
      _kOptions = await Keywords().getKeywords(type);
      listType = type;
    }
    setState(() {});
    print(_kOptions);
    return _kOptions;
  }

  Future<void> _submit() async {
    // if (!_formKey.currentState!.validate()) {
    //   // Invalid!
    //   return;
    // }
    _formKey.currentState!.save();
    setState(() {
      _isLoading = true;
    });
    // print(_searchData['job_titles']);
    widget.getSearchResults(_searchData);
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Container(
      width: deviceSize.width * 0.8,
      height: deviceSize.height * 0.27,
      padding: const EdgeInsets.all(10.0),
      child: Form(
        key: _formKey,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
              width: (deviceSize.width * 0.7) / 3,
              child: Column(
                children: [
                  SearchTextfield(
                    kOptions: _kOptions,
                    entriesList: _searchData['job_titles'] as List<String>,
                    getKeywords: getKeywords,
                    keysDoc: 'job_titles',
                    label: 'Job Titles:',
                  ),
                  SearchTextfield(
                    kOptions: _kOptions,
                    entriesList: _searchData['locations'] as List<String>,
                    getKeywords: getKeywords,
                    keysDoc: 'locations',
                    label: 'Locations:',
                  ),
                ],
              ),
            ),
            SizedBox(
              width: (deviceSize.width * 0.7) / 3,
              child: Column(
                children: [
                  SearchTextfield(
                      kOptions: _kOptions,
                      getKeywords: getKeywords,
                      keysDoc: 'level',
                      label: 'Level:',
                      entriesList: _searchData['level'] as List<String>),
                ],
              ),
            ),
            SizedBox(
              width: (deviceSize.width * 0.7) / 3,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const ElevatedButton(
                    onPressed: null,
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStatePropertyAll(Colors.blueGrey),
                        fixedSize: MaterialStatePropertyAll(Size(150, 40))),
                    child: Text('Reset',
                        style: TextStyle(color: Colors.white, fontSize: 16)),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                    onPressed: _submit,
                    style: ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(
                            Theme.of(context).primaryColor),
                        fixedSize:
                            const MaterialStatePropertyAll(Size(150, 40))),
                    child: _isLoading
                        ? const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: CircularProgressIndicator(
                              color: Colors.white,
                            ),
                          )
                        : const Text(
                            'Search',
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class SearchResultArea extends StatefulWidget {
  SearchResultArea({super.key, required this.userList});

  late List userList;

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

  @override
  Widget build(BuildContext context) {
    return widget.userList.isEmpty
        ? const Center(child: Text('No Results'))
        : Container(
          height: MediaQuery.of(context).size.height *0.4,
          width: (MediaQuery.of(context).size.width *0.8) -1,
          child: Scrollbar(
              controller: _scrollController,
              child: SingleChildScrollView(
                controller: _scrollController,
                child: ListView.builder(
                  itemCount: widget.userList.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    // print(widget.userList);
                    return ListTile(
                      contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 6),
                      leading: const CircleAvatar(),
                      title: Text(widget.userList[index]['name']),
                    );
                  },
                ),
              ),
            ),
        );
  }
}
