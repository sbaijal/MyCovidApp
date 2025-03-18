import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'mainpage.dart';
import 'dashboard.dart';

//import 'package:firebase_auth/firebase_auth.dart';
import 'package:pinput/pin_put/pin_put.dart';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:mycovid/myotp.dart';

class OTPScreen extends StatefulWidget {
  // OTP page
  final String phone;
  final String status;
  final String hash;

  OTPScreen(this.status, this.hash, this.phone);
  @override
  _OTPScreenState createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  //TextEditingController passContro = new TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();
  String otp_status;
  String cookie;
  String doc_name;
  List<myotp> myDOCDATA = [];

  Dio dio = new Dio();

  Future postOtp() async {
    final String Url = 'https://my-covid-hospital-api.herokuapp.com/verify';
    //Cookie("connect.sid", widget.cookie);

    dynamic otp = {
      "phone": int.parse(widget.phone),
      "hash": widget.hash,
      "otp": int.parse(_pinPutController.text)
    };
    var response = await dio.post(Url,
        data: otp,
        options: Options(
          headers: {
            'content-type': 'application/json; charset=UTF-8',
          },
        ));
    print(response.headers);
    cookie = response.headers.map['set-cookie'][0].split(';')[0].substring(12);
    print(response.data);
    otp_status = response.data["status"];
    print(otp_status);
    for (var data in response.data["data"]) {
      myDOCDATA.add(new myotp(
        data['StaffId'],
        data['FirstName'],
        data['MiddleName'],
        data['LastName'],
        data['PhoneNumber'],
        data['Email'],
        data['Designation'],
        data['Admin'],
        data['WorkingStatus'],
      ));
    }
    myDOCDATA.map((e) {
      doc_name = e.FirstName;
    }).toString();
    print(doc_name);

    return response.data;
  }

  final TextEditingController _pinPutController = TextEditingController();
  final FocusNode _pinPutFocusNode = FocusNode();
  final BoxDecoration pinPutDecoration = BoxDecoration(
    color: const Color.fromRGBO(43, 46, 66, 1),
    borderRadius: BorderRadius.circular(10.0),
    border: Border.all(
      color: const Color.fromRGBO(126, 203, 224, 1),
    ),
  );

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
          image: AssetImage('assets/images/doc.jpg'),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(Colors.black87, BlendMode.darken),
        )),
        width: double.infinity,
        height: double.infinity,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.only(top: 20, bottom: 20),
                child: Text("Welcome Doctor",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      letterSpacing: 2,
                      fontWeight: FontWeight.bold,
                    )),
              ),
              Container(
                margin: EdgeInsets.only(top: 20, bottom: 20),
                child: Text("Enter Your OTP",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      letterSpacing: 2,
                      fontWeight: FontWeight.bold,
                    )),
              ),
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: PinPut(
                  fieldsCount: 6,
                  textStyle:
                      const TextStyle(fontSize: 25.0, color: Colors.white),
                  eachFieldWidth: 40.0,
                  eachFieldHeight: 55.0,
                  focusNode: _pinPutFocusNode,
                  controller: _pinPutController,
                  submittedFieldDecoration: pinPutDecoration,
                  selectedFieldDecoration: pinPutDecoration,
                  followingFieldDecoration: pinPutDecoration,
                  pinAnimationType: PinAnimationType.fade,
                  onSubmit: (pin) async {
                    await postOtp();
                    if (otp_status == "success") {
                      showAlertDialog(context);
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => dashb(cookie, doc_name)),
                          (route) => false);
                    } else {
                      showAlertDialog(context);
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  showAlertDialog(BuildContext context) {
    // set up the AlertDialog
    if (otp_status == "success") {
      AlertDialog alert = AlertDialog(
        title: Text(
          "Welcome Doctor",
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
          "Wrong OTP",
          style: TextStyle(
            color: Colors.red,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Icon(Icons.block_rounded),
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

  /*_verifyPhone() async {
    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: '+91${widget.phone}',
        verificationCompleted: (PhoneAuthCredential credential) async {
          await FirebaseAuth.instance
              .signInWithCredential(credential)
              .then((value) async {
            if (value.user != null) {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => dashb()),
                  (route) => false);
            }
          });
        },
        verificationFailed: (FirebaseAuthException e) {
          print(e.message);
        },
        codeSent: (String verficationID, int resendToken) {
          setState(() {
            _verificationCode = verficationID;
          });
        },
        codeAutoRetrievalTimeout: (String verificationID) {
          setState(() {
            _verificationCode = verificationID;
          });
        },
        timeout: Duration(seconds: 120));
  }*/

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //_verifyPhone();
  }
}
