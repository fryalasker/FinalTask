import 'package:flutter/material.dart';

import 'Home.dart';
import 'Searchs.dart';
import 'TopHeadlines.dart';
import 'sources.dart';

// ignore: camel_case_types

// ignore: camel_case_types

Widget drawer(BuildContext context) {
  return Scaffold(
      drawer: Drawer(
          child: Container(
              color: Colors.purple[200],
              child: ListView(
                padding: EdgeInsets.only(left: 5),
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
              ))));
}
