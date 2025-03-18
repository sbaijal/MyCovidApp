import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:mycovid/cards.dart';
import 'package:mycovid/myjson.dart';
import 'package:dio/dio.dart';
import 'package:mycovid/dashboard.dart';
import 'package:mycovid/mainpage.dart';
import 'package:mycovid/myvitals.dart';

class det extends StatefulWidget {
  final String cookie;
  final String doc_name;
  det(this.cookie, this.myData, this.doc_name);
  myjson myData;
  // MyHomePage({Key key, this.myData}) : super(key: key);
  //MyHomePage(this.myData);

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<det> {
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

  int spo2;
  int bp_sys;
  int bp_dia;
  int res_cycle;
  int pul_rate;
  int o2;
  int temp;
  String Statusdatetime;
  String date;
  String Time;
  String vital_status;

  Dio dio = new Dio();

  List<myvitals> myLASTVITALS = [];

  getVitals() async {
    //Cookie("connect.sid", widget.cookie);
    final String Url =
        "https://my-covid-hospital-api.herokuapp.com/patients/viewVitals/" +
            "${widget.myData.PatientId}";
    var response = await dio.get(Url,
        options: Options(
          headers: {
            'content-type': 'application/json; charset=UTF-8',
            'Cookie': "connect.sid=" + widget.cookie,
          },
        ));
    print(widget.cookie);
    print(response.data);
    print(response.data["data"]);
    //debugPrint(response.body);
    //var jsonBody = jsonDecode(response.data);
    for (var data in response.data["data"]) {
      myLASTVITALS.add(new myvitals(
          data['StaffName'],
          data['PatientId'],
          data['NurseId'],
          data['DoctorId'],
          data['StatusDatetime'],
          data['PulseRate'],
          data['RespiratoryRate'],
          data['BpSystolic'],
          data['BpDiastolic'],
          data['SpO2'],
          data['O2'],
          data['Temperature'],
          data['Remarks']));
    }
    myLASTVITALS.map((e) {
      spo2 = e.SpO2;
      bp_sys = e.BpSystolic;
      bp_dia = e.BpDiastolic;
      res_cycle = e.RespiratoryRate;
      pul_rate = e.PulseRate;
      o2 = e.O2;
      temp = e.Temperature;
      Statusdatetime = e.StatusDatetime;
    }).toString();
    date = Statusdatetime.substring(0, 10);
    Time = Statusdatetime.substring(11);
    print(date);
    setState(() {
      //patientData = data['patients'];
    });
  }

  Widget profileView(String cookie) {
    return Column(
      children: <Widget>[
        Expanded(
            child: Container(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 10,
              ),
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
              SizedBox(
                height: 10,
              ),
              Container(
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                      color: Colors.blueGrey[500],
                    ),
                    child: Column(
                      children: <Widget>[
                        ExpansionTile(
                          title: Text(
                            '\nLast Updated on -  $date \n\nat time - $Time  \n\n\nPulse Rate (BPM) - $pul_rate \n\nSpO\u2082 (%) - $spo2 \n',
                            style: TextStyle(color: Colors.white),
                          ),
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.fromLTRB(10, 3, 10, 4),
                              child: Container(
                                height: 45,
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(5, 5, 0, 0),
                                    child: Text(
                                      'O\u2082 (Litres) - $o2',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 17),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(10, 3, 10, 4),
                              child: Container(
                                height: 45,
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(5, 5, 0, 0),
                                    child: Text(
                                      'SBP (mm Hg) - $bp_sys',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 17),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(10, 3, 10, 4),
                              child: Container(
                                height: 45,
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(5, 5, 0, 0),
                                    child: Text(
                                      'DBP (mm Hg)  - $bp_dia',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 17),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(10, 3, 10, 4),
                              child: Container(
                                height: 45,
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(5, 5, 0, 0),
                                    child: Text(
                                      'Resp. Rate (cycles) - $res_cycle',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 17),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(10, 3, 10, 4),
                              child: Container(
                                height: 45,
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(5, 5, 0, 5),
                                    child: Text(
                                      'Temperature - $temp   \n',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 17),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        )),
      ],
    );
  }
}
