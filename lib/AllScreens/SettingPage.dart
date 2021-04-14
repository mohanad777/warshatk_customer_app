import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:warshatkcustomerapp/appar.dart';
import 'package:warshatkcustomerapp/AllScreens/ComplaintScreen.dart';
import 'package:warshatkcustomerapp/AllScreens/ProfileScreen.dart';

import '../HeaderCurvedContainer.dart';
import 'LoginScreen.dart';

class SettingPage extends StatefulWidget {
  static const routeName = 'SettingPage';
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: const Color.fromRGBO(226, 226, 226, 1.0),
        body: SafeArea(
          child: SingleChildScrollView(
            //  padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Appbars('Settings'),
                CustomPaint(
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: mq.height * 0.17,
                  ),
                  painter: HeaderCurvedContainer(),
                ),
                SizedBox(
                  height: mq.height * 0.07,
                ),
                Card(
                  margin: const EdgeInsets.fromLTRB(32.0, 8.0, 32.0, 16.0),
                  elevation: 10,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                  child: Column(
                    children: <Widget>[
                      ListTile(
                        leading: Icon(
                          Icons.perm_identity,
                          color: Colors.red,
                          size: 32,
                        ),
                        title: Text("Profile",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            )),
                        trailing: Icon(Icons.keyboard_arrow_right),
                        onTap: () {
                          Navigator.of(context)
                              .pushNamed(ProfileScreen.routeName);
                        },
                      ),
                      Divider(
                        color: Colors.black,
                      ),
                      ListTile(
                        leading: Icon(
                          Icons.payment,
                          color: Colors.red,
                          size: 32,
                        ),
                        title: Text("Payment",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            )),
                        trailing: Icon(Icons.keyboard_arrow_right),
                        onTap: () {},
                      ),
                      Divider(
                        color: Colors.black,
                      ),
                      ListTile(
                        leading: Icon(
                          Icons.message,
                          color: Colors.red,
                          size: 32,
                        ),
                        title: Text("Complaint",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            )),
                        trailing: Icon(Icons.keyboard_arrow_right),
                        onTap: () {
                          Navigator.of(context)
                              .pushNamed(ComplaintScreen.routName);
                        },
                      ),
                      Divider(
                        color: Colors.black,
                      ),
                      ListTile(
                        leading: Icon(
                          Icons.exit_to_app,
                          size: 32,
                          color: Colors.red,
                        ),
                        title: Text("Log Out",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            )),
                        trailing: Icon(Icons.keyboard_arrow_right),
                        onTap: () {
                          FirebaseAuth.instance.signOut();
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginScreen()),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
