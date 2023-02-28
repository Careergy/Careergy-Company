import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    // final media = MediaQuery.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Search'),
        // backgroundColor: Color.fromRGBO(0,0,0,0),
      ),
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: const [
            SearchArea(),
            Divider(),
            // ListView.builder(itemBuilder: itemBuilder)
          ],
        ),
      ),
    );
  }
}

class SearchArea extends StatefulWidget {
  const SearchArea({super.key});

  @override
  State<SearchArea> createState() => _SearchAreaState();
}

class _SearchAreaState extends State<SearchArea> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  Map<String, String> _searchData = {
    'job_title': '',
    'location': '',
    'level': '',
    'other': ''
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

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) {
      // Invalid!
      return;
    }
    _formKey.currentState!.save();
    setState(() {
      _isLoading = true;
    });

  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Container(
      width: deviceSize.width * 0.8,
      height: deviceSize.height * 0.225,
      padding: EdgeInsets.all(10.0),
      child: Form(
        key: _formKey,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
              width: (deviceSize.width * 0.7) / 3,
              child: Column(
                children: [
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Job Title'),
                    onSaved: (value) {
                      _searchData['job_title'] = value!;
                    },
                    validator: (value) {
                      if (value!.isEmpty || value.length < 2) {
                        return 'Job title is too short!';
                      }
                    },
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Location'),
                    onSaved: (value) {
                      _searchData['location'] = value!;
                    },
                    validator: (value) {
                      if (value!.isEmpty || value.length < 2) {
                        return 'Location is too short!';
                      }
                    },
                  ),
                ],
              ),
            ),
            SizedBox(
              width: (deviceSize.width * 0.7) / 3,
              child: Column(
                children: [
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Level'),
                    onSaved: (value) {
                      _searchData['level'] = value!;
                    },
                    validator: (value) {
                      if (value!.isEmpty || value.length < 2) {
                        return 'Level is too short!';
                      }
                    },
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Other'),
                    onSaved: (value) {
                      _searchData['other'] = value!;
                    },
                    validator: (value) {
                      if (value!.isEmpty || value.length < 2) {
                        return 'Other title is too short!';
                      }
                    },
                  ),
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
                    child: Text('Reset',
                        style: TextStyle(color: Colors.white, fontSize: 16)),
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStatePropertyAll(Colors.blueGrey),
                        fixedSize: MaterialStatePropertyAll(Size(150, 40))),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                    onPressed: _submit,
                    child: _isLoading
                        ? const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: CircularProgressIndicator(color: Colors.white,),
                        )
                        : Text('Search',
                            style:
                                TextStyle(color: Colors.white, fontSize: 16)),
                    style: ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(
                            Theme.of(context).primaryColor),
                        fixedSize: const MaterialStatePropertyAll(Size(150, 40))),
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
