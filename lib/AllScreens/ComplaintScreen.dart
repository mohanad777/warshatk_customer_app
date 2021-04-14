import 'package:flutter/material.dart';
import 'package:warshatkcustomerapp/AllScreens/ProfileScreen.dart';
import 'package:warshatkcustomerapp/AllScreens/SettingPage.dart';
import 'package:warshatkcustomerapp/AllScreens/WaitingScreen.dart';
import 'package:warshatkcustomerapp/Models/Bill.dart';
import 'package:warshatkcustomerapp/Models/Complaint.dart';
import 'package:warshatkcustomerapp/Models/Request.dart';
import 'package:warshatkcustomerapp/main.dart';

class ComplaintScreen extends StatelessWidget {
  ListOfComplaints lor = ListOfComplaints();
  static const routName = 'ComplaintScreen';

  String name;
  Complaint c = Complaint();

  //WorkshopInfoScreen(this.name);

  TextEditingController suggestion = TextEditingController();
  TextEditingController descrip = TextEditingController();
  TextEditingController title = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final routeArgs =
        ModalRoute.of(context).settings.arguments as Map<String, String>;
    // final workshoPhonebn = routeArgs['workshoPhone'];

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Complaint',
            style: TextStyle(fontSize: 24),
          ),
          backgroundColor: const Color(0xFFdc143c).withOpacity(0.9),
          centerTitle: true,
        ),
        // resizeToAvoidBottomPadding: false,
        //  resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                    color: Color.fromRGBO(226, 226, 226, 1.0),
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(20),
                        topLeft: Radius.circular(20))),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  // crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    SizedBox(
                      height: 50,
                    ),
                    Text(
                      "    Title",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),

                    SizedBox(
                      height: 20,
                    ),
                    // TextFieldStyling("Enter your text here")
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
                            // maxLines: 1,
                            decoration: InputDecoration.collapsed(
                                hintText: "Enter your text here"),

                            controller: title,
                          ),
                        )),

                    SizedBox(
                      height: 30,
                    ),
                    Text(
                      "    Type the details of your complaint below",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(
                      height: 20,
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
                            maxLines: 8,
                            decoration: InputDecoration.collapsed(
                                hintText: "Enter your text here"),
                            controller: descrip,
                          ),
                        )),
                    SizedBox(
                      height: 30,
                    ),
                    Text(
                      "    Suggestion",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    //  TextFieldStyling("Enter your text here"),
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
                            // maxLines: 1,
                            decoration: InputDecoration.collapsed(
                                hintText: "Enter your text here(Optional)"),
                            controller: suggestion,
                          ),
                        )),
                    SizedBox(
                      height: 40,
                    ),
                    // Button(name:'ٍSend',obj: Conf_SendRequest(),color: Colors.white,),

                    RaisedButton(
                      color: Colors.amber,
                      textColor: Colors.white,
                      child: Container(
                        height: 38,
                        width: double.infinity,
                        child: Center(
                          child: Text(
                            "Send",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 24,
                              fontFamily: "Brand Bold",
                            ),
                          ),
                        ),
                      ),
                      onPressed: () async {
                        c.title = title.text;
                        c.customer = cust.phone;
                        c.details = descrip.text;
                        c.suggestion = suggestion.text;
                        c.ComplaintDate = DateTime.now();
                        c.date = DateTime.now();

                        print(
                            '........................................................................');

                        print(
                            '........................................................................');
                        print(c.toString());
                        print(
                            '........................................................................');
                        //  await lob.addBill(b);
                        await lor.addComplaint(c);
                        //  Navigator.of(context).pushReplacementNamed(WiatingScreen.routeName);
                        Navigator.of(context)
                            .pushReplacementNamed(SettingPage.routeName);

                        // loginWithAuth(context);
                      },
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
