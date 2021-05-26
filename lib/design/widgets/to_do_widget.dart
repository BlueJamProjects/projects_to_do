import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:projects_to_do/design/constants.dart';
import 'package:projects_to_do/services/database_helper.dart';


class ToDoWidget extends StatelessWidget {
  final Function edit;
  final DatabaseHelper dbHelper;
  final int id;
  final String text;
  final bool? complete;
  final Function refresh;
  final bool hasCheckbox;
  ToDoWidget({required this.hasCheckbox, required this.id, required this.text, required this.dbHelper, required this.edit, required this.complete, required this.refresh});

  @override
  Widget build(BuildContext context) {
    return Padding(
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
                      decoration: complete == true? TextDecoration.lineThrough : TextDecoration.none,
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    hasCheckbox ?
                    Checkbox(
                      //this is used to mark the task as complete
                        value: complete,
                        activeColor: kTextColor,
                        checkColor: Colors.black,
                        hoverColor: Colors.grey,
                        onChanged: (x){
                          dbHelper.update(id: id, text: text, complete: x);
                          refresh();
                        }
                    ) : SizedBox(width: 10,),
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
                        dbHelper.delete(id);
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
    );
  }
}