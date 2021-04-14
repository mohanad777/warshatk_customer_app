import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:warshatkcustomerapp/AllScreens/MainScreen.dart';
import 'package:warshatkcustomerapp/AllScreens/Request_Screen.dart';
import 'package:warshatkcustomerapp/widgets/B_NavigationBar.dart';

import '../main.dart';
import 'WorkshopListScreen.dart';

class WiatingScreen extends StatefulWidget {
  static const routeName = 'WiatingScreen';

  @override
  _WiatingScreenState createState() => _WiatingScreenState();
}

class _WiatingScreenState extends State<WiatingScreen> {
  var status;
  var value = false;
  var noRespned = false;
  var con = CountDownController();
  @override
  void initState() {
    super.initState();
    FirebaseDatabase.instance
        .reference()
        .child('Request')
        .onValue
        .listen((event) {
      var snapshot = event.snapshot;
      setState(() {
        value =
            snapshot.value['${(cust.id + (cust.numOfRequest - 1).toString())}']
                ['isAccepted'];
        status =
            snapshot.value['${(cust.id + (cust.numOfRequest - 1).toString())}']
                ['status'];
        if (value) {
          print(value);
          con.pause();
        } else if (status == 'rejected') con.pause();
      });
    });
  }

  void page() {}

  @override
  Widget build(BuildContext context) {
    final _mq = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        height: _mq.height,
        width: double.infinity,
        color: Color.fromRGBO(226, 226, 226, 1.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: _mq.height * 0.06,
              ),
              CircularCountDownTimer(
                duration: 20,
                initialDuration: 0,
                controller: con,
                width: _mq.width * 0.24,
                height: _mq.height * 0.24,
                ringColor: Colors.grey[300],
                ringGradient: null,
                fillColor: Colors.red,
                fillGradient: null,
                backgroundColor: Colors.black12,
                backgroundGradient: null,
                strokeWidth: 20.0,
                strokeCap: StrokeCap.round,
                textStyle: TextStyle(
                    fontSize: 33.0,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
                textFormat: CountdownTextFormat.S,
                isReverse: true,
                isReverseAnimation: false,
                isTimerTextShown: true,
                autoStart: true,
                onStart: () {
                  print('Countdown Started');
                },
                onComplete: () {
                  setState(() {
                    noRespned = true;
                  });

                  print('Countdown Ended');
                },
              ),

              if (value)
                AlertDialog(
                  title: Text('Your request is accepted'),
                  content: SingleChildScrollView(
                    child: ListBody(
                      children: <Widget>[
                        Text('Thank you.....'),
                      ],
                    ),
                  ),
                  actions: <Widget>[
                    RaisedButton(
                      child: Text('Done'),
                      onPressed: () {
                        setState(() {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      B_NavigationBar(
                                        index: 1,
                                      )));
                        });
                      },
                    ),
                  ],
                ),

              if (noRespned || status == 'rejected')
                AlertDialog(
                  title: Text('There is no respond'),
                  content: SingleChildScrollView(
                    child: ListBody(
                      children: <Widget>[
                        Text('Back to workshops.'),
                        // Text('Would you like to approve of this message?'),
                      ],
                    ),
                  ),
                  actions: <Widget>[
                    RaisedButton(
                      child: Text('Back'),
                      onPressed: () {
                        setState(() {
                          int count = 0;
                          Navigator.of(context).popUntil((_) => count++ >= 2);
                        });
                      },
                    ),
                  ],
                ),

              /////

              SizedBox(
                height: _mq.height * 0.10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Text(
                    "Your request was sent successfully !",
                    style: TextStyle(
                      fontSize: 23,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: _mq.height * 0.06,
              ),
              Text(
                "1- Get your car off the road. ",
                style: TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
              Text(
                "2- Use the safety triangle.",
                style: TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
              Text(
                "3- Turn on emergency flasher.",
                style: TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: _mq.height * 0.07,
              ),
              Text(
                "Wait for the Workshop response please.",
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
