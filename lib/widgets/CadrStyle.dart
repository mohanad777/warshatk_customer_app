import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:warshatkcustomerapp/Models/Car.dart';
import 'package:warshatkcustomerapp/widgets/WorkshopServices.dart';

class CardStyle extends StatefulWidget {
  static int initial = 0;

  int index;
  final String operation;
  final String selectedIcone;
  bool current = false;
  var workshopName;
  var workshopId;

  CardStyle(
      {this.operation,
      this.selectedIcone,
      this.current,
      this.index,
      this.workshopName,
      this.workshopId});
  @override
  _CardStyleState createState() => _CardStyleState();
}

class _CardStyleState extends State<CardStyle> {
  void _startAddNewTransaction(
      BuildContext ctx, Car car, int index, var workshopName, var workshopId) {
    showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(15.0)),
      ),
      context: ctx,
      builder: (_) {
        return GestureDetector(
          onTap: () {},
          child: WorkshopServices(car, index, workshopName, workshopId),
          behavior: HitTestBehavior.opaque,
        );
      },
    );
  }

//  Color c=Colors.white70;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          if (Provider.of<Car>(context, listen: false).getCar().make != null) {
            Car car = Provider.of<Car>(context, listen: false).getCar();
            _startAddNewTransaction(context, car, widget.index,
                widget.workshopName, widget.workshopId);
          }
        });
      },
      child: Container(
        margin: EdgeInsets.only(right: 16),
        width: 100,
        height: 100,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.blueGrey,
              blurRadius: 8,
              spreadRadius: 4,
              offset: Offset(6.0, 6.0),
            )
          ],
          borderRadius: BorderRadius.circular(15),
          color: widget.current ? Colors.black87 : Colors.white70,
        ),
        child: Column(
          children: [
            SizedBox(
              height: 16,
            ),
            Center(
                child: SvgPicture.asset(
              widget.selectedIcone,
              height: 70,
              width: 70,
            )),
            SizedBox(
              height: 8,
            ),
            Text(
              widget.operation,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w800,
                color: Colors.blueGrey,
                fontFamily: "Brand Bold",
              ),
            )
          ],
        ),
      ),
    );
  }
}
