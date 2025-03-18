import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:mycovid/cards.dart';
import 'package:mycovid/myjson.dart';
import 'package:dio/dio.dart';
import 'package:mycovid/dashboard.dart';
import 'package:mycovid/mainpage.dart';

class MyHomePage extends StatefulWidget {
  final String cookie;
  final String doc_name;
  MyHomePage(this.cookie, this.myData, this.doc_name);
  myjson myData;
  // MyHomePage({Key key, this.myData}) : super(key: key);
  //MyHomePage(this.myData);

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            backgroundColor: Colors.grey[900],
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
                automaticallyImplyLeading: true,
                backgroundColor: Colors.teal,
                title: Text("MyCovid Doctor's App"),
                leading: BackButton(
                  //icon: Icon(Icons.Back),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => cards(
                            widget.cookie, widget.myData, widget.doc_name),
                      ),
                    );
                  },
                )),
            body: profileView(widget.cookie)));
  }

  String spo2;
  String bp_sys;
  String bp_dia;
  String res_cycle;
  String pul_rate;
  String o2;
  String temp;
  String vital_status;

  Dio dio = new Dio();

  Future postVitals() async {
    final String Url =
        'https://my-covid-hospital-api.herokuapp.com/patients/updateVitals/' +
            '${widget.myData.PatientId}';

    dynamic vitals = {
      "PulseRate": pul_rate,
      "RespiratoryRate": res_cycle,
      "BpSystolic": bp_sys,
      "BpDiastolic": bp_dia,
      "SpO2": spo2,
      "O2": o2,
      "Temperature": temp
    };
    var response = await dio.post(Url,
        data: vitals,
        options: Options(
          headers: {
            'content-type': 'application/json; charset=UTF-8',
            'Cookie': "connect.sid=" + widget.cookie
          },
        ));
    vital_status = response.data["status"];
    print(widget.myData.PatientId);
    print(response.data);
    return response.data;
  }

  Widget profileView(String cookie) {
    return Column(
      children: <Widget>[
        Expanded(
            child: Container(
          child: Column(
            children: <Widget>[
              Container(
                  child: Padding(
                padding: EdgeInsets.all(10),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                      gradient: LinearGradient(
                          begin: Alignment.topRight,
                          end: Alignment.bottomLeft,
                          colors: [Colors.grey[600], Colors.red[400]])),
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10, 10, 10, 4),
                        child: Container(
                          height: 45,
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(15, 5, 0, 5),
                              child: Text(
                                widget.myData.FirstName +
                                    " " +
                                    widget.myData.LastName,
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18),
                              ),
                            ),
                          ),
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                              border:
                                  Border.all(width: 1.0, color: Colors.white)),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10, 3, 10, 10),
                        child: Container(
                          height: 45,
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(15, 5, 0, 5),
                              child: Text(
                                "${widget.myData.PatientId}",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18),
                              ),
                            ),
                          ),
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                              border: Border.all(
                                  width: 1.0, color: Colors.white70)),
                        ),
                      ),
                    ],
                  ),
                ),
              )),

              Container(
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                        gradient: LinearGradient(
                            begin: Alignment.topRight,
                            end: Alignment.bottomLeft,
                            colors: [Colors.grey[600], Colors.black])),
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.fromLTRB(10, 10, 10, 4),
                          child: Container(
                            height: 45,
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(15, 5, 0, 5),
                                child: TextFormField(
                                  decoration: InputDecoration(
                                    labelText:
                                        '                       Pulse Rate (BPM)',
                                    labelStyle:
                                        TextStyle(color: Colors.white70),
                                    border: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                    enabledBorder: InputBorder.none,
                                    errorBorder: InputBorder.none,
                                    disabledBorder: InputBorder.none,
                                  ),
                                  style: TextStyle(color: Colors.white70),
                                  keyboardType: TextInputType.number,
                                  validator: (String value) {
                                    if (value.isEmpty) {
                                      return 'Pulse Rate (BPM) is required';
                                    }

                                    return null;
                                  },
                                  onSaved: (String value) {
                                    pul_rate = value;
                                  },
                                ),
                              ),
                            ),
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                                border: Border.all(
                                    width: 1.0, color: Colors.white70)),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(10, 3, 10, 4),
                          child: Container(
                            height: 45,
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(15, 5, 0, 5),
                                child: TextFormField(
                                  decoration: InputDecoration(
                                    labelText:
                                        '                       SpO\u2082 (%)',
                                    labelStyle:
                                        TextStyle(color: Colors.white70),
                                    border: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                    enabledBorder: InputBorder.none,
                                    errorBorder: InputBorder.none,
                                    disabledBorder: InputBorder.none,
                                  ),
                                  style: TextStyle(color: Colors.white70),
                                  keyboardType: TextInputType.number,
                                  validator: (String value) {
                                    if (value.isEmpty) {
                                      return ' SpO\u2082(%) is required';
                                    }

                                    return null;
                                  },
                                  onSaved: (String value) {
                                    spo2 = value;
                                  },
                                ),
                              ),
                            ),
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                                border: Border.all(
                                    width: 1.0, color: Colors.white70)),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(10, 3, 10, 4),
                          child: Container(
                            height: 45,
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(15, 5, 0, 5),
                                child: TextFormField(
                                  decoration: InputDecoration(
                                    labelText:
                                        '                       O\u2082 (litres)',
                                    labelStyle:
                                        TextStyle(color: Colors.white70),
                                    border: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                    enabledBorder: InputBorder.none,
                                    errorBorder: InputBorder.none,
                                    disabledBorder: InputBorder.none,
                                  ),
                                  style: TextStyle(color: Colors.white70),
                                  keyboardType: TextInputType.number,
                                  validator: (String value) {
                                    if (value.isEmpty) {
                                      return 'O\u2082 (litres) is required';
                                    }

                                    return null;
                                  },
                                  onSaved: (String value) {
                                    o2 = value;
                                  },
                                ),
                              ),
                            ),
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                                border: Border.all(
                                    width: 1.0, color: Colors.white70)),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(10, 3, 10, 4),
                          child: Container(
                            height: 45,
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(15, 5, 0, 5),
                                child: TextFormField(
                                  decoration: InputDecoration(
                                    labelText:
                                        '                       SBP(mm Hg)',
                                    labelStyle:
                                        TextStyle(color: Colors.white70),
                                    border: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                    enabledBorder: InputBorder.none,
                                    errorBorder: InputBorder.none,
                                    disabledBorder: InputBorder.none,
                                  ),
                                  style: TextStyle(color: Colors.white70),
                                  keyboardType: TextInputType.number,
                                  validator: (String value) {
                                    if (value.isEmpty) {
                                      return 'SBP(mm Hg) is required';
                                    }

                                    return null;
                                  },
                                  onSaved: (String value) {
                                    bp_sys = value;
                                  },
                                ),
                              ),
                            ),
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                                border: Border.all(
                                    width: 1.0, color: Colors.white70)),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(10, 3, 10, 4),
                          child: Container(
                            height: 45,
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(15, 5, 0, 5),
                                child: TextFormField(
                                  decoration: InputDecoration(
                                    labelText:
                                        '                       DBP(mm Hg)',
                                    labelStyle:
                                        TextStyle(color: Colors.white70),
                                    border: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                    enabledBorder: InputBorder.none,
                                    errorBorder: InputBorder.none,
                                    disabledBorder: InputBorder.none,
                                  ),
                                  style: TextStyle(color: Colors.white70),
                                  keyboardType: TextInputType.number,
                                  validator: (String value) {
                                    if (value.isEmpty) {
                                      return 'DBP(mm Hg) is required';
                                    }

                                    return null;
                                  },
                                  onSaved: (String value) {
                                    bp_dia = value;
                                  },
                                ),
                              ),
                            ),
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                                border: Border.all(
                                    width: 1.0, color: Colors.white70)),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(10, 3, 10, 4),
                          child: Container(
                            height: 45,
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(15, 5, 0, 5),
                                child: TextFormField(
                                  decoration: InputDecoration(
                                    labelText:
                                        '                       Resp. Rate (cycles)',
                                    fillColor: Colors.white,
                                    labelStyle:
                                        TextStyle(color: Colors.white70),
                                    border: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                    enabledBorder: InputBorder.none,
                                    errorBorder: InputBorder.none,
                                    disabledBorder: InputBorder.none,
                                  ),
                                  style: TextStyle(color: Colors.white70),
                                  keyboardType: TextInputType.number,
                                  validator: (String value) {
                                    if (value.isEmpty) {
                                      return 'Respiratory Rate (cycles) is required';
                                    }

                                    return null;
                                  },
                                  onSaved: (String value) {
                                    res_cycle = value;
                                  },
                                ),
                              ),
                            ),
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                                border: Border.all(
                                    width: 1.0, color: Colors.white70)),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(10, 3, 10, 10),
                          child: Container(
                            height: 45,
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(15, 5, 0, 5),
                                child: TextFormField(
                                  decoration: InputDecoration(
                                    labelText:
                                        '                       Temperature',
                                    labelStyle:
                                        TextStyle(color: Colors.white70),
                                    border: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                    enabledBorder: InputBorder.none,
                                    errorBorder: InputBorder.none,
                                    disabledBorder: InputBorder.none,
                                  ),
                                  style: TextStyle(color: Colors.white70),
                                  keyboardType: TextInputType.number,
                                  validator: (String value) {
                                    if (value.isEmpty) {
                                      return 'Temperature is required';
                                    }

                                    return null;
                                  },
                                  onSaved: (String value) {
                                    temp = value;
                                  },
                                ),
                              ),
                            ),
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                                border: Border.all(
                                    width: 1.0, color: Colors.white70)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.center,
                  child: MaterialButton(
                    color: Colors.teal,
                    textColor: Colors.white,
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: Container(
                      child: Text(
                        'Update Vitals',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    onPressed: () async {
                      await postVitals();
                      if (vital_status == "success") {
                        showAlertDialog(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => dash(cookie, widget.doc_name),
                          ),
                        );
                      }
                    },
                  ),
                ),
              ),
              // Container(
              //   padding: EdgeInsets.fromLTRB(5, 0, 5, 5),
              //   child: Align(
              //     alignment: Alignment.bottomCenter,
              //     child: Row(
              //       children: <Widget>[
              //         Expanded(
              //           child: Align(
              //             alignment: Alignment.bottomLeft,
              //             child: MaterialButton(
              //               shape: RoundedRectangleBorder(
              //                   // borderRadius: BorderRadius.circular(20.0),
              //                   ),
              //               color: Colors.teal,
              //               textColor: Colors.white,
              //               padding: EdgeInsets.fromLTRB(20, 3, 10, 3),
              //               child: Container(
              //                 child: Text(
              //                   'Consult Senior Doctor',
              //                   style: TextStyle(fontSize: 20),
              //                 ),
              //               ),
              //               onPressed: () => {},
              //             ),
              //           ),
              //         ),
              //         Expanded(
              //           child: Align(
              //             alignment: Alignment.bottomRight,
              //             child: MaterialButton(
              //               shape: RoundedRectangleBorder(
              //                   // borderRadius: BorderRadius.circular(20.0),
              //                   ),
              //               color: Colors.teal,
              //               textColor: Colors.white,
              //               padding: EdgeInsets.fromLTRB(20, 3, 10, 3),
              //               child: Container(
              //                 child: Align(
              //                   child: Text(
              //                     'Prompt To Relatives',
              //                     style: TextStyle(fontSize: 20),
              //                   ),
              //                 ),
              //               ),
              //               onPressed: () => {},
              //             ),
              //           ),
              //         ),
              //       ],
              //     ),
              //   ),
              // ),
            ],
          ),
        )),
      ],
    );
  }
}

showAlertDialog(BuildContext context) {
  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text(
      "       Details Submitted",
      style: TextStyle(
        color: Colors.green,
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
