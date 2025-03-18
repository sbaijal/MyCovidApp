import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mycovid/details.dart';
//import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:mycovid/myjson.dart';
import 'package:mycovid/form.dart';
import 'package:dio/dio.dart';
import 'package:mycovid/mainpage.dart';
import 'cards.dart';
//void main() => runApp(dash(thi));

class dash extends StatelessWidget {
  final String cookie;
  final String doc_name;
  dash(this.cookie, this.doc_name);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.transparent,
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
                    builder: (context) => dashb(cookie, doc_name),
                  ),
                );
              },
            )),
        body: WillPopScope(
          onWillPop: () async {
            Navigator.pop(context, cookie);
            return false;
          },
          child: Stack(
            children: <Widget>[
              Positioned.fill(
                child: Container(
                    decoration: new BoxDecoration(
                  color: Colors.white,
                  image: DecorationImage(
                    colorFilter: new ColorFilter.mode(
                        Colors.black.withOpacity(0.4), BlendMode.dstATop),
                    image: AssetImage('assets/images/doc1.jpg'),
                    fit: BoxFit.fill,
                  ),
                )),
              ),
              ListSearch(cookie, doc_name),
            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: Container(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              FloatingActionButton(
                backgroundColor: Colors.teal[600],
                child: Icon(Icons.qr_code_2_rounded),
                onPressed: () {
                  print("Clicked");
                },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(16))),
                elevation: 5,
                highlightElevation: 10,
              ),
              SizedBox(
                width: 20,
                height: 10,
              ),
              FloatingActionButton(
                backgroundColor: Colors.teal[600],
                child: Icon(Icons.add_box),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FormScreen(cookie, doc_name),
                    ),
                  );
                },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(16))),
                elevation: 5,
                highlightElevation: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ListSearch extends StatefulWidget {
  final String cookie;
  final String doc_name;
  ListSearch(this.cookie, this.doc_name);
  ListSearchState createState() => ListSearchState();
}

class ListSearchState extends State<ListSearch> {
  TextEditingController _textController = TextEditingController();

  List<myjson> myALLDATA = [];
  List<myjson> mycopy = [];
  static List<String> mainDataList = [];

  Dio dio = new Dio();

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
    for (var data in response.data["data"]) {
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
  void initState() {
    super.initState();
    getUsers();
  }

  onItemChanged(String value) {
    setState(() {
      mycopy = myALLDATA
          .where((row) => (row.FirstName + " " + row.LastName)
              .toLowerCase()
              .contains(value.toLowerCase()))
          .toList();
    });
    //newDataList.forEach((element) => print(element));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              controller: _textController,
              decoration: InputDecoration(
                hintText: 'Search by name or IPD',
                // hintStyle: TextStyle( color: Colors.white),
              ),
              onChanged: onItemChanged,
            ),
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.all(12.0),
              children: mycopy.map((data) {
                return ListTile(
                    title: Text(data.FirstName + " " + data.LastName),
                    onTap: () => {
                          print(data),
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  cards(widget.cookie, data, widget.doc_name),
                            ),
                          )
                        });
              }).toList(),
            ),
          )
        ],
      ),
    );
  }
}
