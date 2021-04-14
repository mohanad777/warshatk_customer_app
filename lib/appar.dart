import 'package:flutter/material.dart';

class Appbars extends StatelessWidget {
  final tital;
  Appbars(this.tital);
  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFFdc143c).withOpacity(0.9),
        border: Border.all(color: const Color(0xFFdc143c).withOpacity(0.9)),
      ),
      child: Padding(
        padding: EdgeInsets.only(top: 20.0, right: 10.0, left: 10.0),
        child: Row(
          //mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            // back to menu icon
            IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  size: 35,
                  color: Colors.white,
                ),
                onPressed: () {
                  Navigator.pop(context);  
                }),
            SizedBox(
              width: mq.width * 0.22,
            ),
            Text(
              tital,
              style: TextStyle(
                  fontSize: 24,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),

            // edit profile icon
          ],
        ),
      ),
    );
  }
}
