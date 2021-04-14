import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:warshatkcustomerapp/Models/Bill.dart';
import 'package:warshatkcustomerapp/Models/Customer.dart';
import 'package:warshatkcustomerapp/Models/PaymentSystem.dart';
import 'package:warshatkcustomerapp/Models/Request.dart';
import 'package:warshatkcustomerapp/widgets/WorkshopItem.dart';
import 'package:warshatkcustomerapp/Models/WorkshopCategory.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:warshatkcustomerapp/main.dart';
import 'package:flutter/widgets.dart';

import '../HeaderCurvedContainer.dart';
import '../appar.dart';

class MainPage extends StatefulWidget {
  static const routName = "MainPage";

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final databaseReferenceTest = FirebaseDatabase.instance.reference();
  bool relay1pressed = true;

  final List<WorkshopCategory> categories = [
    WorkshopCategory(0, "WORKSHOP"),
    WorkshopCategory(1, "EMERGENCY"),
    WorkshopCategory(2, "REGULAR MAINTENANCE"),
    WorkshopCategory(3, "CLEANING"),
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: const Color.fromRGBO(226, 226, 226, 1.0),
          child: Column(
            children: <Widget>[
              Appbars('Workshop'),
              CustomPaint(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: mq.height * 0.17,
                ),
                painter: HeaderCurvedContainer(),
              ),
              Expanded(
                child: Center(
                  child: GridView(
                    padding: EdgeInsets.all(15),
                    //makes the GridView to take minimum space and wrap the GridView with Center widget.
                    shrinkWrap: true,
                    children: categories
                        .map((e) => WorkshopItem(e.type, e.id))
                        .toList(),
                    gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                      mainAxisSpacing: 20,
                      crossAxisSpacing: 20,
                      maxCrossAxisExtent: 200,
                      childAspectRatio: 3 / 2,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
