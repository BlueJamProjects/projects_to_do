import 'package:flutter/material.dart';
import 'package:projects_to_do/design/constants.dart';
import 'package:projects_to_do/design/pages/create_page.dart';
import 'package:projects_to_do/design/pages/update_page.dart';
import 'package:projects_to_do/design/widgets/to_do_widget.dart';
import 'package:projects_to_do/models/to_do.dart';
import 'package:projects_to_do/services/database_helper.dart';

class TestLandingPage extends StatefulWidget {
  const TestLandingPage({Key? key}) : super(key: key);

  @override
  State<TestLandingPage> createState() => _TestLandingPageState();
}


class _TestLandingPageState extends State<TestLandingPage> {
  final List<int> _items = List<int>.generate(50, (int index) => index);

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final Color oddItemColor = colorScheme.primary.withOpacity(0.05);
    final Color evenItemColor = colorScheme.primary.withOpacity(0.15);

    return Scaffold(
      body: ReorderableListView(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        children: <Widget>[
          for (int index = 0; index < _items.length; index++)
            ListTile(
              key: Key('$index'),
              tileColor: _items[index].isOdd ? oddItemColor : evenItemColor,
              title: Text('Item ${_items[index]}'),
            ),
        ],
        onReorder: (int oldIndex, int newIndex) {
          setState(() {
            if (oldIndex < newIndex) {
              newIndex -= 1;
            }
            final int item = _items.removeAt(oldIndex);
            _items.insert(newIndex, item);
          });
        },
      ),
    );
  }
}

final myKey = GlobalKey<_MyCheckBoxState>();
class PageStorageTest extends StatefulWidget {
  // const PageStorageTest({Key key}) : super(key: key);

  @override
  _PageStorageTestState createState() => _PageStorageTestState();
}

class _PageStorageTestState extends State<PageStorageTest> {

  Widget activePage = Page1();
  bool? isOne = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            TextButton(
                onPressed: (){
                  setState(() {
                    if (isOne == true){
                      isOne = false;
                    }else{
                      isOne = true;
                    }
                    switchPages(isOne);
                  });
                },
                child: Text("Switch"),
            ),
          ],
        ),
      ),
      body: activePage,
    );
  }


  void switchPages(bool? isFirst){
    print(myKey.currentState!.myVal);
    if(isFirst == true){
      activePage = Page1();

    }else{
      activePage = Page2();

    }
  }
}

class MyCheckBox extends StatefulWidget {
  const MyCheckBox({Key? key}) : super(key: key);
  @override
  _MyCheckBoxState createState() => _MyCheckBoxState();
}

class _MyCheckBoxState extends State<MyCheckBox> {
  bool? myVal = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue,
      child: Checkbox(
          value: myVal,
          onChanged: (val){
            setState(() {
                myVal = val!;
            });
          }),
    );
  }
}


class Page1 extends StatefulWidget {

  @override
  _Page1State createState() => _Page1State();
}

class _Page1State extends State<Page1> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: MyCheckBox(
        key: myKey,
      ),
    );
  }
}

class Page2 extends StatefulWidget {

  @override
  _Page2State createState() => _Page2State();
}

class _Page2State extends State<Page2> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
      Text("Test"),
      MyCheckBox(
        key: myKey,
      ),
      ],
    );
  }
}