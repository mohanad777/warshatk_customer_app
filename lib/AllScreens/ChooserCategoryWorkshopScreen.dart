import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:warshatkcustomerapp/Icons.dart';
import 'package:warshatkcustomerapp/Models/Service.dart';
import 'package:warshatkcustomerapp/widgets/CadrStyle.dart';
import 'package:warshatkcustomerapp/widgets/CarChooser.dart';

class ChooserCategoryWorkshopScreen extends StatefulWidget {
  static const routeName = "ChooserCategoryWorkshopScreen";

  @override
  State<StatefulWidget> createState() => _ChooserCategoryWorkshopScreenState();
}

class _ChooserCategoryWorkshopScreenState
    extends State<ChooserCategoryWorkshopScreen> {
  List<Service> _services = [
    Service(
        operation: 'Battery', iconName: battery, index: 0, isSilected: false),
    Service(operation: 'Two', iconName: Two, index: 1, isSilected: false),
    Service(operation: 'Gas', iconName: gas, index: 2, isSilected: false),
    Service(operation: 'Tire', iconName: tire, index: 3, isSilected: false),
  ];

  @override
  Widget build(BuildContext context) {
    final routeArgs =
        ModalRoute.of(context).settings.arguments as Map<String, dynamic>;
    final workshopCategory = routeArgs['workshop'];
    final workshopId = routeArgs['workshopId'];

    final _mq = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        //  height: _screenSize.height * 0.8,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.white70,
              blurRadius: 10,
              spreadRadius: 5,
              offset: Offset(8.0, 8.0),
            )
          ],
          color: Colors.blueGrey[200],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: _mq.height * 0.15,
            ),
            Expanded(child: ChooserCar()),
            Text(
              "\t\tServices",
              textAlign: TextAlign.justify,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                  color: Colors.white70),
            ),
            Container(
              margin: EdgeInsets.only(top: 12, bottom: 8, left: 8),
              height: _mq.height * 0.45,
              child: GridView(
                children: _services
                    .map((e) => CardStyle(
                          index: e.index,
                          operation: e.operation,
                          selectedIcone: e.iconName,
                          current: e.isSilected,
                          workshopId: workshopId,
                          workshopName: workshopCategory,
                        ))
                    .toList(),
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  mainAxisSpacing: 20,
                  crossAxisSpacing: 20,
                  maxCrossAxisExtent: 200,
                  childAspectRatio: 3 / 2,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
