import 'package:flutter/material.dart';
import 'package:opusapp/screens/constants/SColors.dart';
import 'package:opusapp/screens/preference_shared/screenSizeConfig.dart';
import 'package:opusapp/utils/Http-Service.dart';
import 'package:opusapp/utils/local-storage.dart';

class UnconfirmedBookings extends StatefulWidget {
  var bookings;
  UnconfirmedBookings({@required this.bookings});
  @override
  _UnconfirmedBookingsState createState() => _UnconfirmedBookingsState();
}

class _UnconfirmedBookingsState extends State<UnconfirmedBookings> {
  bool isLoading;
  @override
  void initState() {
    super.initState();
    isLoading = true;
    initial().then((e) {
      setState(() {
        isLoading = false;
      });
    });
  }

  var book = [];
  initial() async {
    print("booking/book/client/pending/${Storage.getValue("worker_id")}");
    var resp = await ApiHandler().makeGetRequest(
        "/booking/book/client/pending/${Storage.getValue("worker_id")}");
    book = resp.data["Booking"];
  }

  @override
  Widget build(BuildContext context) {
    ScreenSizeConfig().init(context);
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : book.length == 0
              ? Center(child: Text("No Unconfirmed Booking"))
              : Container(
                  color: Colors.grey[300],
                  child: Stack(
                    children: [
                      Container(
                        color: SColors.PrimaryColorPurple,
                        height: ScreenSizeConfig.safeBlockVertical * 28,
                        width: ScreenSizeConfig.safeBlockHorizontal * 100,
                      ),
                      Container(
                        child: Column(
                          children: [
                            Container(
                              height: ScreenSizeConfig.safeBlockVertical * 7,
                              width: ScreenSizeConfig.safeBlockHorizontal * 100,
                            ),
                            Container(
                              alignment: AlignmentDirectional.centerStart,
                              width: ScreenSizeConfig.safeBlockHorizontal * 100,
                              padding: EdgeInsets.fromLTRB(
                                  ScreenSizeConfig.safeBlockHorizontal * 8,
                                  ScreenSizeConfig.safeBlockHorizontal * 24,
                                  0,
                                  ScreenSizeConfig.safeBlockHorizontal * 0),
                              child: Row(
                                children: [
                                  Text(
                                    'Unconfirmed Bookings ',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: ScreenSizeConfig
                                                .safeBlockHorizontal *
                                            6),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              width: ScreenSizeConfig.screenWidth * 0.88,
                              height: ScreenSizeConfig.screenHeight * 0.72,
                              child: ListView.builder(
                                itemCount: book.length,
                                itemBuilder: (context, index) {
                                  return Container(
                                      width:
                                          ScreenSizeConfig.screenWidth * 0.88,
                                      child: Card(
                                          shape: BeveledRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                          ),
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.all(8.0),
                                                child: Container(
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Padding(
                                                        padding: EdgeInsets.only(
                                                            left: ScreenSizeConfig
                                                                    .screenWidth *
                                                                0.15),
                                                        child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                                book[index]["Worker"]
                                                                        [
                                                                        "fullName"]
                                                                    .toString(),
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        18,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold)),
                                                            Text(
                                                                book[index]["Worker"]
                                                                        [
                                                                        "phone"]
                                                                    .toString(),
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: 11,
                                                                ))
                                                          ],
                                                        ),
                                                      ),
                                                      Container(
                                                          child: Padding(
                                                        padding: EdgeInsets.only(
                                                            right: ScreenSizeConfig
                                                                    .screenWidth *
                                                                0.1),
                                                        child: Icon(
                                                          Icons.comment,
                                                          color: Colors.grey,
                                                        ),
                                                      ))
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          )));
                                },
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
    );
  }
}
