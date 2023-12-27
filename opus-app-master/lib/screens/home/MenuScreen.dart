import 'package:flutter/material.dart';
import 'package:opusapp/screens/home/UnconfirmedBookings.dart';
import 'package:opusapp/screens/home/bookingtoEnd.dart';
import 'package:opusapp/screens/preference_shared/screenSizeConfig.dart';
import 'package:opusapp/screens/constants/SColors.dart';
import 'package:opusapp/screens/services/MapScreen.dart';
import 'package:opusapp/screens/services/Service.dart';

class MenuScreen extends StatefulWidget {
  @override
  _MenuScreenState createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();

  void onPressed() {
    this._key.currentState.openDrawer();
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
        key: this._key,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: 0,
          centerTitle: true,
          backgroundColor: SColors.PrimaryColorPurple,
          iconTheme: IconThemeData(color: Colors.white),
          leading: IconButton(
            icon: Icon(Icons.menu),
            onPressed: onPressed,
          ),
        ),
        drawer: Drawer(
          child: ListView(children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: SColors.PrimaryColorPurple,
              ),
              child: Center(
                  child: Text(
                'Bookings',
                style: TextStyle(
                    fontSize: ScreenSizeConfig.safeBlockHorizontal * 10,
                    color: Colors.white),
              )),
            ),
            ListTile(
              title: Text('Unconfirmed Bookings'),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            UnconfirmedBookings(bookings: [])));
              },
            ),
            ListTile(
              title: Text('Confirmed Bookings'),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => BookingListTOEnd(bookings: [])));
              },
            ),
          ]),
        ),
        body: ListView(children: [
          Container(
              // color: SColors.PrimaryColorPurple,
              // height: ScreenSizeConfig.safeBlockVertical * 50,
              // width: ScreenSizeConfig.safeBlockHorizontal * 100,
              ),
          Container(
            child: Column(
              children: [
                // Container(
                //   height: ScreenSizeConfig.safeBlockVertical * 7,
                //   width: ScreenSizeConfig.safeBlockHorizontal * 100,
                // ),
                // Container(
                //   color: SColors.PrimaryColorPurple,
                //   child: Row(
                //     children: [
                //       Container(
                //         width: ScreenSizeConfig.safeBlockHorizontal * 50,
                //         child: Padding(
                //           padding: const EdgeInsets.all(20.0),
                //           child: Stack(
                //             children: [
                //               Opacity(
                //                 opacity: 0.4,
                //                 child: Container(
                //                   height:
                //                       ScreenSizeConfig.safeBlockVertical * 4.25,
                //                   width:
                //                       ScreenSizeConfig.safeBlockHorizontal * 7.5,
                //                   decoration: BoxDecoration(
                //                     borderRadius: BorderRadius.circular(8),
                //                     color: Colors.grey[600],
                //                   ),
                //                 ),
                //               ),
                //               Padding(
                //                 padding: const EdgeInsets.all(2.0),
                //                 child: InkWell(
                //                   onTap: () {},
                //                   child: Container(
                //                     alignment: Alignment.centerLeft,
                //                     child: Icon(Icons.sort,
                //                         color: Colors.white,
                //                         size:
                //                             ScreenSizeConfig.safeBlockHorizontal *
                //                                 6),
                //                   ),
                //                 ),
                //               )
                //             ],
                //           ),
                //         ),
                //       ),
                //       Container(
                //         width: ScreenSizeConfig.safeBlockHorizontal * 50,
                //         child: Padding(
                //           padding: const EdgeInsets.all(20.0),
                //           child: Stack(
                //             children: [
                //               Container(
                //                 alignment: Alignment.centerRight,
                //                 child: Opacity(
                //                   opacity: 0.4,
                //                   child: Container(
                //                     height:
                //                         ScreenSizeConfig.safeBlockVertical * 4.25,
                //                     width: ScreenSizeConfig.safeBlockHorizontal *
                //                         7.5,
                //                     decoration: BoxDecoration(
                //                       borderRadius: BorderRadius.circular(8),
                //                       color: Colors.grey[600],
                //                     ),
                //                   ),
                //                 ),
                //               ),
                //               Padding(
                //                 padding: const EdgeInsets.all(2.0),
                //                 child: InkWell(
                //                   onTap: () {},
                //                   child: Container(
                //                     alignment: Alignment.centerRight,
                //                     child: Icon(Icons.search,
                //                         color: Colors.white,
                //                         size:
                //                             ScreenSizeConfig.safeBlockHorizontal *
                //                                 6),
                //                   ),
                //                 ),
                //               )
                //             ],
                //           ),
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
                Container(
                  color: Colors.white,
                  // height: ScreenSizeConfig.safeBlockVertical * 70,
                  // width: ScreenSizeConfig.safeBlockHorizontal * 100,
                  child: Column(
                    children: [
                      Container(
                          alignment: AlignmentDirectional.center,
                          width: ScreenSizeConfig.safeBlockHorizontal * 100,
                          padding: EdgeInsets.fromLTRB(
                              0,
                              ScreenSizeConfig.safeBlockHorizontal * 7,
                              0,
                              ScreenSizeConfig.safeBlockHorizontal * 3),
                          child: Text(
                            'Choose a service',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize:
                                    ScreenSizeConfig.safeBlockHorizontal * 5),
                          )),
                      SingleChildScrollView(
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 8.0, vertical: 0),
                              child: Container(
                                width:
                                    ScreenSizeConfig.safeBlockHorizontal * 100,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 10.0, vertical: 8),
                                      child: TextButton(
                                        child: Column(
                                          children: [
                                            Stack(
                                              children: [
                                                Opacity(
                                                  opacity: 0.2,
                                                  child: Container(
                                                    height: ScreenSizeConfig
                                                            .safeBlockVertical *
                                                        12.5,
                                                    width: ScreenSizeConfig
                                                            .safeBlockHorizontal *
                                                        20,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                      color: Color.fromRGBO(
                                                          110, 95, 255, 1),
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  height: ScreenSizeConfig
                                                          .safeBlockVertical *
                                                      12.5,
                                                  width: ScreenSizeConfig
                                                          .safeBlockHorizontal *
                                                      20,
                                                  child: Padding(
                                                    padding: EdgeInsets.all(
                                                        ScreenSizeConfig
                                                                .safeBlockHorizontal *
                                                            4),
                                                    child: Image.asset(
                                                      'assets/images/carpenter.png',
                                                      height: ScreenSizeConfig
                                                              .safeBlockVertical *
                                                          12.5,
                                                      width: ScreenSizeConfig
                                                              .safeBlockHorizontal *
                                                          20,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Text(
                                              'Carpenter',
                                              style: TextStyle(
                                                color: Colors.black,
                                              ),
                                            )
                                          ],
                                        ),
                                        onPressed: () {
                                          // Navigator.push(
                                          //   context,
                                          //   MaterialPageRoute(
                                          //       builder: (context) => Service(
                                          //           title: 'CARPENTER',
                                          //           id: "609e9a426ddd8201ccfb02d0")),
                                          // );

                                          //MapScreen

                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => MapScreen(
                                                    title: 'CARPENTER',
                                                    id: "609e9a426ddd8201ccfb02d0")),
                                          );
                                        },
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 10.0, vertical: 8),
                                      child: TextButton(
                                        child: Column(
                                          children: [
                                            Stack(
                                              children: [
                                                Opacity(
                                                  opacity: 0.2,
                                                  child: Container(
                                                    height: ScreenSizeConfig
                                                            .safeBlockVertical *
                                                        12.5,
                                                    width: ScreenSizeConfig
                                                            .safeBlockHorizontal *
                                                        20,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                      color: Color.fromRGBO(
                                                          255, 160, 8, 1),
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  height: ScreenSizeConfig
                                                          .safeBlockVertical *
                                                      12.5,
                                                  width: ScreenSizeConfig
                                                          .safeBlockHorizontal *
                                                      20,
                                                  child: Padding(
                                                    padding: EdgeInsets.all(
                                                        ScreenSizeConfig
                                                                .safeBlockHorizontal *
                                                            4),
                                                    child: Image.asset(
                                                      'assets/images/electrician.png',
                                                      height: ScreenSizeConfig
                                                              .safeBlockVertical *
                                                          12.5,
                                                      width: ScreenSizeConfig
                                                              .safeBlockHorizontal *
                                                          20,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Text(
                                              'Electrician',
                                              style: TextStyle(
                                                color: Colors.black,
                                              ),
                                            )
                                          ],
                                        ),
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => MapScreen(
                                                      id: "60a34da69afe9a00044bc937",
                                                      title: 'ELECTRICIAN',
                                                    )),
                                          );
                                        },
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 10.0, vertical: 8),
                                      child: TextButton(
                                        child: Column(
                                          children: [
                                            Stack(
                                              children: [
                                                Opacity(
                                                  opacity: 0.2,
                                                  child: Container(
                                                    height: ScreenSizeConfig
                                                            .safeBlockVertical *
                                                        12.5,
                                                    width: ScreenSizeConfig
                                                            .safeBlockHorizontal *
                                                        20,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                      color: Color.fromRGBO(
                                                          138, 193, 17, 1),
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  height: ScreenSizeConfig
                                                          .safeBlockVertical *
                                                      12.5,
                                                  width: ScreenSizeConfig
                                                          .safeBlockHorizontal *
                                                      20,
                                                  child: Padding(
                                                    padding: EdgeInsets.all(
                                                        ScreenSizeConfig
                                                                .safeBlockHorizontal *
                                                            4),
                                                    child: Image.asset(
                                                      'assets/images/plumber.png',
                                                      height: ScreenSizeConfig
                                                              .safeBlockVertical *
                                                          12.5,
                                                      width: ScreenSizeConfig
                                                              .safeBlockHorizontal *
                                                          20,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Text(
                                              'Plumber',
                                              style: TextStyle(
                                                color: Colors.black,
                                              ),
                                            )
                                          ],
                                        ),
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => MapScreen(
                                                    title: 'PLUMBER',
                                                    id: "60a4fb9bccd3b70004c5d62a")),
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 8.0, vertical: 0),
                              child: Container(
                                width:
                                    ScreenSizeConfig.safeBlockHorizontal * 100,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 10.0, vertical: 8),
                                      child: TextButton(
                                        child: Column(
                                          children: [
                                            Stack(
                                              children: [
                                                Opacity(
                                                  opacity: 0.2,
                                                  child: Container(
                                                    height: ScreenSizeConfig
                                                            .safeBlockVertical *
                                                        12.5,
                                                    width: ScreenSizeConfig
                                                            .safeBlockHorizontal *
                                                        20,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                      color: Color.fromRGBO(
                                                          0, 215, 226, 1),
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  height: ScreenSizeConfig
                                                          .safeBlockVertical *
                                                      12.5,
                                                  width: ScreenSizeConfig
                                                          .safeBlockHorizontal *
                                                      20,
                                                  child: Padding(
                                                    padding: EdgeInsets.all(
                                                        ScreenSizeConfig
                                                                .safeBlockHorizontal *
                                                            4),
                                                    child: Image.asset(
                                                      'assets/images/gardener.png',
                                                      height: ScreenSizeConfig
                                                              .safeBlockVertical *
                                                          12.5,
                                                      width: ScreenSizeConfig
                                                              .safeBlockHorizontal *
                                                          20,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Text(
                                              'Gardener',
                                              style: TextStyle(
                                                color: Colors.black,
                                              ),
                                            )
                                          ],
                                        ),
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => MapScreen(
                                                    title: 'GARDENER',
                                                    id: "60a4fbbdccd3b70004c5d62b")),
                                          );
                                        },
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 10.0, vertical: 8),
                                      child: TextButton(
                                        child: Column(
                                          children: [
                                            Stack(
                                              children: [
                                                Opacity(
                                                  opacity: 0.2,
                                                  child: Container(
                                                    height: ScreenSizeConfig
                                                            .safeBlockVertical *
                                                        12.5,
                                                    width: ScreenSizeConfig
                                                            .safeBlockHorizontal *
                                                        20,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                      color: Color.fromRGBO(
                                                          203, 131, 255, 1),
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  height: ScreenSizeConfig
                                                          .safeBlockVertical *
                                                      12.5,
                                                  width: ScreenSizeConfig
                                                          .safeBlockHorizontal *
                                                      20,
                                                  child: Padding(
                                                    padding: EdgeInsets.all(
                                                        ScreenSizeConfig
                                                                .safeBlockHorizontal *
                                                            4),
                                                    child: Image.asset(
                                                      'assets/images/masonry.png',
                                                      height: ScreenSizeConfig
                                                              .safeBlockVertical *
                                                          12.5,
                                                      width: ScreenSizeConfig
                                                              .safeBlockHorizontal *
                                                          20,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Text(
                                              'Masonry',
                                              style: TextStyle(
                                                color: Colors.black,
                                              ),
                                            )
                                          ],
                                        ),
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => MapScreen(
                                                    title: 'MASONRY',
                                                    id: "60a4fbfcccd3b70004c5d62c")),
                                          );
                                        },
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 10.0, vertical: 8),
                                      child: TextButton(
                                        child: Column(
                                          children: [
                                            Stack(
                                              children: [
                                                Opacity(
                                                  opacity: 0.2,
                                                  child: Container(
                                                    height: ScreenSizeConfig
                                                            .safeBlockVertical *
                                                        12.5,
                                                    width: ScreenSizeConfig
                                                            .safeBlockHorizontal *
                                                        20,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                      color: Color.fromRGBO(
                                                          255, 95, 95, 1),
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  height: ScreenSizeConfig
                                                          .safeBlockVertical *
                                                      12.5,
                                                  width: ScreenSizeConfig
                                                          .safeBlockHorizontal *
                                                      20,
                                                  child: Padding(
                                                    padding: EdgeInsets.all(
                                                        ScreenSizeConfig
                                                                .safeBlockHorizontal *
                                                            4),
                                                    child: Image.asset(
                                                      'assets/images/painter.png',
                                                      height: ScreenSizeConfig
                                                              .safeBlockVertical *
                                                          12.5,
                                                      width: ScreenSizeConfig
                                                              .safeBlockHorizontal *
                                                          20,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Text(
                                              'Painter',
                                              style: TextStyle(
                                                color: Colors.black,
                                              ),
                                            )
                                          ],
                                        ),
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => MapScreen(
                                                    title: 'PAINTER',
                                                    id: "60a4fc14ccd3b70004c5d62d")),
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 8.0, vertical: 0),
                              child: Container(
                                width:
                                    ScreenSizeConfig.safeBlockHorizontal * 100,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 10.0, vertical: 8),
                                      child: TextButton(
                                        child: Column(
                                          children: [
                                            Stack(
                                              children: [
                                                Opacity(
                                                  opacity: 0.2,
                                                  child: Container(
                                                    height: ScreenSizeConfig
                                                            .safeBlockVertical *
                                                        12.5,
                                                    width: ScreenSizeConfig
                                                            .safeBlockHorizontal *
                                                        20,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                      color: Color.fromRGBO(
                                                          47, 167, 255, 1),
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  height: ScreenSizeConfig
                                                          .safeBlockVertical *
                                                      12.5,
                                                  width: ScreenSizeConfig
                                                          .safeBlockHorizontal *
                                                      20,
                                                  child: Padding(
                                                    padding: EdgeInsets.all(
                                                        ScreenSizeConfig
                                                                .safeBlockHorizontal *
                                                            4),
                                                    child: Image.asset(
                                                      'assets/images/actechnician.png',
                                                      height: ScreenSizeConfig
                                                              .safeBlockVertical *
                                                          12.5,
                                                      width: ScreenSizeConfig
                                                              .safeBlockHorizontal *
                                                          20,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Text(
                                              'AC Technician',
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 13),
                                            )
                                          ],
                                        ),
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => MapScreen(
                                                    title: 'AC TECHNICIAN',
                                                    id: "60a4fc34ccd3b70004c5d62e")),
                                          );
                                        },
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 10.0, vertical: 8),
                                      child: TextButton(
                                        child: Column(
                                          children: [
                                            Stack(
                                              children: [
                                                Opacity(
                                                  opacity: 0.2,
                                                  child: Container(
                                                    height: ScreenSizeConfig
                                                            .safeBlockVertical *
                                                        12.5,
                                                    width: ScreenSizeConfig
                                                            .safeBlockHorizontal *
                                                        20,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                      color: Color.fromRGBO(
                                                          247, 38, 232, 1),
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  height: ScreenSizeConfig
                                                          .safeBlockVertical *
                                                      12.5,
                                                  width: ScreenSizeConfig
                                                          .safeBlockHorizontal *
                                                      20,
                                                  child: Padding(
                                                    padding: EdgeInsets.all(
                                                        ScreenSizeConfig
                                                                .safeBlockHorizontal *
                                                            4),
                                                    child: Image.asset(
                                                      'assets/images/cctv.png',
                                                      height: ScreenSizeConfig
                                                              .safeBlockVertical *
                                                          12.5,
                                                      width: ScreenSizeConfig
                                                              .safeBlockHorizontal *
                                                          20,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Text(
                                              'CCTV',
                                              style: TextStyle(
                                                color: Colors.black,
                                              ),
                                            )
                                          ],
                                        ),
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => MapScreen(
                                                    title: 'CCTV',
                                                    id: "60a4fc48ccd3b70004c5d62f")),
                                          );
                                        },
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 10.0, vertical: 8),
                                      child: TextButton(
                                        child: Column(
                                          children: [
                                            Stack(
                                              children: [
                                                Opacity(
                                                  opacity: 0.2,
                                                  child: Container(
                                                    height: ScreenSizeConfig
                                                            .safeBlockVertical *
                                                        12.5,
                                                    width: ScreenSizeConfig
                                                            .safeBlockHorizontal *
                                                        20,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                      color: Color.fromRGBO(
                                                          147, 147, 147, 1),
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  height: ScreenSizeConfig
                                                          .safeBlockVertical *
                                                      12.5,
                                                  width: ScreenSizeConfig
                                                          .safeBlockHorizontal *
                                                      20,
                                                  child: Padding(
                                                    padding: EdgeInsets.all(
                                                        ScreenSizeConfig
                                                                .safeBlockHorizontal *
                                                            4),
                                                    child: Icon(
                                                      Icons.add,
                                                      color: Colors.grey,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Text(
                                              'More',
                                              style: TextStyle(
                                                color: Colors.black,
                                              ),
                                            )
                                          ],
                                        ),
                                        onPressed: () {
                                          showDialog(
                                              context: context,
                                              builder: (ctx) => AlertDialog(
                                                    content: Text(
                                                        'We are working on adding new feature.'),
                                                  ));
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(
                      0, ScreenSizeConfig.safeBlockHorizontal * 6, 0, 0),
                  child: Container(
                    height: ScreenSizeConfig.safeBlockVertical * 8,
                    width: ScreenSizeConfig.safeBlockHorizontal * 100,
                    child: Row(
                      children: [
                        Container(
                          height: ScreenSizeConfig.safeBlockVertical * 10.2,
                          width: ScreenSizeConfig.safeBlockHorizontal * 20,
                          child: TextButton(
                            child: Container(
                              padding: EdgeInsets.all(
                                  ScreenSizeConfig.safeBlockHorizontal * 6),
                              child: Image.asset(
                                'images/menu_1.png',
                              ),
                            ),
                            onPressed: () {},
                          ),
                        ),
                        Container(
                          height: ScreenSizeConfig.safeBlockVertical * 10.2,
                          width: ScreenSizeConfig.safeBlockHorizontal * 20,
                          child: TextButton(
                            child: Container(
                              padding: EdgeInsets.all(
                                  ScreenSizeConfig.safeBlockHorizontal * 6),
                              child: Image.asset(
                                'images/menu_2.png',
                              ),
                            ),
                            onPressed: () {},
                          ),
                        ),
                        Container(
                          height: ScreenSizeConfig.safeBlockVertical * 10.2,
                          width: ScreenSizeConfig.safeBlockHorizontal * 20,
                          child: TextButton(
                            child: Container(
                              padding: EdgeInsets.all(
                                  ScreenSizeConfig.safeBlockHorizontal * 6),
                              child: Image.asset(
                                'images/menu_3.png',
                              ),
                            ),
                            onPressed: () {},
                          ),
                        ),
                        Container(
                          height: ScreenSizeConfig.safeBlockVertical * 10.2,
                          width: ScreenSizeConfig.safeBlockHorizontal * 20,
                          child: TextButton(
                            child: Container(
                              padding: EdgeInsets.all(
                                  ScreenSizeConfig.safeBlockHorizontal * 6),
                              child: Image.asset(
                                'images/menu_4.png',
                              ),
                            ),
                            onPressed: () {},
                          ),
                        ),
                        Container(
                          height: ScreenSizeConfig.safeBlockVertical * 10.2,
                          width: ScreenSizeConfig.safeBlockHorizontal * 20,
                          child: TextButton(
                            child: Container(
                              padding: EdgeInsets.all(
                                  ScreenSizeConfig.safeBlockHorizontal * 6),
                              child: Image.asset(
                                'images/menu_5.png',
                              ),
                            ),
                            onPressed: () {},
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ]),
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
                    padding: EdgeInsets.fromLTRB(
                        ScreenSizeConfig.safeBlockHorizontal * 1.5,
                        ScreenSizeConfig.safeBlockHorizontal * 6.5,
                        0,
                        0),
                    child: InkWell(
                      onTap: () {
                        //Navigator.pop(context);
//BookingListTOEnd
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    BookingListTOEnd(bookings: [])));
                      },
                      child: Container(
                        height: ScreenSizeConfig.safeBlockVertical * 2.25,
                        width: ScreenSizeConfig.safeBlockHorizontal * 5,
                        alignment: Alignment.centerLeft,
                        child: Image.asset('assets/images/details_icon.png'),
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
