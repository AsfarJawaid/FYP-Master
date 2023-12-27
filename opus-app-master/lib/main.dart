import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:opusapp/screens/StartScreen.dart';
import 'package:opusapp/screens/constants/SColors.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      title: 'EasyFix',
      theme: ThemeData(
          scaffoldBackgroundColor: Colors.white,
          primaryColor: SColors.PrimaryColorPurple),
      debugShowCheckedModeBanner: false,
      home: StartScreen(),
    );
  }
}
