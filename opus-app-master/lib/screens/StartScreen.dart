import 'package:flutter/material.dart';
import 'package:opusapp/screens/login-signup/SignUpScreenServiceProv.dart';
import 'package:opusapp/screens/preference_shared/screenSizeConfig.dart';
import 'package:opusapp/screens/login-signup/LoginScreen.dart';
import 'package:opusapp/screens/login-signup/SignUpScreen.dart';
import 'package:opusapp/screens/constants/SColors.dart';
import 'package:opusapp/utils/local-storage.dart';

class StartScreen extends StatefulWidget {
  @override
  _StartScreenState createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initialize().then((e) {
      setState(() {});
    });
  }

  initialize() async {
    await Storage.initialize();
  }

  @override
  Widget build(BuildContext context) {
    ScreenSizeConfig().init(context);
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            color: SColors.PrimaryColorPurple,
            image: DecorationImage(
              image: AssetImage('assets/images/opus_background.png'),
              fit: BoxFit.fill,
            )),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                //logo
                Container(
                  padding:
                      EdgeInsets.all(ScreenSizeConfig.safeBlockHorizontal * 25),
                  height: ScreenSizeConfig.safeBlockVertical * 60,
                  width: ScreenSizeConfig.safeBlockHorizontal * 90,
                  child: Image.asset('assets/images/easyfix.png'),
                ),
                //signup button
                Container(
                    height: ScreenSizeConfig.safeBlockVertical * 8,
                    width: ScreenSizeConfig.safeBlockHorizontal * 35,
                    padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                    child: RaisedButton(
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(70.0)),
                      textColor: Colors.purple,
                      color: Colors.white,
                      child: Container(
                        width: ScreenSizeConfig.safeBlockHorizontal * 20,
                        alignment: Alignment.center,
                        child: Text(
                          'Sign Up',
                          style: TextStyle(
                              color: SColors.PrimaryColorPurple,
                              fontWeight: FontWeight.w300,
                              //fontsize = 20
                              fontSize:
                                  ScreenSizeConfig.safeBlockHorizontal * 5),
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SignUpScreen()),
                        );
                      },
                    )),
                //login button
                Container(
                    height: ScreenSizeConfig.safeBlockVertical * 8,
                    width: ScreenSizeConfig.safeBlockHorizontal * 35,
                    padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                    child: RaisedButton(
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(70.0)),
                      textColor: Colors.purple,
                      color: Colors.white,
                      child: Container(
                        width: ScreenSizeConfig.safeBlockHorizontal * 20,
                        alignment: Alignment.center,
                        child: Text(
                          'Login',
                          style: TextStyle(
                              color: SColors.PrimaryColorPurple,
                              fontWeight: FontWeight.w300,
                              //fontsize = 20
                              fontSize:
                                  ScreenSizeConfig.safeBlockHorizontal * 5),
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LoginScreen()),
                        );
                      },
                    )),
                Container(
                  height: ScreenSizeConfig.safeBlockVertical * 10,
                  width: ScreenSizeConfig.safeBlockHorizontal * 90,
                ),
                //Sign up as service provider
                Container(
                  height: ScreenSizeConfig.safeBlockVertical * 5,
                  width: ScreenSizeConfig.safeBlockHorizontal * 90,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    ServiceProviderSignUpScreen()),
                          );
                        },
                        child: Text(
                          'SIGNUP',
                          style: TextStyle(
                            color: Colors.yellow,
                            //fontsize = 14
                            fontSize:
                                ScreenSizeConfig.safeBlockHorizontal * 3.5,
                          ),
                        ),
                      ),
                      Text(
                        'AS A SERVICE PROVIDER',
                        style: TextStyle(
                          color: Colors.white,
                          //fontsize = 14
                          fontSize: ScreenSizeConfig.safeBlockHorizontal * 3.5,
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
