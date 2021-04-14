import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:warshatkcustomerapp/Models/Car.dart';
class ChooserCar extends StatefulWidget {


  @override
  _ChooserCarState createState() => _ChooserCarState();
}

class _ChooserCarState extends State<ChooserCar> {
  List<String>cars=['Ford','Toyota','Nissan'];
  Map carsMap={"Toyota":['Camry','Corolla','Yaris','Avalon'],
               "Ford":["Fusion","Mustang","Figo","EcoSport"],
               

  };

  List<String>dates=["2014",'2015','2016','2019'];
  String date;
  String car="";
  String type="";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

   //car=carsMap.keys.elementAt(0);
    //type=models[0];
    date=dates[0];


  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          margin: EdgeInsets.only(left: 8,right: 8,bottom: 12),
          //padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
           borderRadius: BorderRadius.circular(15),
            border: Border.all(width: 2,color: Colors.black38)
          ),
          child: DropdownButton(
            hint: Text(car.isEmpty?'\tselect car make':'\t$car',style: TextStyle(fontSize: 22,fontWeight: FontWeight.w800,color: Colors.black38)),
            elevation: 5,
            isExpanded: true,
              icon:Icon(Icons.arrow_drop_down) ,
              value:null,
             // isDense: true,

              items:carsMap.keys.map((e){
            return DropdownMenuItem(
          value:e,
                child: Text('\t$e',style: TextStyle(fontSize: 22,fontWeight: FontWeight.w800,color: Colors.black38),));
          }).toList()
              , onChanged: (value){
                setState(() {
                  String temp=car;
                 car=value;
                 if(temp!=car)
                   type="";

                 print(car);
                });

              }
          ) ,
          ),
        ////////////////////////////////////
        if(car!="")
        Container(
          width: double.infinity,
          margin: EdgeInsets.only(left: 8,right: 8,bottom: 12),
          //padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              border: Border.all(width: 2,color: Colors.black38)
          ),

          child: DropdownButton(
              hint: Text(type.isEmpty?'\tSelect car model':'\t$type',style: TextStyle(fontSize: 22,fontWeight: FontWeight.w800,color: Colors.black38)),
              elevation: 5,
              isExpanded: true,
              icon:Icon(Icons.arrow_drop_down) ,

              value: null,
              //isDense: true,

              items:(carsMap["$car"] as List<String>).map((e){
                return DropdownMenuItem(
                    value:e,
                    child: Text('\t$e',style: TextStyle(fontSize: 22,fontWeight: FontWeight.w800,color: Colors.black38)));
              }).toList()
              , onChanged: (value){
            setState(() {
              print(value);
                  type=value;
            });

          }
          ) ,
        ),
        if(car!="")
        Container(
          width: double.infinity,
          margin: EdgeInsets.only(left: 8,right: 8,bottom: 12),
          //padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              border: Border.all(width: 2,color: Colors.black38)
          ),
          child: DropdownButton(
              hint: Text('Select car date'),
              elevation: 5,
              isExpanded: true,
              icon:Icon(Icons.arrow_drop_down) ,
              value: date,

              items:dates.map((e){
                return DropdownMenuItem(
                    value:e.length==0?'q': e,
                    child: Text('\t$e',style: TextStyle(fontSize: 22,fontWeight: FontWeight.w800,color: Colors.black38)));
              }).toList()
              , onChanged: (value){
            setState(() {
              date=value;
              if(car!=""&&type!=""){
                Provider.of<Car>(context,listen: false).setCar(car, type, date);


              }
            });

          }
          ) ,
        ),
      ],
    );

  }
}
