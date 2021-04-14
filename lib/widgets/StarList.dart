import 'package:flutter/material.dart';

class StarList extends StatelessWidget {
  int rating;
  List<Icon> stars = [];
  void _addStars() {
    if (stars.isNotEmpty) {
      stars.removeLast();
    }
    for (int i = 0; i < rating; i++) {
      stars.add(
        Icon(
          Icons.star,
          color: Colors.amber,
        ),
      );
    }
    if (rating < 5) {
      for (int i = 0; i < (5 - rating); i++) {
        stars.add(
          Icon(
            Icons.star,
            color: Colors.black12,
          ),
        );
      }
    }
  }

  StarList(this.rating);
  @override
  Widget build(BuildContext context) {
    _addStars();

    return Container(
        margin: EdgeInsets.only(left: 3, right: 3),
        child: Row(
          children: [
            Text(
              '$rating',
              style: TextStyle(color: Colors.amber),
            ),
            Row(
              children: stars,
            ),
          ],
        ));
  }
}
