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
      home: LandingPage(),
    );
  }
}


class NewPage extends StatefulWidget {
  const NewPage({Key? key}) : super(key: key);

  @override
  _NewPageState createState() => _NewPageState();
}

class _NewPageState extends State<NewPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text("1234"),
    );
  }
}
