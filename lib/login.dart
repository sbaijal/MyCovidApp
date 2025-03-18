import 'dart:collection';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mycovid/mainpage.dart';
//import 'package:mycovid/mynumber.dart';
import 'package:mycovid/otp.dart';
import 'dart:convert';
import 'package:dio/dio.dart';
//import 'package:mycovid/mynumber.dart';
//import 'package:mycovid/api_provider.dart';

class LoginScreen extends StatefulWidget {
  @override
  _MyState createState() => _MyState();
}

class _MyState extends State<LoginScreen> {
  // WELCOME and login page
  TextEditingController passController = new TextEditingController();
  String cookie;
  String status = "success";
  String hash;

  //List<mynumber> mylogin = [];
  //var list = new List(3);

  Dio dio = new Dio();

  Future postNum() async {
    final String Url = 'https://my-covid-hospital-api.herokuapp.com/login';

    dynamic num = {"phone": int.parse(passController.text)};
    var response = await dio.post(Url,
        data: num,
        options: Options(
          headers: {'content-type': 'application/json; charset=UTF-8'},
        ));
    /*mylogin.add(new mynumber(response.data["status"], response.data["message"],
        response.data["data"]["hash"], passController.text));
    print(mylogin);*/
    status = response.data["status"];
    if (status == "success") {
      hash = response.data["data"]["hash"];
    }

    print(response.headers);
    //print(response.data.toString().substring(9, 16));
    //status = response.data.toString().substring(9, 16);
    print(response.headers.map['set-cookie'][0].split(';')[0].substring(12));
    cookie = response.headers.map['Set-Cookie'][0].split(';')[0].substring(12);
    return response.data;
  }

  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
          image: AssetImage('assets/images/doc.jpg'),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(Colors.black87, BlendMode.darken),
        )),
        child: Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(10),
              ),
              Container(
                child: CircleAvatar(
                  child: Text(
                    '+',
                    style: TextStyle(
                      fontSize: 38,
                      color: Colors.white,
                    ),
                  ),
                  radius: 30,
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10),
              ),
              Text(
                'MYCOVID APP',
                style: TextStyle(
                  fontSize: 30.0,
                  // fontFamily: 'Lobster',
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 20.0,
                width: 150.0,
                child: Divider(
                  color: Colors.teal.shade100,
                ),
              ),
              Text(
                'WELCOME',
                style: TextStyle(
                  color: Colors.teal.shade100,
                  fontSize: 15.0,
                  letterSpacing: 2.5,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 20.0,
                width: 150.0,
                child: Divider(
                  color: Colors.teal.shade100,
                ),
              ),
              /*Card(
                margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 20.0),
                child: ListTile(
                  leading: Icon(
                    Icons.healing,
                    color: Colors.teal,
                  ),
                  title: Text(
                    'hospitalemail@gmail.com',
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.teal.shade900,
                    ),
                  ),
                ),
              ),*/
              Container(
                  padding: const EdgeInsets.all(30.0),
                  child: Form(
                    child: Theme(
                      data: ThemeData(
                        brightness: Brightness.dark,
                        primarySwatch: Colors.teal,
                      ),
                      child: Form(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            TextFormField(
                              controller: passController,
                              decoration: InputDecoration(
                                labelText: "Enter Your Mobile Number",
                                //errorText: error_text_message()
                                //? "number not registered"
                                //: null,
                              ),
                              // obscureText: true,
                              keyboardType: TextInputType.phone,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 10.0),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )),
              MaterialButton(
                color: Colors.teal,
                textColor: Colors.white,
                child: Text('Get OTP'),
                onPressed: () async {
                  //error_text(passController.text);
                  //print(status);
                  if ((passController.text).length != 10) {
                    print('object is not 10................');
                    //showAlertDialog(context);
                  } else {
                    await postNum();
                    //print(status);
                    //print("soham"),
                    if (status == "success") {
                      showAlertDialog(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              OTPScreen(status, hash, passController.text),
                        ),
                      );
                    } else {
                      //passController.text = "invalid number";
                      showAlertDialog(context);
                    }
                  }
                },
                splashColor: Colors.tealAccent,
              ),
            ],
          ),
        ),
      ),
    );
  }

  showAlertDialog(BuildContext context) {
    // set up the AlertDialog
    if (status == "success") {
      AlertDialog alert = AlertDialog(
        title: Text(
          "Verify OTP",
          style: TextStyle(
            color: Colors.red,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Icon(Icons.check_circle_outline),
        actions: [],
      );

      // show the dialog
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        },
      );
    } else {
      AlertDialog alert = AlertDialog(
        title: Text(
          "Not a Registered Number",
          style: TextStyle(
            color: Colors.red,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Icon(Icons.check_circle_outline),
        actions: [],
      );

      // show the dialog
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        },
      );
    }
  }
}
