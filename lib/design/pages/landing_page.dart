import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:projects_to_do/design/constants.dart';
import 'package:projects_to_do/design/pages/create_page.dart';
import 'package:projects_to_do/design/pages/update_page.dart';
import 'package:projects_to_do/design/widgets/to_do_widget.dart';
import 'package:projects_to_do/models/to_do.dart';
import 'package:projects_to_do/services/database_helper.dart';

class ArticleWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return ExpandablePanel(
      header: Text("Title"),
      collapsed: Text("Body", softWrap: true, maxLines: 2, overflow: TextOverflow.ellipsis,),
      expanded: Text("body w", softWrap: true, ),
    );
  }
}



class LandingPage extends StatefulWidget {



  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {

  List<Widget> toDoWidgets = [];

  final dbHelper = DatabaseHelper.instance;

  void refreshWidgets()async{
    //this is the function that creates the birthday widgets from the database
    dynamic toDos = [];
    toDoWidgets = [
      SizedBox(
        height: 30
      ),
    ];
    final allRows = await dbHelper.queryAllRows();
    print('query all rows:');
    allRows.forEach((row) => print(row));


    allRows.forEach((row) {
      print("Row ${row["text"]}");
      toDos.add(ToDo(text: row["text"], complete: row['complete'], id: row["id"]),);
    });

    for(ToDo x in toDos){
      print("x.text ${x.text}");
      toDoWidgets.add(
          ToDoWidget(
            refresh: (){
              refreshWidgets();
            },
            id: x.id,
            text: x.text,
            complete: x.complete == 'false'? false : true,
            dbHelper: dbHelper,
            edit: (int id){
              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context)=> UpdatePage(id: id, text: x.text, complete: x.complete,)));
            },
          ));
    }
    toDoWidgets.add(
      SizedBox(height: 80,)
    );
    setState(() {

    });
  }


  @override
  void initState() {
    refreshWidgets();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body: SingleChildScrollView(
        child: Column(
          children: toDoWidgets,
        ),
      ),
      floatingActionButton: Container(
        decoration: BoxDecoration(
          color: kTextColor,
          borderRadius: BorderRadius.circular(100),
          border: Border.all(
            color: kTextColor,
            width: 1,
            
          ),
          
        ),
        
        child: FloatingActionButton(
          onPressed: (){
            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context)=> CreatePage()));
          },
          backgroundColor: kOnTextColor,

          child: Padding(
            padding: const EdgeInsets.all(1.0),
            child: Icon(Icons.add),
          ),
        ),
      ),
    );
  }
}