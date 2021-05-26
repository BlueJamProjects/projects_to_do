import 'package:flutter/material.dart';
import 'package:projects_to_do/design/pages/landing_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      title: 'Projects To Do',
      theme: ThemeData().copyWith(
        unselectedWidgetColor: Colors.white,
      ),
      home: LandingPage(),
    );
  }
}