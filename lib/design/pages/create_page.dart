import 'package:flutter/material.dart';
import 'package:projects_to_do/design/constants.dart';
import 'package:projects_to_do/design/pages/landing_page.dart';
import 'package:projects_to_do/design/widgets/rounded_button_widget.dart';
import 'package:projects_to_do/design/widgets/text_info_widget.dart';
import '../../services/database_helper.dart';
import '../../services/database_functions.dart';

class CreatePage extends StatefulWidget {
  @override
  _CreatePageState createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage> {
  final dbHelper = DatabaseHelper.instance;
  TextEditingController textController = TextEditingController();

  DateTime date = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
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
                    labelText: "What do you need to do?",
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
                        text: "Submit",
                        onPressed: (){
                            databaseInsert(
                              text: textController.text,
                              complete: "false",
                              dbHelper: dbHelper,
                            );
                            print("added a person");
                            Navigator.of(context).pushReplacement( MaterialPageRoute(builder: (context)=> LandingPage()),)  ;

                        },
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
