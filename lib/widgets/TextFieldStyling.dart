import 'package:flutter/material.dart';

class TextFieldStyling extends StatelessWidget {
  final String name ;
  bool en = false ;
  TextFieldStyling(this.name,this.en);
  @override
  Widget build(BuildContext context) {
    return    Card(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18.0),
            side: BorderSide(color: Colors.white)),
        color: Color(0xffFFFFFF),
        elevation: 5,
        margin:EdgeInsets.symmetric(horizontal: 25),
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: TextField(
            enabled: en,
            maxLines: 1,
            decoration: InputDecoration.collapsed(hintText: name),

          ),
        )
    );
  }
}
