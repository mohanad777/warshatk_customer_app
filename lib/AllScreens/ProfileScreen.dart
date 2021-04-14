import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:warshatkcustomerapp/Models/Customer.dart';
import 'package:warshatkcustomerapp/main.dart';
import 'package:provider/provider.dart';
import 'package:warshatkcustomerapp/widgets/TextFieldStyling.dart';

class ProfileScreen extends StatefulWidget {
  static const routeName = 'ProfileScreen';
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  TextEditingController newName = TextEditingController();
  TextEditingController newEmail = TextEditingController();
  TextEditingController newPhone = TextEditingController();

  bool en = false;

  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            'Profile',
            style: TextStyle(fontSize: 24),
          ),
          backgroundColor: const Color(0xFFdc143c).withOpacity(0.9),
          centerTitle: true,
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  color: Color.fromRGBO(226, 226, 226, 1.0),
                ),
                SizedBox(
                  height: 64,
                ),
                Text(
                  "    Name",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(
                  height: 12,
                ),
                Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                        side: BorderSide(color: Colors.white)),
                    color: Color(0xffFFFFFF),
                    elevation: 5,
                    margin: EdgeInsets.symmetric(horizontal: 25),
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: TextField(
                        enabled: en,
                        maxLines: 1,
                        decoration:
                            InputDecoration.collapsed(hintText: cust.name),
                        controller: newName,
                      ),
                    )),
                SizedBox(
                  height: 12,
                ),
                Text(
                  "    E-mail",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(
                  height: 18,
                ),
                Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                        side: BorderSide(color: Colors.white)),
                    color: Color(0xffFFFFFF),
                    elevation: 5,
                    margin: EdgeInsets.symmetric(horizontal: 25),
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: TextField(
                        enabled: en,
                        maxLines: 1,
                        decoration:
                            InputDecoration.collapsed(hintText: cust.email),
                        controller: newEmail,
                      ),
                    )),
                SizedBox(
                  height: 12,
                ),
                Text(
                  "    Phone Number",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(
                  height: 18,
                ),
                Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                        side: BorderSide(color: Colors.white)),
                    color: Color(0xffFFFFFF),
                    elevation: 5,
                    margin: EdgeInsets.symmetric(horizontal: 25),
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: TextField(
                        enabled: en,
                        maxLines: 1,
                        decoration: InputDecoration.collapsed(
                          hintText: cust.phone,
                        ),
                        controller: newPhone,
                      ),
                    )),
                SizedBox(
                  height: 100,
                ),
                Center(
                  child: Container(
                    padding: EdgeInsets.all(16),
                    width: double.infinity,
                    margin: EdgeInsets.all(8),
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                          side: BorderSide(color: Colors.white)),
                      onPressed: () {
                        setState(() {
                          // ignore: unnecessary_statements
                          en = !en;
                          print(en);
                          if (newName.text.toString().isNotEmpty) {
                            cust.name = newName.text.toString();
                            Provider.of<Customer>(context, listen: false)
                                .updateCustomerName(cust.name);
                            print(cust.name);
                          }
                          if (newEmail.text.toString().isNotEmpty) {
                            cust.email = newEmail.text.toString();
                            Provider.of<Customer>(context, listen: false)
                                .updateCustomerEmail(cust.email);
                          }
                          if (newPhone.text.toString().isNotEmpty) {
                            cust.phone = newPhone.text.toString();
                            Provider.of<Customer>(context, listen: false)
                                .updateCustomerPhone(cust.phone);
                          }
                        });
                      },
                      child: Text(
                        "EDIT",
                        style: TextStyle(
                          color: const Color(0xFFdc143c).withOpacity(0.9),
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      elevation: 5,
                      //padding: EdgeInsets.symmetric(horizontal: 64,vertical: 24),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

//static const routeName='ProfileScreen';
