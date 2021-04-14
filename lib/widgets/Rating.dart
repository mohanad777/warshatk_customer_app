
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import 'package:warshatkcustomerapp/Models/Workshop.dart';
class Rating extends StatefulWidget {
  String servProvider;
Rating(this.servProvider);
  @override
  _RatingState createState() => _RatingState();
}

class _RatingState extends State<Rating> {
  @override
  Widget build(BuildContext context) {

    return RatingBar.builder(
        initialRating: 3,
        minRating: 1,
        direction: Axis.horizontal,
        allowHalfRating: true,
        itemCount: 5,
        itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
        itemBuilder: (context, _) => Icon(
          Icons.star,
          color: Colors.amber,
        ),
        onRatingUpdate: (double rating) {
          int value = rating.toInt();
       Provider.of<Workshops>(context,listen: false).updateRating(widget.servProvider, value);


        },
      );
  }
}
