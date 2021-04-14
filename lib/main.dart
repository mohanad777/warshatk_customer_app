import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:warshatkcustomerapp/AllScreens/PaymentScreen.dart';
import 'package:warshatkcustomerapp/AllScreens/RequestInfo.dart';
import 'package:warshatkcustomerapp/AllScreens/USserPlaceScreen.dart';
import 'package:warshatkcustomerapp/Models/Customer.dart';
import 'package:warshatkcustomerapp/Models/Workshop.dart';
import 'package:warshatkcustomerapp/widgets/B_NavigationBar.dart';
import './AllScreens/RegisterScreen.dart';
import './AllScreens/MainScreen.dart';
import 'AllScreens/ComplaintScreen.dart';
import 'AllScreens/RegisterScreen.dart';
import 'package:warshatkcustomerapp/AllScreens/WorkshopListScreen.dart';
import './AllScreens/LoginScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:warshatkcustomerapp/AllScreens/WorkshopInfoScreen.dart';
import 'package:warshatkcustomerapp/AllScreens/WaitingScreen.dart';
import 'package:warshatkcustomerapp/AllScreens/Request_Screen.dart';
import 'package:warshatkcustomerapp/Models/Request.dart';
import 'package:warshatkcustomerapp/Models/Bill.dart';
import 'package:warshatkcustomerapp/AllScreens/ProfileScreen.dart';
import 'package:warshatkcustomerapp/AllScreens/ChooserCategoryWorkshopScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Models/Car.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
 

  runApp(MyApp());
}

String customername = "";
Customer cust = null;
DatabaseReference userRef = FirebaseDatabase.instance
    .reference()
    .child("users/ApplicationUsers/Customer");

class MyApp extends StatelessWidget {
  
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // Connectivity().onConnectivityChanged;,
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: Customer()),
        ChangeNotifierProvider.value(value: Workshops()),
        ChangeNotifierProvider.value(value: Workshop()),
        ChangeNotifierProvider.value(value: ListOfRequests()),
        ChangeNotifierProvider.value(value: ListOfBill()),
        ChangeNotifierProvider.value(value: Car()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: 'Brand Bold',
          primarySwatch: Colors.red,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          primaryColor: Colors.red,
          focusColor: Colors.red,
          cursorColor: Colors.red,
        ),
        home: LoginScreen(),
        //  initialRoute: LoginPage.routName,
        routes: {
          MainPage.routName: (ctx) => MainPage(),
          RegisterScreen.routName: (ctx) => RegisterScreen(),
          LoginScreen.routName: (ctx) => LoginScreen(),
          ComplaintScreen.routName: (ctx) => ComplaintScreen(),
          WorkshopInfoScreen.routName: (ctx) => WorkshopInfoScreen(),
          WiatingScreen.routeName: (ctx) => WiatingScreen(),
          RequestScreen.routName: (ctx) => RequestScreen(),
          ProfileScreen.routeName: (ctx) => ProfileScreen(),
          B_NavigationBar.routeName: (ctx) => B_NavigationBar(
                index: 0,
              ),
          WorkshopListScreen.routName: (ctx) => WorkshopListScreen(),
          UserPlace.routeName: (ctx) => UserPlace(),
          ChooserCategoryWorkshopScreen.routeName: (ctx) =>
              ChooserCategoryWorkshopScreen(),
        },
      ),
    );
  }
}
