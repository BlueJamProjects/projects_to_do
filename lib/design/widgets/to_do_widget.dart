
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:projects_to_do/design/constants.dart';
import 'package:projects_to_do/services/database_functions.dart';
import 'package:projects_to_do/services/database_helper.dart';


class ToDoWidget extends StatelessWidget {
  final Function edit;
  final DatabaseHelper dbHelper;
  final int id;
  final String text;
  final bool complete;
  final Function refresh;
  ToDoWidget({required this.id, required this.text, required this.dbHelper, required this.edit, required this.complete, required this.refresh});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      key: Key("$id"),
      onVerticalDragStart: (start){},
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(5),
          child: Container(
            decoration: BoxDecoration(
                color: kOnPrimaryColor
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width/2,
                    child: Text(text,
                      softWrap: true,
                      style: TextStyle(
                        fontSize: 24,
                        color: kTextColor,
                        decoration: complete? TextDecoration.lineThrough : TextDecoration.none,
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Checkbox(
                        //this is used to mark the video as seen
                        value: complete,
                        activeColor: kTextColor,
                        checkColor: Colors.black,
                        hoverColor: Colors.grey,
                        onChanged: (x){
                          databaseUpdate(
                            id: id,
                            text: text,
                            dbHelper: dbHelper,
                            complete: complete? "false": "true",
                          );
                          refresh();
                        }
                      ),
                      IconButton(
                        color: kTextColor,
                        icon: Icon(Icons.mode_edit),
                        onPressed: (){
                          edit(id);
                        },
                      ),
                      IconButton(
                        color: kTextColor,
                        icon: Icon(Icons.delete),
                        onPressed: (){
                          databaseDelete(
                            id: id,
                            dbHelper: dbHelper,
                          );
                          refresh();
                        },
                      ),
                    ],
                  ),

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}