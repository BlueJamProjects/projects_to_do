import 'package:flutter/material.dart';
import 'package:projects_to_do/design/pages/landing_page.dart';
import 'package:projects_to_do/design/pages/reorderable_test.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      title: 'Projects To Do',
      theme: ThemeData().copyWith(
        unselectedWidgetColor: Colors.white,
      ),
      home: PageStorageTest(),
    );
  }
}