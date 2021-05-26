import 'package:flutter/material.dart';
import 'package:projects_to_do/design/constants.dart';
import 'package:projects_to_do/design/pages/create_page.dart';
import 'package:projects_to_do/design/pages/update_page.dart';
import 'package:projects_to_do/design/widgets/to_do_widget.dart';
import 'package:projects_to_do/models/to_do.dart';
import 'package:projects_to_do/services/database_functions.dart';
import 'package:projects_to_do/services/database_helper.dart';



class LandingPage extends StatefulWidget {
  const LandingPage({Key? key}) : super(key: key);


  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {

  List<Widget> toDoWidgets = [];
  dynamic toDos = [];

  final dbHelper = DatabaseHelper.instance;
  void refreshWidgets()async{
    //this is the function that creates the birthday widgets from the database

    populateToDos().then((value){
      toDos = value;
      toDoWidgets = [SizedBox(
        height: 30,
        key: Key("key"),
      )];



      for(ToDo x in toDos){
        toDoWidgets.add(
            Container(
              key: Key("${x.id}"),
              child: ToDoWidget(
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
              ),
            ));
      }
      toDoWidgets.add(
          SizedBox(height: 80,
            key: Key("final_widget"),)
      );
      setState(() {

      });
    });


  }

  Future<List<ToDo>> populateToDos()async{
    List<ToDo> _localToDos = [];
    await dbHelper.queryAllRows().then((value){
      value.forEach((row) {
        _localToDos.add(ToDo(text: row["text"], complete: row['complete'], id: row["id"]),);
      });
    });
    return _localToDos;
  }


  void reorder(int oldIndex, int newIndex) {

    for (ToDo x in toDos){
      print(x.complete);
    }

      if (oldIndex < toDoWidgets.length && oldIndex > 0 && newIndex > 0){
        if (oldIndex < newIndex) {
          newIndex -= 1;
        }
        ToDo firstToDo = toDos[oldIndex - 1];
        ToDo secondToDo = toDos[newIndex - 1];

        Widget toDo1 = toDoWidgets[oldIndex];
        Widget toDo2 = toDoWidgets[newIndex];

        toDoWidgets[oldIndex] = toDo2;
        toDoWidgets[newIndex] = Container(
          key: Key("sd${firstToDo.id}"),
          child: ToDoWidgetOption(
            hasCheckbox: true,
            refresh: (){
              refreshWidgets();
            },
            id: firstToDo.id,
            text: firstToDo.text,
            complete: firstToDo.complete == 'false'? false : true,
            dbHelper: dbHelper,
            edit: (int id){
              },
          ),
        );



        toDos[oldIndex - 1] = secondToDo;
        toDos[newIndex - 1] = firstToDo;


        print(firstToDo.text);
        print(secondToDo.text);

        databaseUpdate(id: firstToDo.id, text: secondToDo.text, complete: secondToDo.complete, dbHelper: dbHelper);
        databaseUpdate(id: secondToDo.id, text: firstToDo.text, complete: firstToDo.complete, dbHelper: dbHelper);

        refreshWidgets();
      }



  }


  @override
  void initState() {
     refreshWidgets();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: ReorderableListView(
        children: toDoWidgets,
        onReorder: (int oldIndex, int newIndex){
          reorder(oldIndex, newIndex);
        },
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