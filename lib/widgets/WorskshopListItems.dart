import 'package:flutter/material.dart';
import 'package:warshatkcustomerapp/AllScreens/ChooserCategoryWorkshopScreen.dart';
import 'package:warshatkcustomerapp/AllScreens/WorkshopInfoScreen.dart';

import 'package:warshatkcustomerapp/Models/Workshop.dart';

class WorskshopListItems extends StatelessWidget {
  final Workshop workshops;
  WorskshopListItems(this.workshops);
  void selectCategory(BuildContext ctx) {
    if(workshops.name=='emergency'){
      Navigator.of(ctx)
          .pushNamed(ChooserCategoryWorkshopScreen.routeName,arguments:{'workshop':workshops.name,'workshopId': workshops.id} );
    }
   else{
    Navigator.of(ctx).pushNamed(

      WorkshopInfoScreen.routName,
      arguments: {'workshoId': workshops.id,
      'workshoPlatitude': workshops.latitude,
      'worksholongitude': workshops.longitude,
      
      },
    );}

    // WorkshopInfo

    /**Navigator.push(
     *  void selectCategory(BuildContext ctx) {
        Navigator.of(ctx).pushNamed(
        CategoryMealsScreen.routeName,
        arguments: {
        'id': id,
        'title': title,
        },
        );
  ); */
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => selectCategory(context),
      child: Card(
        elevation: 8,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        margin: EdgeInsets.all(4),
        child: ListTile(
          leading: CircleAvatar(
            radius: 20,
            backgroundColor: Colors.grey,
            child: Icon(Icons.directions_car),
          ),
          title: Text(workshops.name),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(child: Text(workshops.carType)),
                  workshops.starList
                ],
              ),
              Text(workshops.workshopType),
              Row(
                children: [
                  Expanded(child: Text(workshops.phone)),
                  Text('${workshops.decetinces.toStringAsFixed(2)} Km'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
