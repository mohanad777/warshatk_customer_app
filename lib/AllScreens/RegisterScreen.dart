import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import 'package:warshatkcustomerapp/AllScreens/MainScreen.dart';
import 'package:warshatkcustomerapp/AllScreens/LoginScreen.dart';
import 'package:warshatkcustomerapp/Models/Customer.dart';
import 'package:warshatkcustomerapp/widgets/ProgressDailog.dart';
import '../main.dart';
import 'USserPlaceScreen.dart';

class Validator {

  static String validateRegisterationEmptyPassowrd(String value) {
    return value == 'The passowrd shuld\'nt be empty'
        ? 'The passowrd shuld\'nt be empty'
        : null;
  }
    static String validateRegisterationEmptyEmail(String value) {
    return value == 'The email shuld\'nt be empty'
        ? 'The email shuld\'nt be empty'
        : null;
  }
     static String validateRegisterationPassowrdLength(String value) {
    return value == 'The passowrd is too short'
        ? 'The passowrd is too short'
        : null;
  }

  static String validaPassowrd(String value) {
    return value == 'The passowrd must contain letters and number'
        ? "The passowrd must contain letters and number"
        : null;
  }
}

class RegisterScreen extends StatelessWidget {
  static const routName = "Register";
  TextEditingController nameTextEditingController = TextEditingController();
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();
  TextEditingController phoneTextEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color.fromRGBO(226, 226, 226, 1.0),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              SizedBox(
                height: mq.height * 0.05,
              ),
              Image.asset(
                "images/Warshatak_lugo.png",
                height: mq.height * 0.30,
                alignment: Alignment.center,
                width: mq.width * 0.8,
              ),
              Padding(
                padding: const EdgeInsets.all(25),
                child: Column(
                  children: [
                    SizedBox(
                      height: mq.height * 0.01,
                    ),
                    TextField(
                      controller: nameTextEditingController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                          labelStyle: TextStyle(fontSize: 16),
                          hintStyle:
                              TextStyle(color: Colors.grey, fontSize: 12),
                          labelText: "Name"),
                    ),
                    TextField(
                      controller: emailTextEditingController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                          labelStyle: TextStyle(fontSize: 16),
                          hintStyle:
                              TextStyle(color: Colors.grey, fontSize: 12),
                          labelText: "Email"),
                    ),
                    TextField(
                      controller: phoneTextEditingController,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                          labelStyle: TextStyle(fontSize: 16),
                          hintStyle:
                              TextStyle(color: Colors.grey, fontSize: 12),
                          labelText: "Phone"),
                    ),
                    TextField(
                      controller: passwordTextEditingController,
                      obscureText: true,
                      decoration: InputDecoration(
                          labelStyle: TextStyle(fontSize: 16),
                          hintStyle:
                              TextStyle(color: Colors.grey, fontSize: 12),
                          labelText: "Passowrd"),
                    ),
                    SizedBox(
                      height: mq.height * 0.03,
                    ),
                    RaisedButton(
                      color: const Color(0xFFC62828),
                      textColor: Colors.white,
                      child: Container(
                        height: mq.height * 0.063,
                        width: double.infinity,
                        child: Center(
                          child: Text(
                            "Register",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 24,
                              fontFamily: "Brand Bold",
                            ),
                          ),
                        ),
                      ),
                      onPressed: () {
                        if (checkTheConditions()) registerNewUser(context);
                      },
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                    ),
                  ],
                ),
              ),
              FlatButton(
                onPressed: () {
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      LoginScreen.routName, (route) => false);
                },
                child: Text(
                  "Already hava an account? Login ",
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                    color: Colors.blueGrey,
                    fontFamily: "Brand Bold",
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  bool checkTheConditions() {
    if (nameTextEditingController.text.toString().isEmpty) {
      
      showDialogs('The name must not be empty');
      return false;
    }
    if (phoneTextEditingController.text.toString().isEmpty) {
      showDialogs('The phone must not be empty');
      return false;
    }
    if (emailTextEditingController.text.isEmpty) {
      Validator.validateRegisterationEmptyEmail('The email shuld\'nt be empty');
      showDialogs('The email shuld\'nt be empty');
      return false;
    }
    if (!emailTextEditingController.text.toString().contains('@')) {
      showDialogs('The email is not correct');
      return false;
    }
    if (passwordTextEditingController.text.toString().isEmpty) {
      Validator.validateRegisterationEmptyPassowrd('The passowrd shuld\'nt be empty');
      showDialogs('The passowrd shuld\'nt be empty');
      return false;
    }
    if (passwordTextEditingController.text.toString().length < 6) {
       Validator.validateRegisterationPassowrdLength('The passowrd is too short');
      showDialogs('The passowrd is too short');
      passwordTextEditingController.clear();
      return false;
    }
    if (passwordTextEditingController.text
            .toString()
            .contains(RegExp(r'[1-9]')) ==
        false) {
            Validator.validaPassowrd('The passowrd must contain letters and number');
      showDialogs('The passowrd must contain number');
      passwordTextEditingController.clear();
      return false;
    }
    if (passwordTextEditingController.text
            .toString()
            .contains(RegExp(r'[a-z]')) ==
        false) {
            Validator.validaPassowrd('The passowrd must contain letters and number');
      showDialogs('The passowrd must contain letters');
      passwordTextEditingController.clear();
      return false;
    }

    return true;
  }

  void showDialogs(String msg) {
    Fluttertoast.showToast(
        msg: "$msg",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 8,
        backgroundColor: Colors.black,
        textColor: Colors.red,
        fontSize: 16.0);
  }

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  void registerNewUser(BuildContext context) async {
    User firebase;

    try {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return ProgressDailog("REGISTER");
          });

      firebase = (await _firebaseAuth.createUserWithEmailAndPassword(
              email: emailTextEditingController.text,
              password: passwordTextEditingController.text))
          .user;
    } catch (e) {
      Navigator.pop(context);
      Fluttertoast.showToast(
          msg: "Your email is allready exist",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black,
          textColor: Colors.red,
          fontSize: 16.0);
    }
    ;
    if (firebase != null) {
      Map userdata = {
        "name": nameTextEditingController.text.trim(),
        "email": emailTextEditingController.text.trim(),
        "phone": phoneTextEditingController.text.trim(),
        "IBAN": ' ',
        "numRequests": 0,
        "rating": 0,
        "status": 'un-block',
        "totalPayment": 0,
        "registDate": DateTime.now().toIso8601String(),
        "numberOfRating": 0,
        "ratingsTotal": 0,
        "numComplaint": 0
      };
      await userRef.child(firebase.uid).set(userdata);

      cust = Customer(
          name: nameTextEditingController.text.trim(),
          id: firebase.uid,
          totalPayment: 0,
          phone: phoneTextEditingController.text.trim(),
          numOfRequest: 0,
          iBAN: ' ',
          numOfComplaint: 0,
          email: emailTextEditingController.text.trim());

      //saved
      Navigator.of(context)
          .pushNamedAndRemoveUntil(UserPlace.routeName, (route) => false);
      print(" saved");
    } else {
      Navigator.pop(context);
      showDialogs('The internet is not connected');
      print("not saved");
    }
  }
}
/*this.city,
   IBAN:
"SA1234567890123456789012"
city:
"jeddah"
email:
"sohaib@gmail.com"
name:
"sohaib"
numRequests:
0
password:
"123456"
phone:
"0581100902"
rating:
5
registDate:
1612022655144
status:
"Un-block"
totalPayment:
0
nt*/
