import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:mycovid/dashboard.dart';

import 'last_detail.dart';
import 'details.dart';
import 'package:mycovid/wards.dart';
import 'package:mycovid/myjson.dart';

class cards extends StatefulWidget {
  final String cookie;
  final String doc_name;
  cards(this.cookie, this.myData, this.doc_name);
  myjson myData;
  @override
  _HomePageState createState() => _HomePageState(cookie);
}

class _HomePageState extends State<cards> {
  final String cookie;
  _HomePageState(this.cookie);
  final dio = new Dio(); // for http requests
  List<myjson> myALLDATA = [];
  List<myjson> mycopy = [];
  var data;
  static List<String> mainDataList = [];
  getUsers() async {
    //Cookie("connect.sid", widget.cookie);
    final String Url =
        "https://my-covid-hospital-api.herokuapp.com/patients/view";
    var response = await dio.get(Url,
        options: Options(
          headers: {
            'content-type': 'application/json; charset=UTF-8',
            'Cookie': "connect.sid=" + widget.cookie,
          },
        ));
    print(widget.cookie);
    print(response.data);
    print(response.data["data"].runtimeType);
    //debugPrint(response.body);
    //var jsonBody = jsonDecode(response.data);

    for (data in response.data["data"]) {
      myALLDATA.add(new myjson(
          data['FirstName'],
          data['MiddleName'],
          data['LastName'],
          data['RelativeName'],
          data['Relationship'],
          data['AdmissionDatetime'],
          data['PhoneNumber'],
          data['RelativePhoneNumber'],
          data['PatientId']));
    }
    setState(() {
      //patientData = data['patients'];
    });

    myALLDATA.forEach((someData) => mycopy.add(someData));
    //newDataList.forEach((element) => print(element));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[200],
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
                  builder: (context) => dash(cookie, widget.doc_name),
                ),
              );
            },
          )),
      body: ListView(
        scrollDirection: Axis.vertical,
        children: <Widget>[
          Container(
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                  color: Colors.blueGrey[500],
                ),
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 10, 20, 4),
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
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
                            ),
                          ),
                        ),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            border:
                                Border.all(width: 1.0, color: Colors.white)),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 3, 20, 10),
                      child: Container(
                        height: 45,
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(15, 5, 0, 5),
                            child: Text(
                              "ipd nnumber",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
                            ),
                          ),
                        ),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            border:
                                Border.all(width: 1.0, color: Colors.white70)),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 3, 20, 10),
                      child: Container(
                        height: 45,
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(15, 5, 0, 5),
                            child: Text(
                              "widget.myData.AdmissionDatetime",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
                            ),
                          ),
                        ),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            border:
                                Border.all(width: 1.0, color: Colors.white70)),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 3, 20, 10),
                      child: Container(
                        height: 45,
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(15, 5, 0, 5),
                            child: Text(
                              widget.myData.PhoneNumber.toString(),
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
                            ),
                          ),
                        ),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            border:
                                Border.all(width: 1.0, color: Colors.white70)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              child: new FittedBox(
                child: Material(
                  color: Colors.grey[200],
                  elevation: 14.0,
                  borderRadius: BorderRadius.circular(24.0),
                  shadowColor: Color(0x802196F3),
                  child: new InkWell(
                    onTap: () {
                      print("tapped");
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                det(cookie, widget.myData, widget.doc_name)),
                      );
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 16.0),
                            child: myDetailsContainer1(),
                          ),
                        ),
                        Container(
                          width: 250,
                          height: 130,
                          child: ClipRRect(
                            borderRadius: new BorderRadius.circular(24.0),
                            child: Image(
                              fit: BoxFit.contain,
                              alignment: Alignment.topRight,
                              image: AssetImage("assets/images/update.jpg"),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              child: new FittedBox(
                child: Material(
                  color: Colors.grey[200],
                  elevation: 14.0,
                  borderRadius: BorderRadius.circular(24.0),
                  shadowColor: Color(0x802196F3),
                  child: new InkWell(
                    onTap: () {
                      print("tapped");
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MyHomePage(
                                widget.cookie, widget.myData, widget.doc_name)),
                      );
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 16.0),
                            child: myDetailsContainer2(),
                          ),
                        ),
                        Container(
                          width: 250,
                          height: 130,
                          child: ClipRRect(
                            borderRadius: new BorderRadius.circular(24.0),
                            child: Image(
                              fit: BoxFit.contain,
                              alignment: Alignment.topRight,
                              image: AssetImage("assets/images/details.png"),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget myDetailsContainer1() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Container(
              child: Text(
            "Last update",
            style: TextStyle(
                color: Colors.cyan[800],
                fontSize: 24.0,
                fontWeight: FontWeight.bold),
          )),
        ),
        Container(
            child: Text(
          "tap to view last history",
          style: TextStyle(
              color: Colors.black54,
              fontSize: 18.0,
              fontWeight: FontWeight.bold),
        )),
      ],
    );
  }

  Widget myDetailsContainer2() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Container(
              child: Text(
            "Update Details",
            style: TextStyle(
                color: Colors.cyan[800],
                fontSize: 24.0,
                fontWeight: FontWeight.bold),
          )),
        ),
        Container(
            child: Text(
          "tap to update patient details ",
          style: TextStyle(
            color: Colors.black54,
            fontSize: 18.0,
          ),
        )),
      ],
    );
  }
}
