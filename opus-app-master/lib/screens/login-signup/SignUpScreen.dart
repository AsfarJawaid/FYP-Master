import 'package:flutter/material.dart';
import 'package:google_map_location_picker/google_map_location_picker.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:opusapp/screens/preference_shared/screenSizeConfig.dart';
import 'package:opusapp/screens/login-signup/shared/STextField.dart';
import 'package:opusapp/screens/login-signup/LoginScreen.dart';
import 'package:opusapp/screens/constants/SColors.dart';
import 'package:opusapp/utils/Http-Service.dart';
import 'package:opusapp/screens/constants/SKey.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final fullNameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final cityController = TextEditingController();
  final zoneController = TextEditingController();
  final locationController = TextEditingController();
  final passwordController = TextEditingController();
  var log = 0.0;
  var lat = 0.0;
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    ScreenSizeConfig().init(context);

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Stack(children: [
          Container(
            color: SColors.PrimaryColorPurple,
            height: ScreenSizeConfig.safeBlockVertical * 50,
            width: ScreenSizeConfig.safeBlockHorizontal * 100,
          ),
          Container(
            width: ScreenSizeConfig.safeBlockHorizontal * 100,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: ScreenSizeConfig.safeBlockVertical * 7,
                  width: ScreenSizeConfig.safeBlockHorizontal * 100,
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Stack(
                    children: [
                      Opacity(
                        opacity: 0.6,
                        child: Container(
                          height: ScreenSizeConfig.safeBlockVertical * 4.25,
                          width: ScreenSizeConfig.safeBlockHorizontal * 7.5,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.grey[600],
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          alignment: Alignment.centerLeft,
                          child: Icon(Icons.keyboard_arrow_left,
                              color: Colors.white,
                              size: ScreenSizeConfig.safeBlockHorizontal * 7.5),
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  height: ScreenSizeConfig.safeBlockVertical * 82.5,
                  width: ScreenSizeConfig.safeBlockHorizontal * 100,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(40.0),
                        bottomRight: Radius.circular(0.0),
                        topLeft: Radius.circular(40.0),
                        bottomLeft: Radius.circular(0.0)),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                            padding: EdgeInsets.fromLTRB(
                                ScreenSizeConfig.safeBlockHorizontal * 5,
                                ScreenSizeConfig.safeBlockHorizontal * 7,
                                0,
                                0),
                            child: Text(
                              'Create an account',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize:
                                      ScreenSizeConfig.safeBlockHorizontal * 6),
                            )),
                        Container(
                            padding: EdgeInsets.fromLTRB(
                                ScreenSizeConfig.safeBlockHorizontal * 5,
                                ScreenSizeConfig.safeBlockHorizontal * 1.25,
                                0,
                                ScreenSizeConfig.safeBlockHorizontal * 5),
                            child: Text(
                              'Sign Up to continue',
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontSize:
                                      ScreenSizeConfig.safeBlockHorizontal * 3),
                            )),
                        Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              STextField(
                                  title: 'Full Name',
                                  hint: 'opus',
                                  obscureField: false,
                                  thisController: fullNameController),
                              STextField(
                                  title: 'Email Address',
                                  hint: 'xyz@gmail.com',
                                  obscureField: false,
                                  thisController: emailController),
                              STextField(
                                  title: 'Phone Number*',
                                  hint: '0300-xxxxxxxxx',
                                  obscureField: false,
                                  thisController: phoneNumberController),
                              STextField(
                                  title: 'City',
                                  hint: 'Karachi',
                                  obscureField: false,
                                  thisController: cityController),
                              STextField(
                                  title: 'Zone',
                                  hint: 'ABC (Central District)',
                                  obscureField: false,
                                  thisController: zoneController),
                              Padding(
                                padding: EdgeInsets.only(
                                    bottom:
                                        ScreenSizeConfig.safeBlockHorizontal *
                                            2),
                                child: InkWell(
                                  onTap: () async {
                                    LocationResult result =
                                        await showLocationPicker(
                                            context, SKey().skey,
                                            myLocationButtonEnabled: true,
                                            layersButtonEnabled: true,
                                            initialCenter:
                                                LatLng(24.863, 67.012));
                                    print(result.latLng.latitude);
                                    this.lat = result.latLng.latitude;
                                    this.log = result.latLng.longitude;
                                  },
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        padding: EdgeInsets.fromLTRB(
                                            ScreenSizeConfig
                                                    .safeBlockHorizontal *
                                                5,
                                            0,
                                            ScreenSizeConfig
                                                    .safeBlockHorizontal *
                                                5,
                                            ScreenSizeConfig
                                                    .safeBlockHorizontal *
                                                2),
                                        child: Text(
                                          "Location",
                                          style: TextStyle(
                                              color: Colors.grey,
                                              fontSize: ScreenSizeConfig
                                                      .safeBlockHorizontal *
                                                  3),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.fromLTRB(
                                            ScreenSizeConfig
                                                    .safeBlockHorizontal *
                                                5,
                                            0,
                                            ScreenSizeConfig
                                                    .safeBlockHorizontal *
                                                5,
                                            0),
                                        child: Container(
                                            height: ScreenSizeConfig
                                                    .safeBlockVertical *
                                                8,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                border: Border.all(
                                                  width: 1,
                                                  color: Colors.grey[500],
                                                )),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      0, 0, 0, 0),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        right: ScreenSizeConfig
                                                                .screenWidth *
                                                            0.6),
                                                    child: Text(
                                                      "Location",
                                                      style: TextStyle(
                                                          color: Colors.grey),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            right: 8.0),
                                                    child: Container(
                                                      child: Icon(
                                                        Icons.location_pin,
                                                        color: Colors.grey,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            )),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              STextField(
                                  title: 'Password',
                                  hint: null,
                                  obscureField: true,
                                  thisController: passwordController),
                              Padding(
                                padding: EdgeInsets.fromLTRB(
                                    ScreenSizeConfig.safeBlockHorizontal * 5,
                                    ScreenSizeConfig.safeBlockHorizontal * 5,
                                    ScreenSizeConfig.safeBlockHorizontal * 5,
                                    ScreenSizeConfig.safeBlockHorizontal * 2),
                                child: Container(
                                  height:
                                      ScreenSizeConfig.safeBlockVertical * 7,
                                  width:
                                      ScreenSizeConfig.safeBlockHorizontal * 90,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: SColors.PrimaryColorPurple,
                                  ),
                                  child: TextButton(
                                    child: Text(
                                      'Create Account',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: ScreenSizeConfig
                                                  .safeBlockHorizontal *
                                              6),
                                    ),
                                    onPressed: () async {
                                      if (_formKey.currentState.validate()) {
                                        var client = {
                                          "fullName":
                                              this.fullNameController.text,
                                          "email": this.emailController.text,
                                          "phone":
                                              this.phoneNumberController.text,
                                          "city": this.cityController.text,
                                          "zone": this.zoneController.text,
                                          "location": {
                                            "log": this.log,
                                            "lat": this.lat
                                          },
                                          "password":
                                              this.passwordController.text,
                                        };
                                        print(client);
                                        var resp = await ApiHandler()
                                            .makePostRequest("/client", client);
                                        if (resp != null) {
                                          Navigator.pop(context);
                                        }
                                        print(resp);
                                      } else {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                                content: Text(
                                                    'Field Missing Error')));
                                      }
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: ScreenSizeConfig.safeBlockHorizontal * 100,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Already have an account?',
                                style: TextStyle(
                                  color: Colors.grey[600],
                                  //fontsize = 14
                                  fontSize:
                                      ScreenSizeConfig.safeBlockHorizontal *
                                          3.5,
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => LoginScreen()),
                                  );
                                },
                                child: Text(
                                  'Sign In',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    //fontsize = 14

                                    fontSize:
                                        ScreenSizeConfig.safeBlockHorizontal *
                                            3.5,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
