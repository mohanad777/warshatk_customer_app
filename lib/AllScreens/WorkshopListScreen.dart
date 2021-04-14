import 'package:flutter/material.dart';
import 'package:warshatkcustomerapp/widgets/WorskshopListItems.dart';
import 'package:warshatkcustomerapp/Models/Workshop.dart';
import 'package:provider/provider.dart';
import 'package:warshatkcustomerapp/appar.dart';
import '../HeaderCurvedContainer.dart';

class WorkshopListScreen extends StatefulWidget {
  static const routName = "./WorkshopListScreen";

  @override
  _WorkshopListScreenState createState() => _WorkshopListScreenState();
}

class _WorkshopListScreenState extends State<WorkshopListScreen> {
  var _isLoading = false;
  @override
  void initState() {
    final workshopType =
        Provider.of<Workshop>(context, listen: false).workshopType;
    Provider.of<Workshops>(context, listen: false)
        .fetchWorkshops(workshopType.toLowerCase())
        .then((_) {
      setState(() {
        _isLoading = true;
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;
    final workshops = Provider.of<Workshops>(context).getWorkshops;

    return Scaffold(
      body: _isLoading
          ? SafeArea(
              child: Container(
                color: const Color.fromRGBO(226, 226, 226, 1.0),
                height: mq.height,
                child: Column(
                  children: [
                    Appbars('Workshops'),
                    CustomPaint(
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: mq.height * 0.17,
                      ),
                      painter: HeaderCurvedContainer(),
                    ),
                    Container(
                      // color: const Color.fromRGBO(226, 226, 226, 1.0),
                      height: mq.height * 0.66,
                      child: ListView.builder(
                        itemBuilder: (context, index) {
                          return WorskshopListItems(
                            Workshop(
                                id: workshops[index].id,
                                workshopType: workshops[index].workshopType,
                                tel: workshops[index].phone,
                                starList: workshops[index].starList,
                                rating: workshops[index].rating,
                                name: workshops[index].name,
                                carType: workshops[index].carType,
                                decetinces: workshops[index].decetinces),
                          );
                        },
                        itemCount: workshops.length,
                      ),
                    ),
                  ],
                ),
              ),
            )
          : Center(child: CircularProgressIndicator()),
    );
  }
}
