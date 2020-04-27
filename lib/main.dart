import 'package:flutter/material.dart';
import 'package:github_info/screens/github.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GitHub-Profile',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        accentColor: Colors.transparent,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MyGitHub();
  }
}
