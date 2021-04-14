import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:warshatkcustomerapp/AllScreens/WaitingScreen.dart';
import 'package:warshatkcustomerapp/Models/Bill.dart';
import 'package:warshatkcustomerapp/Models/Car.dart';
import 'package:warshatkcustomerapp/Models/Request.dart';
import 'package:warshatkcustomerapp/main.dart';
import 'package:warshatkcustomerapp/widgets/CarChooser.dart';
import 'package:warshatkcustomerapp/widgets/ProgressDailog.dart';
import 'package:warshatkcustomerapp/widgets/TextFieldStyling.dart';
import 'package:provider/provider.dart';
import 'package:warshatkcustomerapp/AllScreens/Request_Screen.dart';

class WorkshopInfoScreen extends StatelessWidget {
  static const routName = 'WorkshopInfoScreen';
  ListOfRequests lor = ListOfRequests();
  ListOfBill lob = ListOfBill();
  Bill b = Bill();
  Request r = Request();

  TextEditingController descrip = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final routeArgs =
        ModalRoute.of(context).settings.arguments as Map<String, dynamic>;
    final workshoId = routeArgs['workshoId'];
    final mq = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        // resizeToAvoidBottomPadding: false,
        //  resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
          child: Container(
            color: const Color.fromRGBO(226, 226, 226, 1.0),
            height: mq.height,
            child: Column(
              children: [
             
                /*  Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(20),
                          bottomLeft: Radius.circular(20))),
                  height: 150,
                ),*/
                Container(
                  decoration: BoxDecoration(
                      color: const Color.fromRGBO(226, 226, 226, 1.0),
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(20),
                          topLeft: Radius.circular(20))),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    // crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      SizedBox(
                        height: mq.height * 0.08,
                      ),
                      ChooserCar(),

                      Text(
                        "    Type the details of your request below",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                          color: Colors.blueGrey,
                          fontFamily: "Brand Bold",
                        ),
                      ),

                      SizedBox(
                        height: mq.height * 0.08,
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
                            child: TextField(
                              maxLines: 8,
                              decoration: InputDecoration.collapsed(
                                  hintText: "Enter your text here"),
                              controller: descrip,
                            ),
                          )),
                      SizedBox(
                        height: mq.height * 0.12,
                      ),
                      // Button(name:'ٍSend',obj: Conf_SendRequest(),color: Colors.white,),

                      RaisedButton(
                        color: const Color(0xFFC62828),
                        textColor: Colors.white,
                        child: Container(
                          height: 38,
                          width: double.infinity,
                          child: Center(
                            child: Text(
                              "Send",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 24,
                                fontFamily: "Brand Bold",
                              ),
                            ),
                          ),
                        ),
                        onPressed: () async {
                          //if i did't choose car
                          if (Provider.of<Car>(context, listen: false)
                                  .getCar()
                                  .make ==
                              null) {
                            Fluttertoast.showToast(
                                msg: "Select car!",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.black,
                                textColor: Colors.white,
                                fontSize: 16.0);
                          } else {
                            ProgressDailog('Wait');
                            b.id = cust.id +
                                ('0' + cust.numOfRequest.toString()).toString();
                            b.describtion = descrip.text;
                            b.amount = 0;
                            b.payDate = DateTime.now();
                            r.billNo = b.id;
                            r.customer = cust.id;
                            r.details = descrip.text;
                            r.requestDate = DateTime.now();
                            r.status = 'new';
                            r.date = DateTime.now();
                            r.servProvider = workshoId;
                            print(
                                '........................................................................');

                            print(b.amount);
                            print(
                                '........................................................................');
                            print(r.toString());
                            print(
                                '........................................................................');
                            await lob.addBill(b);
                            //
                            Car newCar =
                                Provider.of<Car>(context, listen: false)
                                    .getCar();
                            await lor.addRequest(r, newCar);
                            Navigator.of(context)
                                .pushReplacementNamed(WiatingScreen.routeName);
                          }

                          // loginWithAuth(context);
                        },
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
