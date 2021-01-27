// ignore: unused_import
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

// ignore: camel_case_types
class Searchs extends StatefulWidget {
  _SearchsState createState() => _SearchsState();
}

// ignore: camel_case_types
class _SearchsState extends State<Searchs> {
  List<HeadLines> _heads = List<HeadLines>();

  List<HeadLines> headLines = List<HeadLines>();

  List<HeadLines> _headsForDisplay = List<HeadLines>();
  // ignore: non_constant_identifier_names
  var HeadsJson;

  Future<List<HeadLines>> fetchNotes() async {
    // ignore: unused_local_variable
    String url =
        'http://newsapi.org/v2/everything?q=apple&from=2021-01-25&to=2021-01-25&sortBy=popularity&apiKey=f6699206c33849519c5dc416068ea5ea'; //status 200(ok)

    var response = await http.get(url);
    var headLine = List<HeadLines>();

    if (response.statusCode == 200) {
      var headsJson = json.decode(response.body);
      // ignore: unused_local_variable
      for (var linesJson in headsJson) {
        headLine.add(HeadLines.fromJson(headsJson));
      }
    }
    return headLine;
  }

  bool isLoading;
  @override
  void initState() {
    isLoading = true;
    fetchNotes().then((value) {
      setState(() {
        headLines.addAll(value);
        isLoading = false;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        title: Text(
          "Search",
          style: TextStyle(color: Colors.black, fontSize: 30),
        ),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return index == 0 ? _searchBar() : _listItem(index - 1);
        },
        itemCount: _headsForDisplay.length + 1,
      ),
      backgroundColor: Colors.white,
    );
  }

  _searchBar() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        decoration: InputDecoration(
          labelText: "Search",
          hintText: "Search",
          prefixIcon: Icon(
            Icons.search,
            color: Colors.black,
          ),
          fillColor: Colors.black,
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.black, width: 3.0),
            borderRadius: BorderRadius.circular(40.0),
          ),
        ),
        onChanged: (text) {
          text = text.toLowerCase();
          setState(() {
            _headsForDisplay = _heads.where((note) {
              var noteTitle = note.name.toLowerCase();
              return noteTitle.contains(text);
            }).toList();
          });
        },
      ),
    );
  }

  _listItem(index) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.only(
            top: 32.0, bottom: 32.0, left: 16.0, right: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              _headsForDisplay[index].name,
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            Text(
              _headsForDisplay[index].name,
              style: TextStyle(color: Colors.grey.shade600),
            ),
          ],
        ),
      ),
    );
  }
}

class HeadLines {
  String source;
  String name;
  HeadLines(this.source, this.name);
  HeadLines.fromJson(Map<String, dynamic> json) {
    source = json["HeadLines"];
    name = json["name"];
  }
}
