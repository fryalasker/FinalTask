import 'package:flutter/material.dart';
import 'Home.dart';
import 'Searchs.dart';
import 'TopHeadlines.dart';
import 'sources.dart';

void main() {
  runApp(
    MaterialApp(
      title: 'NewsArtical',
      theme: ThemeData(
          primaryColor: Colors.purple[50], backgroundColor: Colors.purple[200]),
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        "/": (context) => Home(),
        "/first": (context) => Top(),
        "/Searchs": (context) => Searchs(),
        "/sources": (context) => Thesources(),
      },
    ),
  );
}
