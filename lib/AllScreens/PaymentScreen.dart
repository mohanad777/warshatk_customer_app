import 'package:credit_card/credit_card_form.dart';
import 'package:credit_card/credit_card_model.dart';
import 'package:credit_card/credit_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import 'package:warshatkcustomerapp/Models/Bill.dart';
import 'package:warshatkcustomerapp/Models/PaymentSystem.dart';
import 'package:warshatkcustomerapp/Models/Request.dart';
import 'package:warshatkcustomerapp/Models/Workshop.dart';
import 'package:warshatkcustomerapp/main.dart';
import 'package:warshatkcustomerapp/widgets/B_NavigationBar.dart';

class PaymentScreen extends StatefulWidget {
  static const routeName = 'PaymentScreen';
  final requestId;
  final workshopId;
  final billId;
  final cost;
  PaymentScreen({this.requestId, this.billId, this.cost, this.workshopId});
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<PaymentScreen> {
  var _isLoading = false;
  String cardNumber = '';
  String expiryDate = '';
  String cardHolderName = '';
  String cvvCode = '';
  bool isCvvFocused = false;
  int value;
  final GlobalKey<ScaffoldState> _mainkey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomPadding: false,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
          child: Column(
        children: <Widget>[
          CreditCardWidget(
            cardNumber: cardNumber,
            expiryDate: expiryDate,
            cardHolderName: cardHolderName,
            cvvCode: cvvCode,
            showBackView: isCvvFocused,
            height: 200,
            cardBgColor: Colors.black,
            textStyle: TextStyle(color: Colors.black),
            width: MediaQuery.of(context).size.width,
            animationDuration: Duration(milliseconds: 1000),
          ),
          new OutlineButton(
            child: _isLoading
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Text(
                    'Proceed to Pay',
                    style: TextStyle(color: Colors.red),
                  ),
            onPressed: () async {
              setState(() {
                _isLoading = true;
              });
 
              PaymentSystem ps = PaymentSystem();
              ps.iban = cardNumber;
              ps.amount = widget.cost;
              await ps.calculateAndUpdatePaymentSystem(widget.workshopId);
              ListOfRequests().updateRequest(
                  cust.id + widget.billId[widget.billId.toString().length - 1]);
           await   Bill().updateBill(widget.billId);
         setState(() {
                _isLoading = false;
              });
              return showDialog<void>(
                context: context,
                barrierDismissible: false,
                // user must tap button!

                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('How was the service?'),
                    content: SingleChildScrollView(
                      child: ListBody(
                        children: <Widget>[
                          RatingBar.builder(
                            initialRating: 3,
                            minRating: 1,
                            direction: Axis.horizontal,
                            allowHalfRating: true,
                            itemCount: 5,
                            itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                            itemBuilder: (context, _) => Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                            onRatingUpdate: (double rating) {
                              value = rating.toInt();
                            },
                          ),
                        ],
                      ),
                    ),
                    actions: <Widget>[
                      FlatButton(
                        child: Text('Approve'),
                        onPressed: () {
                          Provider.of<Workshops>(context, listen: false)
                              .updateRating(widget.workshopId, value);
                          //   Provider.of<Workshops>(context,listen: false).UpadteRatingFirebase(widget.req.servProvider);
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      B_NavigationBar(
                                        index: 0,
                                      )));
                        },
                      ),
                    ],
                  );
                },
              );
            },
            shape: new RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
          ),
          Expanded(
              child: SingleChildScrollView(
            child: CreditCardForm(
              onCreditCardModelChange: onModelChange,
            ),
          ))
        ],
      )),
    );
  }

  void onModelChange(CreditCardModel model) {
    setState(() {
      cardNumber = model.cardNumber;
      expiryDate = model.expiryDate;
      cardHolderName = model.cardHolderName;
      cvvCode = model.cvvCode;
      isCvvFocused = model.isCvvFocused;
    });
  }
}
