import 'package:flutter/material.dart';

class ProgressDailog extends StatelessWidget {
  String message;
  ProgressDailog(this.message);
  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.blueGrey,
      child: Container(
        height: 50,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          color: Colors.white,
        ),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            children: [
              SizedBox(
                width: 6,
              ),
              CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
              ),
              SizedBox(
                width: 22,
              ),
              Text(
                message,
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
