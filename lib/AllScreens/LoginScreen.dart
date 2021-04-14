import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:warshatkcustomerapp/AllScreens/RegisterScreen.dart';
import 'package:warshatkcustomerapp/AllScreens/USserPlaceScreen.dart';
import 'package:warshatkcustomerapp/Models/Customer.dart';
import 'package:provider/provider.dart';
import 'package:connectivity/connectivity.dart';

import '../widgets/ProgressDailog.dart';

class EmailValidator {
  static String validateConnection(String value) {
    return value == 'No internet connectivity!'
        ? "No internet connectivity!"
        : null;
  }

  static String validateEmailOrPassowrd(String value) {
    return value == 'email or password can not be empty'
        ? "email or password can not be empty"
        : null;
  }

    static String validateEmailAndPassowrd(String value) {
    return value == 'Your email or passowrd is wrong!'
        ? "Your email or passowrd is wrong!"
        : null;
  }
}

class LoginScreen extends StatelessWidget {
  static const routName = "Login";
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: mq.height,
          color: const Color.fromRGBO(226, 226, 226, 1.0),
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              SizedBox(
                height: mq.height * 0.08,
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
                      height: 3,
                    ),
                    TextField(
                      controller: emailTextEditingController,
                      decoration: InputDecoration(
                          labelStyle: TextStyle(fontSize: 16),
                          hintStyle:
                              TextStyle(color: Colors.grey, fontSize: 12),
                          labelText: "Email"),
                      keyboardType: TextInputType.emailAddress,
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
                      height: mq.height * 0.05,
                    ),
                    RaisedButton(
                      color: const Color(0xFFC62828),
                      textColor: Colors.white,
                      child: Container(
                        height: mq.height * 0.063,
                        width: double.infinity,
                        child: Center(
                          child: Text(
                            "login",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 24,
                              fontFamily: "Brand Bold",
                            ),
                          ),
                        ),
                      ),
                      onPressed: () async {
                        var connectivity =
                            await Connectivity().checkConnectivity();

                        if (connectivity != ConnectivityResult.mobile &&
                            connectivity != ConnectivityResult.wifi) {
                          EmailValidator.validateConnection(
                              "No internet connectivity!");
                          showToast("No internet connectivity!");
                        } else
                          loginWithAuth(context);
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
                      RegisterScreen.routName, (route) => false);
                },
                child: Text(
                  "Forget your password",
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                    color: Colors.blueGrey,
                    fontFamily: "Brand Bold",
                  ),
                ),
              ),
              SizedBox(
                height: mq.height * 0.03,
              ),
              FlatButton(
                onPressed: () {
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      RegisterScreen.routName, (route) => false);
                },
                child: Text(
                  "Dont hava an account? Register NOW",
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                    color: Colors.blueGrey,
                    fontFamily: "Brand Bold",
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void showToast(String msg) {
    Fluttertoast.showToast(
        msg: "$msg",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black,
        textColor: Colors.red,
        fontSize: 16.0);
  }

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  void loginWithAuth(BuildContext context) async {
    if (emailTextEditingController.text.isEmpty ||
        passwordTextEditingController.text.isEmpty) {
      EmailValidator.validateEmailOrPassowrd("email or password can not be empty");
      showToast('email or password can not be empty');
      return;
    }
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return ProgressDailog("LOGIN");
        });
    try {
      await Provider.of<Customer>(context, listen: false).login(
          emailTextEditingController.text, passwordTextEditingController.text);
      Navigator.of(context)
          .pushNamedAndRemoveUntil(UserPlace.routeName, (route) => false);
      Fluttertoast.showToast(
          msg: "Welcome to Warhatak",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 16.0);
    } catch (err) {
      Navigator.pop(context);
      EmailValidator.validateEmailAndPassowrd("Your email or passowrd is wrong!");
      Fluttertoast.showToast(
          msg: "Your email or passowrd is wrong!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black,
          textColor: Colors.red,
          fontSize: 16.0);
    }
  }
}
