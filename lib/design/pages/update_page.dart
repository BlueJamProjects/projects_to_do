import 'package:flutter/material.dart';
import 'package:projects_to_do/design/constants.dart';
import 'package:projects_to_do/design/pages/landing_page.dart';
import 'package:projects_to_do/design/widgets/rounded_button_widget.dart';
import 'package:projects_to_do/design/widgets/text_info_widget.dart';
import 'package:projects_to_do/services/database_helper.dart';

class UpdatePage extends StatefulWidget {
  final String text;
  final bool? complete;
  final int id;
  UpdatePage({required this.id, required this.text, required this.complete});
  @override
  _UpdatePersonPageState createState() => _UpdatePersonPageState();
}

class _UpdatePersonPageState extends State<UpdatePage> {
  final dbHelper = DatabaseHelper.instance;
  TextEditingController textController = TextEditingController();
  bool? complete = false;

  @override
  void initState() {
    complete = widget.complete;
    textController.text = widget.text;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Container(
            decoration: BoxDecoration(
                color: kOnTextColor,
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  textInfoWidget(
                    controller: textController,
                    labelText: "Enter the new text"
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      roundedButtonWidget(
                          text: "Cancel",
                          onPressed: (){
                            Navigator.of(context).pushReplacement( MaterialPageRoute(builder: (context)=> LandingPage()),);
                          }
                      ),
                      roundedButtonWidget(
                        text: "Update",

                        onPressed: (){
                          print(textController.text);
                          dbHelper.update(id: widget.id, text: textController.text, complete: widget.complete).then((value){
                            print("changed the text");
                            Navigator.of(context).pushReplacement( MaterialPageRoute(builder: (context)=> LandingPage()),);
                          });

                          }
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