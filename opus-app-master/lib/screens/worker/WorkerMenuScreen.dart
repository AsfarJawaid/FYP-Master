import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:opusapp/screens/History/history.dart';
import 'package:opusapp/screens/WorkerPofile/workerProfile.dart';
import 'package:opusapp/screens/booking/bookinglist.dart';
import 'package:opusapp/screens/constants/SColors.dart';
import 'package:opusapp/screens/home/EmailSender.dart';
import 'package:opusapp/screens/home/NotificationScreen.dart';
import 'package:opusapp/screens/preference_shared/screenSizeConfig.dart';
import 'package:opusapp/screens/updateProfile/updateprofile.dart';
import 'package:opusapp/utils/Http-Service.dart';
import 'package:opusapp/utils/local-storage.dart';

class WorkerMenuScreen extends StatefulWidget {
  @override
  _WorkerMenuScreenState createState() => _WorkerMenuScreenState();
}

class _WorkerMenuScreenState extends State<WorkerMenuScreen> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      print(_selectedIndex);
      if (_selectedIndex == 2) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => WorkerProfile()),
        );
      } else if (_selectedIndex == 0) {
        //EmailSender
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => EmailSender()),
        );
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => NotificationScreen()),
        );
      }
    });
  }

  @override
  void initState() {
    super.initState();
    getWorkerbyId().then((e) {
      setState(() {});
    });
    getWorkerBooking().then((e) {
      setState(() {});
    });
    getWorkerHistoryBooking().then((e) {
      setState(() {});
    });
  }

  var worker;
  getWorkerbyId() async {
    worker = (await ApiHandler()
            .makeGetRequest("/worker/${Storage.getValue("worker_id")}"))
        .data["Worker"];
    getRanking().then((e) {
      setState(() {});
    });
  }

  var book = [];
  getWorkerBooking() async {
    book = (await ApiHandler().makeGetRequest(
            "/booking/book/worker/${Storage.getValue("worker_id")}"))
        .data["Booking"];
    print(book);
  }

  var rank;
  getRanking() async {
    var a = (await ApiHandler().makeGetRequest(
            "/worker/ranting/district/${Storage.getValue("worker_id")}/${worker["ServiceDetails"]["Service"]}"))
        .data;
    print(a);
    rank = a["count"];
  }

  var oldbook = [];
  getWorkerHistoryBooking() async {
    print("/booking/book/history/${Storage.getValue("worker_id")}");
    oldbook = (await ApiHandler().makeGetRequest(
            "/booking/book/history/${Storage.getValue("worker_id")}"))
        .data["Booking"];
    print(oldbook);
  }

  Future<bool> _onBackPressed() {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Logout User'),
        content: Text('Do you really want to logout the user?'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text('No'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text('Yes'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    ScreenSizeConfig().init(context);
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(
                Icons.mail,
                color: Colors.grey,
              ),
              label: 'Mail',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.notifications, color: Colors.grey),
              label: 'Notifications',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person, color: Colors.grey),
              label: 'profile',
            ),
            // BottomNavigationBarItem(
            //   icon: Icon(Icons.settings, color: Colors.grey),
            //   label: '',
            // ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: SColors.PrimaryColorPurple,
          onTap: _onItemTapped,
        ),
        appBar: AppBar(
            automaticallyImplyLeading: false,
            elevation: 0,
            centerTitle: true,
            backgroundColor: SColors.PrimaryColorPurple,
            title: Text("Home",
                style: TextStyle(fontSize: 18, color: Colors.white))
            //   flexibleSpace: GestureDetector(
            //     onTap: () {
            //       Navigator.pop(context);
            //     },
            //     child: _inkwells(),
            //   ),

            ),
        body: this.worker == null || this.book == null || this.oldbook == null
            ? Center(child: CircularProgressIndicator())
            : Container(
                color: Colors.grey[300],
                height: ScreenSizeConfig.screenHeight,
                child: SingleChildScrollView(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(
                          ScreenSizeConfig.safeBlockHorizontal * 6),
                      child: Container(
                          child: Text(
                        'Good Morning!',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: ScreenSizeConfig.safeBlockHorizontal * 7),
                      )),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.all(
                              ScreenSizeConfig.safeBlockHorizontal * 2),
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        BookingList(bookings: this.book)),
                              );
                            },
                            child: Container(
                              padding: EdgeInsets.all(
                                  ScreenSizeConfig.safeBlockHorizontal * 3),
                              decoration: BoxDecoration(
                                color: SColors.PrimaryColorPurple,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.all(
                                        ScreenSizeConfig.safeBlockHorizontal *
                                            5),
                                    child: Container(
                                        alignment: Alignment.topLeft,
                                        height:
                                            ScreenSizeConfig.safeBlockVertical *
                                                3,
                                        width: ScreenSizeConfig
                                                .safeBlockHorizontal *
                                            10,
                                        child: Image.asset(
                                            'assets/images/bookings_icon.png')),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(
                                        ScreenSizeConfig.safeBlockHorizontal *
                                            2),
                                    child: Text(
                                      ' Bookings   ',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: ScreenSizeConfig
                                                  .safeBlockHorizontal *
                                              6),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(
                                        ScreenSizeConfig.safeBlockHorizontal *
                                            2),
                                    child: Row(
                                      children: [
                                        Text(
                                          this.book.length.toString(),
                                          style: TextStyle(
                                              color: Colors.grey,
                                              fontWeight: FontWeight.bold,
                                              fontSize: ScreenSizeConfig
                                                      .safeBlockHorizontal *
                                                  6),
                                        ),
                                        Text(
                                          ' Items',
                                          style: TextStyle(
                                              color: Colors.grey,
                                              fontWeight: FontWeight.bold,
                                              fontSize: ScreenSizeConfig
                                                      .safeBlockHorizontal *
                                                  4),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(
                              ScreenSizeConfig.safeBlockHorizontal * 2),
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => HistoryList(
                                          bookings: this.oldbook,
                                        )),
                              );
                            },
                            child: Container(
                              padding: EdgeInsets.all(
                                  ScreenSizeConfig.safeBlockHorizontal * 3),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.all(
                                        ScreenSizeConfig.safeBlockHorizontal *
                                            5),
                                    child: Container(
                                        alignment: Alignment.topLeft,
                                        height:
                                            ScreenSizeConfig.safeBlockVertical *
                                                3,
                                        width: ScreenSizeConfig
                                                .safeBlockHorizontal *
                                            10,
                                        child: Image.asset(
                                            'assets/images/work_history_icon.png')),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(
                                        ScreenSizeConfig.safeBlockHorizontal *
                                            2),
                                    child: Text(
                                      'Work History',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: ScreenSizeConfig
                                                  .safeBlockHorizontal *
                                              6),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(
                                        ScreenSizeConfig.safeBlockHorizontal *
                                            2),
                                    child: Row(
                                      children: [
                                        Text(
                                          this.oldbook.length.toString(),
                                          style: TextStyle(
                                              color: Colors.grey,
                                              fontWeight: FontWeight.bold,
                                              fontSize: ScreenSizeConfig
                                                      .safeBlockHorizontal *
                                                  6),
                                        ),
                                        Text(
                                          ' Items',
                                          style: TextStyle(
                                              color: Colors.grey,
                                              fontWeight: FontWeight.bold,
                                              fontSize: ScreenSizeConfig
                                                      .safeBlockHorizontal *
                                                  4),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    // Center(
                    //   child: Padding(
                    //     padding:
                    //         EdgeInsets.all(ScreenSizeConfig.safeBlockHorizontal * 3),
                    //     child: Container(
                    //         padding: EdgeInsets.all(
                    //             ScreenSizeConfig.safeBlockHorizontal * 2),
                    //         decoration: BoxDecoration(
                    //           borderRadius: BorderRadius.circular(20),
                    //           color: Colors.white,
                    //         ),
                    //         height: ScreenSizeConfig.safeBlockVertical * 30,
                    //         width: ScreenSizeConfig.safeBlockHorizontal * 80,
                    //         child: Column(
                    //           children: [
                    //             Row(
                    //               children: [
                    //                 Padding(
                    //                   padding: EdgeInsets.all(
                    //                       ScreenSizeConfig.safeBlockHorizontal * 5),
                    //                   child: Container(
                    //                       alignment: Alignment.topLeft,
                    //                       height:
                    //                           ScreenSizeConfig.safeBlockVertical * 5,
                    //                       width:
                    //                           ScreenSizeConfig.safeBlockHorizontal * 10,
                    //                       child: Image.asset(
                    //                           'assets/images/bookmark_icon.png')),
                    //                 ),
                    //                 Text(
                    //                   'Rating',
                    //                   style: TextStyle(
                    //                     color: Colors.black,
                    //                     fontWeight: FontWeight.w300,
                    //                     fontSize:
                    //                         ScreenSizeConfig.safeBlockHorizontal * 6,
                    //                   ),
                    //                 ),
                    //               ],
                    //             ),
                    //             Row(
                    //               children: [
                    //                 Text(
                    //                   '3.0',
                    //                   style: TextStyle(
                    //                     color: Colors.black,
                    //                     fontWeight: FontWeight.w300,
                    //                     fontSize:
                    //                         ScreenSizeConfig.safeBlockHorizontal * 6,
                    //                   ),
                    //                 ),
                    //                 Container(
                    //                   child: RatingBar.builder(
                    //                     initialRating: 0.5 * 5,
                    //                     minRating: 0.0 * 5,
                    //                     maxRating: 1.0 * 5,
                    //                     direction: Axis.horizontal,
                    //                     itemCount: 5,
                    //                     itemSize:
                    //                         ScreenSizeConfig.safeBlockHorizontal * 7,
                    //                     itemPadding: EdgeInsets.symmetric(
                    //                         horizontal:
                    //                             ScreenSizeConfig.safeBlockHorizontal *
                    //                                 1),
                    //                     itemBuilder: (context, _) => Icon(
                    //                       Icons.star,
                    //                       color: Colors.amber,
                    //                     ),
                    //                     onRatingUpdate: (r) {},
                    //                   ),
                    //                 ),
                    //               ],
                    //             ),
                    //             TextButton(
                    //                 onPressed: () {},
                    //                 child: Text(
                    //                   'view reviews ->',
                    //                   style: TextStyle(color: Colors.black),
                    //                 ))
                    //           ],
                    //         )),
                    //   ),
                    // ),
                    Center(
                      child: Container(
                          width: ScreenSizeConfig.screenWidth * 0.8,
                          child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(top: 12),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left:
                                                  ScreenSizeConfig.screenWidth *
                                                      0.12),
                                          child: Container(
                                              alignment: Alignment.topLeft,
                                              height: ScreenSizeConfig
                                                      .safeBlockVertical *
                                                  5,
                                              width: ScreenSizeConfig
                                                      .safeBlockHorizontal *
                                                  10,
                                              child: Image.asset(
                                                  'assets/images/bookmark_icon.png')),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left:
                                                  ScreenSizeConfig.screenWidth *
                                                      0.08),
                                          child: Text(
                                            'Rating',
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w300,
                                              fontSize: ScreenSizeConfig
                                                      .safeBlockHorizontal *
                                                  6,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.only(top: 15.0, bottom: 15),
                                    child: Row(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left:
                                                  ScreenSizeConfig.screenWidth *
                                                      0.1),
                                          child: Text(
                                            worker["rating"].toString(),
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w300,
                                              fontSize: ScreenSizeConfig
                                                      .safeBlockHorizontal *
                                                  6,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(left: 8.0),
                                          child: Container(
                                            child: RatingBar.builder(
                                              initialRating: double.parse(
                                                      worker["rating"]) *
                                                  5,
                                              minRating: 0.0 * 5,
                                              maxRating: 1.0 * 5,
                                              direction: Axis.horizontal,
                                              itemCount: 5,
                                              // int.parse(worker["rating"]),
                                              itemSize: ScreenSizeConfig
                                                      .safeBlockHorizontal *
                                                  7,
                                              itemPadding: EdgeInsets.symmetric(
                                                  horizontal: ScreenSizeConfig
                                                          .safeBlockHorizontal *
                                                      1),
                                              itemBuilder: (context, _) => Icon(
                                                Icons.star,
                                                color: Colors.amber,
                                              ),
                                              onRatingUpdate: (r) {},
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ))),
                    ),

                    Center(
                      child: Container(
                          width: ScreenSizeConfig.screenWidth * 0.8,
                          child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(top: 8.0),
                                    child: Row(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left:
                                                  ScreenSizeConfig.screenWidth *
                                                      0.08),
                                          child: Container(
                                              alignment: Alignment.topLeft,
                                              height: ScreenSizeConfig
                                                      .safeBlockVertical *
                                                  5,
                                              width: ScreenSizeConfig
                                                      .safeBlockHorizontal *
                                                  10,
                                              child: Image.asset(
                                                  'assets/images/bookmark_icon.png')),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left:
                                                  ScreenSizeConfig.screenWidth *
                                                      0.04),
                                          child: Text(
                                            'Ranking',
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w300,
                                              fontSize: ScreenSizeConfig
                                                      .safeBlockHorizontal *
                                                  6,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.only(top: 15.0, bottom: 15),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        children: [
                                          Flexible(
                                            child: Center(
                                              child: Text(
                                                'You are ranked top ${this.rank} out of all ${this.worker["professionTitle"]}',
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w300,
                                                  fontSize: ScreenSizeConfig
                                                          .safeBlockHorizontal *
                                                      6,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ))),
                    ),

                    Center(
                      child: Padding(
                        padding: EdgeInsets.all(
                            ScreenSizeConfig.safeBlockHorizontal * 3),
                        child: Container(
                          padding: EdgeInsets.all(
                              ScreenSizeConfig.safeBlockHorizontal * 2),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white,
                          ),
                          height: ScreenSizeConfig.safeBlockVertical * 10,
                          width: ScreenSizeConfig.safeBlockHorizontal * 80,
                          child: TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          UpdateProfileCreate()),
                                );
                              },
                              child: Text(
                                'Update Profile',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w300,
                                  fontSize:
                                      ScreenSizeConfig.safeBlockHorizontal * 6,
                                ),
                              )),
                        ),
                      ),
                    ),
                  ],
                )),
              ),
      ),
    );
  }

  Widget _inkwells() {
    return Container(
      color: SColors.PrimaryColorPurple,
      child: Row(
        children: [
          Container(
            // width: ScreenSizeConfig.safeBlockHorizontal * 50,
            child: Padding(
              padding: EdgeInsets.fromLTRB(
                  ScreenSizeConfig.safeBlockHorizontal * 5,
                  ScreenSizeConfig.safeBlockHorizontal * 6,
                  0,
                  0),
              child: Stack(
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(
                        0, ScreenSizeConfig.safeBlockHorizontal * 5, 0, 0),
                    child: Opacity(
                      opacity: 0.4,
                      child: Container(
                        height: ScreenSizeConfig.safeBlockVertical * 4.25,
                        width: ScreenSizeConfig.safeBlockHorizontal * 7.5,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.grey[600],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: InkWell(
                      onTap: () {
                        // Navigator.pop(context);
                      },
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(
                            ScreenSizeConfig.safeBlockHorizontal * 1,
                            ScreenSizeConfig.safeBlockHorizontal * 5.5,
                            0,
                            0),
                        child: Container(
                            alignment: Alignment.centerLeft,
                            height: ScreenSizeConfig.safeBlockVertical * 2.25,
                            width: ScreenSizeConfig.safeBlockHorizontal * 5,
                            child: Image.asset('assets/images/details_icon.png')
                            // Icon(Icons.keyboard_arrow_left,
                            //     color: Colors.white,
                            //     size: ScreenSizeConfig.safeBlockHorizontal * 6),
                            ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
