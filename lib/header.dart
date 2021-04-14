import 'package:flutter/material.dart';
import 'widgets/Decoration.dart';
class Header extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
   // decoration: decoration,
  color: Colors.blueGrey,

      child: Column(children: [  

SizedBox(height: 14,),
 Center(child: Text('Welcome to Warshatak'),),
 
SizedBox(height: 16,),
        
      ],),
      
    );
  }
}