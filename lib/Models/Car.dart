
import 'package:flutter/cupertino.dart';

class Car with ChangeNotifier{
   String make ,model, modelYear="";

   void setCar(String make,String model ,String modelYear){
     this.make=make;
     this.model=model;
     this.modelYear=modelYear;
     notifyListeners();
   }
   Car getCar(){
     return this;
   }
   @override
  String toString() {
    // TODO: implement toString
    return "$make-$model-$modelYear";
  }



}