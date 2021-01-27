import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'Searchs.dart';
import 'TopHeadlines.dart';
import 'sources.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool loadData;
  Map<String, dynamic> apiServerData = {};
  Future<Map> getDataFromServer() async {
    String websiteURL =
        "http://newsapi.org/v2/everything?q=tesla&from=2020-12-26&sortBy=publishedAt&apiKey=f6699206c33849519c5dc416068ea5ea";

    http.Response response = await http.get(websiteURL);
    if (response.statusCode == 200) {
      return json.decode(response.body);
    }
    return null;
  }

  @override
  void initState() {
    loadData = true;
    getDataFromServer().then((respones) {
      setState(() {
        apiServerData = respones;
        loadData = false;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
          child: Container(
              color: Colors.black,
              child: ListView(
                padding: EdgeInsets.only(top: 20),
                children: <Widget>[
                  ListTile(
                    leading: Icon(
                      Icons.view_headline,
                      color: Colors.white,
                    ),
                    contentPadding: EdgeInsets.only(top: 30),
                    title: Text(
                      'Top Headlines',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Top()),
                      );
                    },
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.select_all_sharp,
                      color: Colors.white,
                    ),
                    contentPadding: EdgeInsets.only(top: 30),
                    title: Text(
                      'Everything',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Home()),
                      );
                    },
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.view_headline,
                      color: Colors.white,
                    ),
                    contentPadding: EdgeInsets.only(top: 30),
                    title: Text(
                      'Sources',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Thesources()),
                      );
                    },
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.search,
                      color: Colors.white,
                    ),
                    contentPadding: EdgeInsets.only(top: 30),
                    title: Text(
                      'Search',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Searchs()),
                      );
                    },
                  ),
                ],
              ))),
      // bottomNavigationBar: Home(),
      appBar: AppBar(
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        title: Text(
          "Articles",
          style: TextStyle(color: Colors.black, fontSize: 30),
        ),
      ),
      backgroundColor: Colors.white,
      body: loadData
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
}
