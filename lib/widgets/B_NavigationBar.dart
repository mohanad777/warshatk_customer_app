import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:warshatkcustomerapp/AllScreens/MainScreen.dart';
import 'package:warshatkcustomerapp/AllScreens/Request_Screen.dart';
import 'package:warshatkcustomerapp/AllScreens/SettingPage.dart';

class B_NavigationBar extends StatefulWidget {
  static const routeName='B_NavigationBar';
  int  index=0;
  B_NavigationBar({this.index});
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<B_NavigationBar> {
 // int Nindex =0;
  var _pages =[MainPage(),RequestScreen(),SettingPage()];
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
          body: _pages[widget.index],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex:widget.index ,
            onTap: (index){
              setState(() {
                widget.index=index;
              });
            } ,
            backgroundColor: Colors.black,
            selectedItemColor: Colors.red,
            unselectedItemColor:Colors.white ,
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                  icon: Icon(Icons.home), title: Text('Home')),
              BottomNavigationBarItem(
                  icon: Icon(Icons.calendar_today), title: Text('My Request')),
              BottomNavigationBarItem(
                  icon: Icon(Icons.settings), title: Text('Setting')),
            ],
          ));
  }
}
