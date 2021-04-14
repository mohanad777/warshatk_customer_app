import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:warshatkcustomerapp/AllScreens/ChooserCategoryWorkshopScreen.dart';
import 'package:warshatkcustomerapp/AllScreens/ProfileScreen.dart';
import 'package:warshatkcustomerapp/AllScreens/WorkshopListScreen.dart';
import 'package:warshatkcustomerapp/Models/Customer.dart';
import 'package:warshatkcustomerapp/Models/Workshop.dart';

class WorkshopItem extends StatelessWidget {
  final String workshop;
  final int id;

  WorkshopItem(this.workshop, this.id);

  void selectCategory(BuildContext ctx) {
    Navigator.of(ctx).pushNamed(WorkshopListScreen.routName);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Provider.of<Workshop>(context, listen: false).updateService(workshop);
        Navigator.of(context).pushNamed(
          WorkshopListScreen.routName,
        );
      },
      child: Container(
        margin: EdgeInsets.only(top: 6),
        child: Center(
            child: FittedBox(
                child: Text(
          workshop,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w800,
            color: Colors.blueGrey,
            fontFamily: "Brand Bold",
          ),
        ))),
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.blueGrey,
              blurRadius: 8,
              spreadRadius: 4,
              offset: Offset(6.0, 6.0),
            ),
          ],
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );
  }
}
