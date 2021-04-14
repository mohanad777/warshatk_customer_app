import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Bill {
  var amount;
  var id;
  String describtion;
  bool isPaid = false;
  DateTime payDate;
//  var billNo;

  Bill({this.amount, this.describtion, this.payDate, this.id, this.isPaid});

  // ignore: missing_return
  Future<Bill> fetchBill(var billNo) async {
    print(billNo);
    Bill bill;
    await FirebaseDatabase.instance
        .reference()
        .child('Bill/$billNo')
        .once()
        .then((DataSnapshot snap) {
      var values = snap.value;
      bill = Bill(
        id: billNo,
        describtion: values['describtion'],
        amount: values['amount'],
        payDate: DateTime.parse(values['payDate']),
        isPaid: values['isPaid'],
      );
    });

    return bill;
  }

  Future<void> updateBill(var billId) async {
    //To display id as numbers instead of a long random string on webiste
    FirebaseDatabase.instance
        .reference()
        .child('Bill/' + billId)
        .update({"isPaid": true});
  }
}

class ListOfBill with ChangeNotifier {
  List<Bill> bills = [];
  Future<void> addBill(Bill b) async {
    FirebaseDatabase.instance.reference().child('Bill/' + b.id.toString()).set({
      'amount': b.amount,
      'payDate': DateTime.now().toIso8601String(),
      'describtion': ' ',
      'isPaid': false,
      'billNo': (DateTime.now().toIso8601String().split('.'))[1],
    });

    bills.add(b);
   // print("  1611616116616166161166666666666    ${bills[0].id}");
  }
}
