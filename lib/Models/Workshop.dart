import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:warshatkcustomerapp/Models/User.dart';
import 'package:warshatkcustomerapp/main.dart';
import 'package:warshatkcustomerapp/widgets/StarList.dart';
import 'package:provider/provider.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:maps_toolkit/maps_toolkit.dart' as mp;
import 'package:http/http.dart'as http;

class Workshop extends AplicationUser with ChangeNotifier {
  int numberOfRating=0;
  StarList starList;
  String carType;
  String workshopType;
  int rating;
  double decetinces = 0;
  Workshop(
      {
        double longitude,
 double latitude,
        var id,this.rating,
      this.carType,
      String name,
      var tel,
      this.workshopType,
      this.starList,
      this.decetinces,
        this.numberOfRating
      }):super(id:id,name:name,phone:tel,latitude:latitude,longitude:longitude);



  void updateService(String service) {
    this.workshopType = service;
    notifyListeners();
  }
}

class Workshops with ChangeNotifier {
  List<Workshop> workshops = [];

  Future<void> updateRating(var id, int rating) async {
    int ratingsTotal;
    Workshop w=Workshop();
    DatabaseReference userRef = await FirebaseDatabase.instance.reference();
    userRef
        .child("users/ApplicationUsers/CarServiceProvider/$id")
        .once()
        .then((DataSnapshot snap) {
      var keys = snap.value.keys;
      var values = snap.value;
      w = Workshop(
            name: values['storeName'],
            tel: values['phone'],
            numberOfRating: values['numberOfRating'],
            rating: values['rating'],

          );

       ratingsTotal=values['ratingsTotal']+rating;
    }).then((_) {
      w.numberOfRating++;
      w.rating=ratingsTotal~/w.numberOfRating;
      print('temp ${w.rating}');
      FirebaseDatabase.instance
          .reference()
          .child('users/ApplicationUsers/CarServiceProvider/$id').update({
        "rating":w.rating,
         "numberOfRating":w.numberOfRating,
        "ratingsTotal":ratingsTotal,

      });
    });
  }



  Future<void> fetchWorkshops(String serviceType) async {
    workshops.clear();
    DatabaseReference userRef = FirebaseDatabase.instance.reference();
    userRef
        .child("users/ApplicationUsers/CarServiceProvider")
        .once()
        .then((DataSnapshot snap) {
      var keys = snap.value.keys;
      var values = snap.value;
      for (var key in keys) {
        if (values[key]['status'] == 'un-block' &&
            values[key]['serviceType'] == serviceType&&values[key]['appActivity']!="inactive") {
          Workshop w = Workshop(
            id: key,
            longitude:values[key]['longitude'] ,
            latitude: values[key]['latitude'],
            name: values[key]['storeName'],
            tel: values[key]['phone'],
            workshopType: values[key]['serviceType'],
            rating: values[key]['rating'],
            carType: 'All',
            starList: StarList(values[key]['rating']),



          );
          print(key);
          workshops.add(w);
        }
      }
     //if there is no workshop opeend and i caluclate in empty list i will get error
      if(workshops.length>0)
      calculateThedicetanceAndSorted();
      notifyListeners();
    });
  }

  List<Workshop> get getWorkshops {
    // if (_showFavoritesOnly) {
    //   return _items.where((prodItem) => prodItem.isFavorite).toList();
    // }
    return [...this.workshops];
  }

  void calculateThedicetanceAndSorted() {

    final from = mp.LatLng(cust.latitude, cust.longitude);
    for(int i=0;i<workshops.length;i++){
      //compute the decetence between the user and each workshop
      var to1 =
      mp.LatLng(this.workshops[i].latitude, this.workshops[i].longitude);
//then add it to decetinces
      this.workshops[i].decetinces =
      (mp.SphericalUtil.computeDistanceBetween(from, to1) / 1000.0);

    }

//i will sorted from the nearst workshop for the user
    workshops.sort((a, b) => a.decetinces.compareTo(b.decetinces));
  }
}
