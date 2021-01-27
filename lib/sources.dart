import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Thesources extends StatefulWidget {
  @override
  _ThesourcesState createState() => _ThesourcesState();
}

class _ThesourcesState extends State<Thesources> {
  List<allHeadLines> _headLine = List<allHeadLines>();
  Map<String, dynamic> apiServerData = {};
  Future<List<allHeadLines>> fetchNotes() async {
    var url =
        'http://newsapi.org/v2/top-headlines?sources=techcrunch&apiKey=f6699206c33849519c5dc416068ea5ea';
    var response = await http.get(url);
    var headLine = List<allHeadLines>();
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    if (response.statusCode == 200) {
      var headsJson = json.decode(response.body);
      // ignore: unused_local_variable
      var headsJson2 = headsJson.toList();
      // ignore: unused_local_variable
      for (var linesJson in headsJson2.toList()) {
        headLine.add(allHeadLines.fromJson(headsJson));
      }
    }
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
          centerTitle: true,
          iconTheme: IconThemeData(color: Colors.purple[100]),
          backgroundColor: Colors.white,
          title: Text(
            "sources",
            style: TextStyle(color: Colors.black, fontSize: 25),
          ),
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
class allHeadLines {
  String id;
  String name;
  allHeadLines(this.id, this.name);
  allHeadLines.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    name = json["name"];
  }
}
