import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:intl/intl.dart';
import 'package:warshatkcustomerapp/AllScreens/PaymentScreen.dart';
import 'package:warshatkcustomerapp/Models/Bill.dart';
import 'package:warshatkcustomerapp/main.dart';
import 'package:url_launcher/url_launcher.dart';

class RequestInfo extends StatelessWidget {
  final requestId;
  final workshopId;
  Bill bill;
  double amount = 0;
  DateTime requestDate;
  var name = cust.name;
  String status, problem;
  final id;

  RequestInfo(
      {this.requestDate,
      this.status,
      this.problem,
      this.amount,
      this.requestId,
      this.bill,
      this.id,
      this.workshopId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Request Information',
          style: TextStyle(fontSize: 24),
        ),
        backgroundColor: const Color(0xFFdc143c).withOpacity(0.9),
        centerTitle: true,
      ),
      body: Container(
        color: Color.fromRGBO(226, 226, 226, 1.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 12,
            ),
            Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                    side: BorderSide(color: Colors.white)),
                color: Color(0xffFFFFFF),
                elevation: 5,
                margin: EdgeInsets.symmetric(horizontal: 25),
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Container(
                    height: 450,
                    width: 350,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(
                          height: 8,
                        ),
                        Container(
                            alignment: Alignment.center,
                            child: Text(
                              "Total Price",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            )),
                        SizedBox(
                          height: 8,
                        ),
                        if (bill.amount != null)
                          Container(
                              alignment: Alignment.center,
                              child: Text(
                                "${bill.amount}",
                                style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              )),
                        Divider(
                          color: Colors.black,
                        ),
                        SizedBox(
                          height: 22,
                        ),
                        Text(
                          "Request ID#$requestId",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(
                          height: 22,
                        ),
                        Text(
                          "Name: ${cust.name}",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(
                          height: 22,
                        ),
                        Text(
                          "Request date: ${DateFormat.yMMMd().format(requestDate)}",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(
                          height: 22,
                        ),
                        Text(
                          "Workshop name: ",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(
                          height: 22,
                        ),
                        Text(
                          "Status: $status",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(
                          height: 22,
                        ),
                        FittedBox(
                          child: Text(
                            "Problem details: $problem",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 22,
                        ),
                        if (status == 'pay')
                          RaisedButton(
                            color: Colors.amber,
                            textColor: Colors.white,
                            child: Container(
                              height: 38,
                              width: double.infinity,
                              child: Center(
                                child: Text(
                                  "Pay",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontFamily: "Brand Bold",
                                  ),
                                ),
                              ),
                            ),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => PaymentScreen(
                                            requestId: id,
                                            billId: bill.id,
                                            cost: bill.amount,
                                            workshopId: workshopId,
                                          )));
                            },
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(24),
                            ),
                          ),
                        if (status == 'workshop')
                          RaisedButton(
                            color: Colors.grey,
                            textColor: Colors.white,
                            child: Container(
                              height: 38,
                              width: double.infinity,
                              child: Center(
                                child: Text(
                                  "Camera",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontFamily: "Brand Bold",
                                  ),
                                ),
                              ),
                            ),
                            onPressed: () {
                              _launchURL();
                            },
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(24),
                            ),
                          ),
                      ],
                    ),
                  ),
                )),
            SizedBox(
              height: 40,
            ),
          ],
        ),
      ),
    );
  }

  _launchURL() async {
    // const url = 'http://196.168.43.211:5000';
    const url = 'http://172.20.10.26:5000';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
