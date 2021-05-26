import 'package:flutter/material.dart';
import 'package:projects_to_do/design/constants.dart';


Widget textInfoWidget({required controller, required String labelText}){
  return Container(
    decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(3),
    border: Border.all(
      color: kPrimaryColor,
      width: 3,
    )
    ),

    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        autofocus: true,
        controller: controller,
        cursorColor: kTextColor,
        style: TextStyle(
          fontSize: 24,
          decorationColor: kTextColor,
          color: kTextColor,
        ),
        decoration: InputDecoration(
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: kOnTextColor,
            ),
          ),
          labelText: labelText,
          alignLabelWithHint: true,
          labelStyle: TextStyle(
            fontSize: 22,
            color: kTextColor,
          ),
        ),
      ),
    ),
  );
}