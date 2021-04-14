import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:warshatkcustomerapp/main.dart';
import 'package:warshatkcustomerapp/widgets/B_NavigationBar.dart';
import 'package:maps_toolkit/maps_toolkit.dart' as mp;

class UserPlace extends StatefulWidget {
  static const routeName = "UserPlace";
  @override
  _UserPlaceState createState() => _UserPlaceState();
}

class _UserPlaceState extends State<UserPlace> {
  var isenabled = true;
  double bottom = 0;
  Completer<GoogleMapController> _controllerGoogleMap = Completer();
  GoogleMapController newGoogleMapcontroller;
  //this variable for initial postion
  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );
  Position currentposition;
  var _geolocator = Geolocator();
  void locateLocation() async {
    //to get current user's position in map
    Position _position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    currentposition = _position;
    LatLng _latLing =
        LatLng(currentposition.latitude, currentposition.longitude);
    CameraPosition cameraPosition = CameraPosition(target: _latLing, zoom: 14);
   // change the camera position to current user position
    await newGoogleMapcontroller.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
    setState(() {
      isenabled = false;
    });
    cust.latitude = _position.latitude;
    cust.longitude = _position.longitude;

    //test to calculate the decetance between two points
    final workshopLocation = mp.LatLng(21.622590, 39.202960);
    //21.497850 //long=39.220450
    final workshopLocation2 = mp.LatLng(21.497850, 39.220450);
    print(
        '${(mp.SphericalUtil.computeDistanceBetween(mp.LatLng(_position.latitude, _position.longitude), workshopLocation) / 1000.0)} KM\n\n\n');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            padding: EdgeInsets.only(bottom: bottom),
            initialCameraPosition: _kGooglePlex,
            mapType: MapType.normal,
            myLocationButtonEnabled: true,
            myLocationEnabled: true,
            zoomGesturesEnabled: true,
            zoomControlsEnabled: true,
            onMapCreated: (GoogleMapController controller) {
              _controllerGoogleMap.complete(controller);
              newGoogleMapcontroller = controller;
              setState(() {
                bottom = 265;
              });
              locateLocation();
            },
          ),

          ////
          Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                height: 200,
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black,
                      spreadRadius: 0.5,
                      blurRadius: 16,
                      offset: Offset(0.7, 0.7),
                    )
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('your location is in: '),
                      ],
                    ),
                    Container(
                        width: double.infinity,
                        margin: EdgeInsets.only(left: 20, right: 20, top: 18),
                        child: RaisedButton(
                          
                          color: const Color(0xFFC62828),
                          onPressed: isenabled?  null : () {
                            Navigator.pushNamed(
                                context, B_NavigationBar.routeName);
                          },
                          child: Text("Choose"),
                        
                          padding: EdgeInsets.all(16),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                        )),
                  ],
                ),
              ),
              ),
        ],
      ),
    );
  }
}
