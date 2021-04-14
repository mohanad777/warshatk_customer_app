import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:warshatkcustomerapp/AllScreens/WaitingScreen.dart';
import 'package:warshatkcustomerapp/Models/Bill.dart';
import 'package:warshatkcustomerapp/Models/Car.dart';
import 'package:warshatkcustomerapp/Models/Request.dart';

import '../main.dart';
import 'ProgressDailog.dart';

class WorkshopServicesItem extends StatefulWidget {
  final String service;
  final double price;
  final workshopName;
  final workshopId;

  ListOfBill lob = ListOfBill();
  Bill b = Bill();
  Request r = Request();

  WorkshopServicesItem(
      {this.service, this.price, this.workshopId, this.workshopName});

  @override
  _WorkshopServicesItemState createState() => _WorkshopServicesItemState();
}

class _WorkshopServicesItemState extends State<WorkshopServicesItem> {
  ListOfRequests lor = ListOfRequests();
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 8),
      child: InkWell(
        onTap: () async {
          ProgressDailog('Wait');
          widget.b.id =
              cust.id + ('0' + cust.numOfRequest.toString()).toString();
          widget.b.describtion = widget.service;
          widget.b.amount = widget.price;
          widget.b.payDate = DateTime.now();
          widget.r.billNo = widget.b.id;
          widget.r.customer = cust.id;
          widget.r.details = widget.service;
          widget.r.requestDate = DateTime.now();
          widget.r.status = 'new';
          widget.r.date = DateTime.now();
          widget.r.servProvider = widget.workshopId;
          Car newCar = Provider.of<Car>(context, listen: false).getCar();
          await lor.addRequest(widget.r, newCar);
          await widget.lob.addBill(widget.b);
          Navigator.of(context).pushReplacementNamed(WiatingScreen.routeName);
        },
        child: Card(
          elevation: 8,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
          margin: EdgeInsets.all(4),
          child: ListTile(
            title: Text(widget.service),
            subtitle: Text(widget.workshopName),
            trailing: CircleAvatar(
              backgroundColor: Colors.black12,
              radius: 34,
              child: Padding(
                padding: EdgeInsets.all(6),
                child: FittedBox(
                  child: Text(
                    '${widget.price.toStringAsFixed(0)} SAR',
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.w700),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
