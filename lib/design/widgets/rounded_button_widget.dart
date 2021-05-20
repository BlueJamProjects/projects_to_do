import 'package:flutter/material.dart';
import 'package:projects_to_do/design/constants.dart';

Widget roundedButtonWidget({required Function onPressed, required String text}){
  return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Container(
        color: kPrimaryColor,
        child: TextButton(onPressed: (){
          onPressed();
        },  child: Text(text,
          style: TextStyle(
            fontSize: 24,
            color: kOnPrimaryColor,
          ),
        ),
        ),
      ));
}