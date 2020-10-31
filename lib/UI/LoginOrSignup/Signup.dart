import 'dart:async';
import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'package:treva_shop_flutter/Library/Language_Library/lib/easy_localization_delegate.dart';
import 'package:treva_shop_flutter/Library/Language_Library/lib/easy_localization_provider.dart';
import 'package:flutter/material.dart';
import 'package:treva_shop_flutter/UI/BottomNavigationBar.dart';
import 'package:treva_shop_flutter/UI/LoginOrSignup/Login.dart';
import 'package:treva_shop_flutter/UI/LoginOrSignup/LoginAnimation.dart';
import 'package:treva_shop_flutter/UI/LoginOrSignup/Signup.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:treva_shop_flutter/config.dart';
import '../../api_service.dart';
import '../../models/customer_model.dart';

class Signup extends StatefulWidget {
  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> with TickerProviderStateMixin {
  //Animation Declaration
  AnimationController sanimationController;
  AnimationController animationControllerScreen;
  Animation animationScreen;
  String firstName = '';
  String lastName = '';
  String email = '';
  String password = '';
  CustomerModel model;
  APIService service;
  var tap = 0;
  var _formKey = GlobalKey<FormState>();

  /// Set AnimationController to initState
  @override
  void initState() {
    service = APIService();
    sanimationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 800))
          ..addStatusListener((statuss) {
            if (statuss == AnimationStatus.dismissed) {
              setState(() {
                tap = 0;
              });
            }
          });
    // TODO: implement initState
    super.initState();
  }

  /// Dispose animationController
  @override
  void dispose() {
    sanimationController.dispose();
    super.dispose();
  }

  /// Playanimation set forward reverse
  Future<Null> _PlayAnimation() async {
    try {
      await sanimationController.forward();
      await sanimationController.reverse();
    } on TickerCanceled {}
  }

  /// Component Widget layout UI
  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    mediaQueryData.devicePixelRatio;
    mediaQueryData.size.height;
    mediaQueryData.size.width;

    var data = EasyLocalizationProvider.of(context).data;
    return EasyLocalizationProvider(
      data: data,
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            Container(
              color: Colors.grey,

              /// Set Background image in layout
              // decoration: BoxDecoration(
              //     image: DecorationImage(
              //   image: AssetImage("assets/img/backgroundgirl.png"),
              //   fit: BoxFit.cover,
              // )),
              child: Container(
                /// Set gradient color in image
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color.fromRGBO(0, 0, 0, 0.2),
                      Color.fromRGBO(0, 0, 0, 0.3)
                    ],
                    begin: FractionalOffset.topCenter,
                    end: FractionalOffset.bottomCenter,
                  ),
                ),

                /// Set component layout
                child: ListView(
                  padding: EdgeInsets.all(0.0),
                  children: <Widget>[
                    Stack(
                      alignment: AlignmentDirectional.bottomCenter,
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            Container(
                              alignment: AlignmentDirectional.topCenter,
                              child: Column(
                                children: <Widget>[
                                  /// padding logo
                                  Padding(
                                      padding: EdgeInsets.only(
                                          top: mediaQueryData.padding.top +
                                              40.0)),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Image(
                                        image:
                                            AssetImage("assets/img/Logo.png"),
                                        height: 70.0,
                                      ),
                                      Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 10.0)),

                                      /// Animation text treva shop accept from login layout
                                      Hero(
                                        tag: "Treva",
                                        child: Text(
                                          AppLocalizations.of(context)
                                              .tr('title'),
                                          style: TextStyle(
                                              fontWeight: FontWeight.w900,
                                              letterSpacing: 0.6,
                                              fontFamily: "Sans",
                                              color: Colors.white,
                                              fontSize: 20.0),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Form(
                                    key: _formKey,
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Padding(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 50.0)),

                                        /// TextFromField First Name
                                        textFromField(
                                          validator: (value) {
                                            if (value.isEmpty) {
                                              return 'Please Enter Your First Name';
                                            }
                                            if (value.length < 3) {
                                              return 'Your Name is too short';
                                            }
                                            return null;
                                          },
                                          onChanged: (value) =>
                                              firstName = value,
                                          icon: Icons.person,
                                          password: false,
                                          email: AppLocalizations.of(context)
                                              .tr('first_Name'),
                                          inputType: TextInputType.emailAddress,
                                        ),
                                        Padding(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 5.0)),

                                        /// TextFromField Last Name
                                        textFromField(
                                          validator: (value) {
                                            return null;
                                          },
                                          onChanged: (value) => email = value,
                                          icon: Icons.email,
                                          password: false,
                                          email: AppLocalizations.of(context)
                                              .tr('last_Name'),
                                          inputType: TextInputType.emailAddress,
                                        ),
                                        Padding(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 5.0)),

                                        /// TextFromField Email
                                        textFromField(
                                          validator: (value) {
                                            if (value.isEmpty) {
                                              return 'Please Enter Email';
                                            }
                                            if (!value.contains('@') ||
                                                !value.endsWith('.com')) {
                                              return 'Please Enter a valid Email';
                                            }
                                            return null;
                                          },
                                          onChanged: (value) => email = value,
                                          icon: Icons.email,
                                          password: false,
                                          email: AppLocalizations.of(context)
                                              .tr('email'),
                                          inputType: TextInputType.emailAddress,
                                        ),
                                        Padding(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 5.0)),

                                        /// TextFromField Password
                                        textFromField(
                                          validator: (value) {
                                            if (value.isEmpty) {
                                              return 'Please Enter Password';
                                            }
                                            if (value.length < 6) {
                                              return 'Your Password is too short';
                                            }
                                            return null;
                                          },
                                          onChanged: (value) =>
                                              password = value,
                                          icon: Icons.vpn_key,
                                          password: true,
                                          email: AppLocalizations.of(context)
                                              .tr('password'),
                                          inputType: TextInputType.text,
                                        ),
                                      ],
                                    ),
                                  ),

                                  /// Button Login
                                  FlatButton(
                                      padding: EdgeInsets.only(top: 20.0),
                                      onPressed: () {
                                        Navigator.of(context).pushReplacement(
                                            MaterialPageRoute(
                                                builder:
                                                    (BuildContext context) =>
                                                        new loginScreen()));
                                      },
                                      child: Text(
                                        AppLocalizations.of(context)
                                            .tr('notHaveLogin'),
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 13.0,
                                            fontWeight: FontWeight.w600,
                                            fontFamily: "Sans"),
                                      )),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        top: mediaQueryData.padding.top + 120.0,
                                        bottom: 0.0),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),

                        /// Set Animaion after user click buttonLogin
                        tap == 0
                            ? InkWell(
                                splashColor: Colors.yellow,
                                onTap: () async {
                                  var isValidate =
                                      _formKey.currentState.validate();
                                  if (isValidate) {
                                    // model = CustomerModel(
                                    //   email: email,
                                    //   firstName: firstName,
                                    //   lastName: lastName,
                                    //   password: password,
                                    // );
                                    // var ret = await service.createUser(model);
                                    var authToken = base64.encode(
                                      utf8.encode(
                                          Config.key + ":" + Config.secret),
                                    );
                                    print('ssgg');
                                    print(authToken);
                                    try {
                                      var response = await Dio().post(
                                        'https://qaaws.com/wp-json/wp/v2/users/',
                                        data: {
                                          'username': email.trim(),
                                          'password': password.trim(),
                                          'email': email.trim()
                                        },
                                        options: Options(
                                          headers: {
                                            HttpHeaders.authorizationHeader:
                                                'Basic $authToken',
                                            HttpHeaders.contentTypeHeader:
                                                'application/json',
                                          },
                                        ),
                                      );

                                      setState(() {
                                        tap = 1;
                                      });
                                      new LoginAnimation(
                                        animationController:
                                            sanimationController.view,
                                      );
                                      _PlayAnimation();
                                    } on DioError catch (error) {
                                      print(error.response);
                                    }
                                  }
                                  return tap;
                                },
                                child: buttonBlackBottom(),
                              )
                            : new LoginAnimation(
                                animationController: sanimationController.view,
                              )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// textfromfield custom class
class textFromField extends StatelessWidget {
  bool password;
  String email;
  IconData icon;
  TextInputType inputType;
  Function(String value) onChanged;
  String Function(String value) validator;
  textFromField(
      {this.email,
      this.icon,
      this.inputType,
      this.password,
      this.onChanged,
      this.validator});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 30.0),
      child: Container(
        height: 60.0,
        alignment: AlignmentDirectional.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14.0),
            color: Colors.white,
            boxShadow: [BoxShadow(blurRadius: 10.0, color: Colors.black12)]),
        padding:
            EdgeInsets.only(left: 20.0, right: 30.0, top: 0.0, bottom: 0.0),
        child: Theme(
          data: ThemeData(
            hintColor: Colors.transparent,
          ),
          child: TextFormField(
            validator: validator,
            onChanged: onChanged,
            obscureText: password,
            decoration: InputDecoration(
                border: InputBorder.none,
                labelText: email,
                icon: Icon(
                  icon,
                  color: Colors.black38,
                ),
                labelStyle: TextStyle(
                    fontSize: 15.0,
                    fontFamily: 'Sans',
                    letterSpacing: 0.3,
                    color: Colors.black38,
                    fontWeight: FontWeight.w600)),
            keyboardType: inputType,
          ),
        ),
      ),
    );
  }
}

///ButtonBlack class
class buttonBlackBottom extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(30.0),
      child: Container(
        height: 55.0,
        width: 600.0,
        child: Text(
          AppLocalizations.of(context).tr('signUp'),
          style: TextStyle(
              color: Colors.white,
              letterSpacing: 0.2,
              fontFamily: "Sans",
              fontSize: 18.0,
              fontWeight: FontWeight.w800),
        ),
        alignment: FractionalOffset.center,
        decoration: BoxDecoration(
            boxShadow: [BoxShadow(color: Colors.black38, blurRadius: 15.0)],
            borderRadius: BorderRadius.circular(30.0),
            gradient: LinearGradient(
                colors: <Color>[Color(0xFF121940), Color(0xFF6E48AA)])),
      ),
    );
  }
}
