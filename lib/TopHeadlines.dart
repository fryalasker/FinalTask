import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Top extends StatefulWidget {
  @override
  _TopState createState() => _TopState();
}

class _TopState extends State<Top> {
  List<HeadLines> _headLine = List<HeadLines>();
  Map<String, dynamic> apiServerData = {};
  // ignore: missing_return
  Future<List<HeadLines>> fetchNotes() async {
    var url =
        'http://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=f6699206c33849519c5dc416068ea5ea'; //status 200(ok)
    var response = await http.get(url);
    var headLine = List<HeadLines>();

    if (response.statusCode == 200) {
      var headsJson = json.decode(response.body);
      debugPrint("${response.statusCode}");
      debugPrint("${response.body}");
      // ignore: unused_local_variable
      for (var linesJson in headsJson) {
        headLine.add(HeadLines.fromJson(headsJson));
      }
    }
    debugPrint("${response.statusCode}");
    return headLine;
  }

  @override
  void initState() {
    isLoading = true;
    fetchNotes().then((value) {
      setState(() {
        _headLine.addAll(value);
        debugPrint("$value");
        isLoading = false;
      });
    });
    super.initState();
  }

  bool isLoading;
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text('Articles News'),
          actions: [
            RaisedButton(onPressed: () {
              debugPrint("${_headLine[1].title}");
            }),
          ],
        ),
        backgroundColor: Colors.white,
        body: isLoading
            ? Center(child: CircularProgressIndicator())
            : Container(
                child: ListView.builder(
                  itemCount: apiServerData['articles'].length,
                  itemBuilder: ((BuildContext context, int index) {
                    return Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          ListTile(
                            leading: Icon(Icons.album),
                            title: Text(
                              '${apiServerData['articles'][index]['author']}',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text(
                              '${apiServerData['articles'][index]['publishedAt']}',
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                          //
                        ],
                      ),
                    );
                  }),
                ),
              ),
      );
}

// ignore: camel_case_types
class HeadLines {
  String author;
  String title;
  String description;
  HeadLines(this.author, this.title, this.description);
  HeadLines.fromJson(Map<String, dynamic> json) {
    author = json["HeadLines"];
    title = json["name"];
    description = json["description"];
  }
}
