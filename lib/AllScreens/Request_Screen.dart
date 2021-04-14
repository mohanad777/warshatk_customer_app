import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:warshatkcustomerapp/main.dart';
import 'package:provider/provider.dart';
import 'package:warshatkcustomerapp/widgets/ProgressDailog.dart';
import 'package:warshatkcustomerapp/widgets/RequestItem.dart';
import 'package:warshatkcustomerapp/Models/Request.dart';
import 'package:warshatkcustomerapp/widgets/Decoration.dart';
import 'package:warshatkcustomerapp/appar.dart';
import 'package:warshatkcustomerapp/HeaderCurvedContainer.dart';

class RequestScreen extends StatefulWidget {
  static const routName = "RequestScreen";

  @override
  _RequestScreenState createState() => _RequestScreenState();
}

class _RequestScreenState extends State<RequestScreen> {
  List<Request> req;

  /*List <Request>req=[Request(id:1,status:"Repairing",date: DateTime.now()),Request(id:2,status: "Finished",date: DateTime.now()),
    Request(id: 3,status: "Checking",date: DateTime.now()),
  ];*/
  var _isLoading = false;

  @override
  void initState() {
    Provider.of<ListOfRequests>(context, listen: false)
        .fetchRequest()
        .then((_) {
      setState(() {
        //   print(Provider.of<ListOfRequests>(context, listen: false).getWorkshops[0].id+"////////////////////////////////////////////////////////////////////////");
        _isLoading = true;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;
    req = Provider.of<ListOfRequests>(context, listen: false).getRequests;

    return Scaffold(
      body: SafeArea(
          child: Container(
        height: mq.height,
        //  decoration: decoration,
        color: const Color.fromRGBO(226, 226, 226, 1.0),

        child: _isLoading
            ? (cust.numOfRequest == 0 || req.length == 0)
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "NO REQUEST YET",
                        style: const TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.w800,
                          color: Colors.blueGrey,
                          fontFamily: "Brand Bold",
                        ),
                      ),
                      Image.asset(
                        'images/cute.png',
                        fit: BoxFit.cover,
                      ),
                    ],
                  )
                : Column(
                    children: [
                      Appbars('Request'),
                      CustomPaint(
                        child: Container(
                          child: Column(
                            children: [
                              SizedBox(
                                height: mq.height * 0.10,
                              ),
                              Text(
                                'Number of request: ${req.length}',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 22,
                                    color: Colors.white),
                              ),
                            ],
                          ),
                          width: MediaQuery.of(context).size.width,
                          height: mq.height * 0.17,
                        ),
                        painter: HeaderCurvedContainer(),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 10),
                        height: mq.height * 0.55,
                        child: ListView(
                          children: req.map((e) => RequestItem(e)).toList(),
                        ),
                      ),
                    ],
                  )
            : Center(child: CircularProgressIndicator()),
      )),
    );
  }
}
