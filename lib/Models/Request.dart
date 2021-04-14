import 'package:flutter/foundation.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:firebase_database/firebase_database.dart';
import 'package:warshatkcustomerapp/Models/Car.dart';
import 'package:warshatkcustomerapp/main.dart';

import 'Bill.dart';

class Request{

 var billNo;
 var id;
   DateTime date;
  String status;
  var customer;
  String details;
  bool isAccepted=false;
  String progress=" ";
  DateTime requestDate;
var requestNo;
  var servProvider;


 Request({this.id,this.status,this.date,this.customer,this.billNo,this.details,this.requestDate,this.servProvider,this.requestNo});


}
class ListOfRequests with ChangeNotifier{
 List<Request>req=[];

 Future <void> addRequest(Request r,Car car) async{

  await FirebaseDatabase.instance
       .reference()
       .child('Request/'+cust.id+cust.numOfRequest.toString()).set({
     'billNo': r.billNo,
     'servProvider': r.servProvider,
     'requestDate': DateTime.now().toIso8601String(),
     'details': r.details,
     'customer':r.customer,
     'status':'new',
     'isAccepted':r.isAccepted,
     'progress':r.progress,
     'latitude':cust.latitude,
     'longitude':cust.longitude,
     'carID':car.toString(),
     'requestNo':(DateTime.now().toIso8601String().split('.'))[1],},

   );

  req.add(r);
 await addUserRequest(r.servProvider);
 await updateCustomer();
  notifyListeners();

 }

 Future <void> updateRequest(  var reqId) async{
   //To display id as numbers instead of a long random string on webiste
   FirebaseDatabase.instance
       .reference()
       .child('Request/'+reqId).update({
     "status":"completed"

   }

   ) ;

 }

 Future <void> addUserRequest(  var servProvider) async{
//add it to Users-Requests in the database
    FirebaseDatabase.instance
       .reference()
       .child('Users-Requests/'+servProvider).update({
     "${cust.id+cust.numOfRequest.toString()}":"true"

   }

   ) ;

 }
 Future <void>  updateCustomer() async{
   cust.numOfRequest +=1;
await   FirebaseDatabase.instance
       .reference()
       .child('users/ApplicationUsers/Customer/${cust.id}').update({
     "numRequests":cust.numOfRequest

   }

   ) ;
 }



 Future <void> fetchRequest() async {
   req.clear();
   if (cust.numOfRequest > 0) {
     print(cust.numOfRequest);

        /*   'billNo': r.billNo,
   'servProvider': r.servProvider,
   'requestDate': DateTime.now().toIso8601String(),
   'details': r.details,
   'customer':r.customer,
    'status':'new',
   'isAccepted':r.isAccepted,
    'progress':r.progress,*/

        DatabaseReference userRef = FirebaseDatabase.instance.reference();
String rid="";
        for (int i = 0; i < cust.numOfRequest; i++){
          rid=cust.id + i.toString();
          print(cust.id + i.toString());
          await userRef
              .child("Request/$rid")
              .once()
              .then((DataSnapshot snap) {
         //   var keys = snap.value.keys;
            var values = snap.value;

        //    print("keys $keys");
        //  for (var key in keys) {
           print(values);
              if (values['isAccepted'] == true) {
              Request w = Request(
                //  name: values[key]['storeName'],
                  billNo: values['billNo'],
                  requestDate: DateTime.parse(values['requestDate']),
                  //values[key]['requestDate'],
                  id: rid.length+i,
                  status: values['status'],
                  servProvider: values['servProvider'],
                  date: DateTime.parse(values['requestDate']),
                  //values[key]['requestDate'],
                  customer: cust.phone,
                  details: values['details'],
                  requestNo: rid,
              );

              req.add(w);
           
           //

               }

          });
      }
     
     notifyListeners();
   }

 }
 List<Request> get getRequests {

  return [...this.req.reversed];

 }
}

