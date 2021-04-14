import 'package:flutter/material.dart';
import 'package:warshatkcustomerapp/Models/Car.dart';
import 'package:warshatkcustomerapp/Models/Service.dart';
import 'package:warshatkcustomerapp/widgets/WorkshopServiceItemStyle.dart';

class WorkshopServices extends StatelessWidget {
  final Car car;
  final int id;
  final workshopName;
  final workshopId;
  WorkshopServices(this.car, this.id, this.workshopName, this.workshopId);
  final ServicesList = {
    'Emergency': {
      0: [
        Service(operation: "Battery jump start", Price: 57),
        Service(operation: 'Battery installation', Price: 100)
      ],
      1: [
        Service(operation: "Regular Towing", Price: 90),
        Service(operation: 'Winch', Price: 100),
        Service(operation: 'Covered Towing', Price: 100),
      ],
      2: [
        Service(operation: "91 petrol", Price: 60),
        Service(operation: '95 petrol', Price: 100)
      ],
      3: [
        Service(operation: "Spare Tire Installation", Price: 57),
        Service(operation: 'Tire Repair In Station', Price: 115),
        Service(operation: "Tire Repair On Site", Price: 88),
        Service(operation: 'Tire Inflation On Site', Price: 42),
        Service(operation: " Tire Change on site", Price: 172),
      ],
    },
    'Cleaning': {
      1: [
        Service(operation: "Battery jump start", Price: 57),
        Service(operation: 'Battery installation', Price: 100)
      ]
    },
  };

  // var l=questions.keys;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Container(
        decoration: BoxDecoration(
          //  borderRadius:const BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20) ),
          color: const Color(0xFFFFFFFFF),
          boxShadow: [
            BoxShadow(
              color: Colors.black,
              spreadRadius: 0.5,
              blurRadius: 16,
              offset: Offset(0.7, 0.7),
            )
          ],
        ),
        child: ListView(
          children: ((ServicesList['Emergency'] as Map)[id] as List<Service>)
              .map((e) => WorkshopServicesItem(
                    service: e.operation,
                    price: e.Price,
                    workshopName: this.workshopName,
                    workshopId: this.workshopId,
                  ))
              .toList(),
        ),
      ),
    );
  }
}
