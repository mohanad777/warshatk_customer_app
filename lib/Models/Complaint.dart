import 'package:flutter/foundation.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:firebase_database/firebase_database.dart';
import 'package:warshatkcustomerapp/main.dart';

class Complaint{

  var id;
  DateTime date;
  String status;
  String title;
  var customer;
  String details;
  bool isAccepted=false;
  String progress=" ";
  String suggestion;
  DateTime ComplaintDate;
  var ComplaintNo;
  var servProvider;
  Complaint({this.id,this.status,this.date,this.customer,this.details,this.ComplaintDate,this.servProvider,this.title,this.suggestion});


}
class ListOfComplaints with ChangeNotifier{
  List<Complaint>com=[];

  Future <void> addComplaint(Complaint r) async{

    FirebaseDatabase.instance
        .reference()
        .child('Complaint/'+cust.id+cust.numOfComplaint.toString()).set({

      'servProvider': r.servProvider,
      'requestDate': DateTime.now().toIso8601String(),
      'details': r.details,
      'customer':r.customer,
      'status':'new',
      'isAccepted':r.isAccepted,
      'progress':r.progress,
      'suggestion':r.suggestion,

    }

    ) ;
    /*
  var url =
      'https://warshatk-9fa8b-default-rtdb.firebaseio.com/Request/${cust.id+cust.numOfRequest.toString()}.json';

  final response = await http.post(
   url,
   body: json.encode({
   'billNo': r.billNo,
   'servProvider': r.servProvider,
   'requestDate': DateTime.now().toIso8601String(),
   'details': r.details,
   'customer':r.customer,
    'status':'new',
   'isAccepted':r.isAccepted,
    'progress':r.progress,

   }),
  );
  */
    com.add(r);
    await addUserComplaint();
    await updateCustomer();
    notifyListeners();

  }
  /*Future <void> demRequest() async{
   FirebaseDatabase.instance
       .reference()
       .child('Request/'+cust.id+cust.numOfRequest.toString()).set({
     "df":22

   }

   ) ;


 }*/


  Future <void> addUserComplaint() async{
    FirebaseDatabase.instance
        .reference()
        .child('Users-Complaint/'+cust.phone).set({
      "ComplaintNo":cust.id+cust.numOfComplaint.toString()

    }

    ) ;
    /*
   var url =
       'https://warshatk-9fa8b-default-rtdb.firebaseio.com/Users-Requests/${cust.phone}/${cust.numOfRequest.toString()}.json';

   final response = await http.post(
     url,
     body: json.encode({
       'requestNo': cust.id+cust.numOfRequest.toString(),


     }),
   );*/


  }
  Future <void>  updateCustomer() async{
    cust.numOfComplaint +=1;
    await   FirebaseDatabase.instance
        .reference()
        .child('users/ApplicationUsers/Customer/${cust.id}').update({
      "numRequests":cust.numOfComplaint

    }

    ) ;
    print("${cust.id}");
    print("Customer Req${cust.numOfComplaint}");
    /* var url =
       'https://warshatk-9fa8b-default-rtdb.firebaseio.com/Customer/${cust.id}.json';

   final response = await http.patch(
     url,
     body: json.encode({
       'numRequests': cust.numOfRequest,


     }),
   );
*/

  }



  Future <void> fetchRequest() async {
    com.clear();
    if (cust.numOfComplaint > 0) {
      print(cust.numOfComplaint);

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
      for (int i = 0; i < cust.numOfComplaint; i++){
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

          //  if (values[key]['customer'] == phone) {
          Complaint w = Complaint(
            //  name: values[key]['storeName'],
              ComplaintDate: DateTime.now(),
              //values[key]['requestDate'],
              id: rid.length+i,
              status: values['status'],
              servProvider: values['servProvider'],
              date: DateTime.now(),
              //values[key]['requestDate'],
              customer: cust.phone,
              details: values['details']
          );

          com.add(w);
          print(w.id);
          //

          //   }
          notifyListeners();
        });
      }
    }
  }
  List<Complaint> get getWorkshops {
    // if (_showFavoritesOnly) {
    //   return _items.where((prodItem) => prodItem.isFavorite).toList();
    // }

    print('${com.length}###################');
    return [...this.com];

  }
}

