import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:warshatkcustomerapp/main.dart';
import './firebase_Exception.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:warshatkcustomerapp/Models/User.dart';

import 'PaymentSystem.dart';

class Customer extends AplicationUser with ChangeNotifier {
  var id;
  String name = "";
  double latitude;
  double longitude;
  String iBAN;
  String email;
  var phone;
  String status;
  String city;
  int numOfRequest;
  int numOfComplaint;
  int rating;

  var totalPayment = 0;
  Customer(
      {this.name,
      this.phone,
      this.id,
      this.email,
      this.totalPayment,
      this.iBAN,
      this.numOfRequest,
      this.numOfComplaint})
      : super();

  bool get isAuth {
    print(id.toString());
    return id != null;
  }

  PaymentSystem cardInfo = PaymentSystem();

  Future<void> updateLocation(double latitude, double longitude) async {
    cust.latitude = latitude;
    cust.longitude = longitude;
  }

  Future<void> login(String email, String password) async {
    User firebase;
    try {
      firebase = (await FirebaseAuth.instance
              .signInWithEmailAndPassword(email: email, password: password))
          .user;

      if (firebase != null) {
        var key = firebase.uid;

        await userRef.child(firebase.uid).once().then((DataSnapshot snap) {
          if (snap.value != null) {
            //Customer.name=snap.value['name'];
            this.name = snap.value['name'];
            this.id = key;
            totalPayment = snap.value['totalPayment'];
            phone = snap.value['phone'];
            numOfRequest = snap.value['numRequests'];
            iBAN = snap.value['IBAN'];
            this.email = snap.value['email'];
            this.cardInfo.iban = snap.value['IBAN'];
          }
        });
      }
    } catch (err) {
      rethrow;
    }

//it is a variable in the main
    cust = this;
//notify all listeners to change
    notifyListeners();
    //to store small data in the app
    //  final pref = await SharedPreferences.getInstance();
/*

    final userData = json.encode({
      'id': cust.id,
      'name': cust.name,
      'numOfRequest': cust.numOfRequest,
      'email': cust.email,
      'totalPayment': cust.totalPayment,
      'phone': cust.phone
    });
    pref.setString('userData', userData);


 */
    // pref.clear();
  }

//because after the frist time the user login .the shared perfrence will store the data permenantly in the app
  Future<bool> tryAutoLogin() async {
    final pref = await SharedPreferences.getInstance();
    //check if the user have loged in
    if (!pref.containsKey('userData')) {
      return false;
    }
    final extractUserData = json.decode(
      pref.getString('userData'),
    ) as Map<String, Object>;

    this.name = extractUserData['name'];
    this.id = extractUserData['id'];
    totalPayment = extractUserData['totalPayment'];
    phone = extractUserData['phone'];
    numOfRequest = extractUserData['numRequests'];
    iBAN = extractUserData['IBAN'];
    this.email = extractUserData['email'];
    this.cardInfo.iban = extractUserData['IBAN'];
    cust = this;
    notifyListeners();
    return true;
  }

  Future<bool> updateCustomerName(String name) async {
 
     await userRef.child(cust.id).update({
      "name":name,

     

    });
  


  }

   Future<bool> updateCustomerPhone(String phone) async {
     
 
     await userRef.child(cust.id).update({
      "phone":name,

     

    });
  


  }

     Future<bool> updateCustomerEmail(String email) async {
 
    FirebaseAuth.instance.currentUser.updateEmail(email);
    
     await userRef.child(cust.id).update({
      "email":email,

     

    });
  


  }
}
