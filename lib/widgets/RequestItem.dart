import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:warshatkcustomerapp/AllScreens/RequestInfo.dart';
import 'package:warshatkcustomerapp/Models/Bill.dart';
import 'package:warshatkcustomerapp/Models/Request.dart';
import 'package:warshatkcustomerapp/Models/Workshop.dart';
import 'package:warshatkcustomerapp/widgets/Rating.dart';

class RequestItem extends StatefulWidget {
  final Request req;

  RequestItem(this.req);

  @override
  _RequestItemState createState() => _RequestItemState();
}

class _RequestItemState extends State<RequestItem> {
  Bill bill;

  void getBill() async {
    bill = await Bill().fetchBill(widget.req.billNo);

    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => RequestInfo(
                workshopId: widget.req.servProvider,
                id: widget.req.billNo,
                bill: bill,
                amount: 0,
                problem: widget.req.details,
                requestDate: widget.req.requestDate,
                requestId: widget.req.id,
                status: widget.req.status,
              )),
    );
  }

  int value = 0;
  Icon icon = Icon(Icons.check);

  get selectIcon {
    if ("Repairing" == widget.req.status)
      icon = Icon(
        Icons.radio_button_unchecked,
        color: Colors.black26,
      );
    else if ("active" == widget.req.status)
      icon = Icon(
        Icons.radio_button_checked,
        color: Colors.amber,
      );
    else
      icon = Icon(
        Icons.check_circle,
        color: Colors.black26,
      );
  }

  @override
  Widget build(BuildContext context) {
    selectIcon;
    return InkWell(
      onTap: () {
        if (widget.req.status != 'completed' &&
            widget.req.billNo.toString().isNotEmpty) {
          ///
          setState(() {
            getBill();
          });
        }
      },
      child: Card(
        elevation: 8,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        margin: EdgeInsets.all(4),
        child: ListTile(
            leading: (widget.req.status == 'pay')
                ? CircleAvatar(
                    radius: 30,
                    child: const Padding(
                      padding: EdgeInsets.all(6),
                      child: FittedBox(
                        child: Text('Pay'),
                      ),
                    ),
                  )
                : Icon(Icons.update),
            title: Text("Request#${widget.req.id}"),
            subtitle: Row(
              children: [
                Expanded(
                    child: Text(DateFormat.yMMMd().format(widget.req.date))),
                Text(widget.req.status),
              ],
            ),
            trailing: IconButton(
                icon: icon,
                onPressed: () {
                  return showDialog<void>(
                    context: context,
                    barrierDismissible: false,
                    // user must tap button!

                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Rating'),
                        content: SingleChildScrollView(
                          child: ListBody(
                            children: <Widget>[
                              RatingBar.builder(
                                initialRating: 3,
                                minRating: 1,
                                direction: Axis.horizontal,
                                allowHalfRating: true,
                                itemCount: 5,
                                itemPadding:
                                    EdgeInsets.symmetric(horizontal: 4.0),
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
                              print(
                                  '${widget.req.servProvider}!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!');
                              Provider.of<Workshops>(context, listen: false)
                                  .updateRating(widget.req.servProvider, value);
                              //   Provider.of<Workshops>(context,listen: false).UpadteRatingFirebase(widget.req.servProvider);
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      );
                    },
                  );
                  //  Rating();

                  //  Rating();

                  /*   return Navigator.push(
            context,
            MaterialPageRoute(builder: (context) {
             // return  RequestInfo();
            } ),
          );

        */
                })),
      ),
    );
  }
}
