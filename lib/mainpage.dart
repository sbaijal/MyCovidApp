import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:mycovid/login.dart';
import 'dashboard.dart';
import 'form.dart';
import 'formd.dart';
import 'wards.dart';

class dashb extends StatefulWidget {
  final String cookie;
  final String doc_name;
  dashb(this.cookie, this.doc_name);
  @override
  _HomePageState createState() => _HomePageState(cookie);
}

class _HomePageState extends State<dashb> {
  final dio = new Dio(); // for http requests

  Icon _searchIcon = new Icon(Icons.search);
  final String cookie;
  _HomePageState(this.cookie);
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
                  builder: (context) => LoginScreen(),
                ),
              );
            },
          )),
      body: ListView(
        scrollDirection: Axis.vertical,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  // make children widget for better styling here..
                  "Welcome, Dr. ${widget.doc_name} ",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.grey[900],
                      fontSize: 28.0,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  "    Select an option ",
                  style: TextStyle(
                      color: Colors.grey[700],
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ],
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
                        //  print("tapped");
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  dash(cookie, widget.doc_name)),
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
                            height: 150,
                            child: ClipRRect(
                              borderRadius: new BorderRadius.circular(24.0),
                              child: Image(
                                fit: BoxFit.contain,
                                alignment: Alignment.topRight,
                                image: AssetImage("assets/images/list.png"),
                              ),
                            ),
                          ),
                        ],
                      )),
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
                        //  print("tapped");
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  FormScreen(cookie, widget.doc_name)),
                        );
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 16.0),
                              child: myDetailsContainer4(),
                            ),
                          ),
                          Container(
                            width: 250,
                            height: 150,
                            child: ClipRRect(
                              borderRadius: new BorderRadius.circular(24.0),
                              child: Image(
                                fit: BoxFit.contain,
                                alignment: Alignment.topRight,
                                image: AssetImage("assets/images/patient.png"),
                              ),
                            ),
                          ),
                        ],
                      )),
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
                        //  print("tapped");
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  wards(cookie, widget.doc_name)),
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
                            height: 150,
                            child: ClipRRect(
                              borderRadius: new BorderRadius.circular(24.0),
                              child: Image(
                                fit: BoxFit.contain,
                                alignment: Alignment.topRight,
                                image: AssetImage("assets/images/ward.png"),
                              ),
                            ),
                          ),
                        ],
                      )),
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
                        //  print("tapped");
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  FormScreend(cookie, widget.doc_name)),
                        );
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 16.0),
                              child: myDetailsContainer3(),
                            ),
                          ),
                          Container(
                            width: 250,
                            height: 150,
                            child: ClipRRect(
                              borderRadius: new BorderRadius.circular(24.0),
                              child: Image(
                                fit: BoxFit.contain,
                                alignment: Alignment.topRight,
                                image: AssetImage("assets/images/adddoc.png"),
                              ),
                            ),
                          ),
                        ],
                      )),
                ),
              ),
            ),
          ),

          // Padding(
          //   padding: const EdgeInsets.all(16.0),
          //   child: Container(
          //     child: new FittedBox(
          //       child: Material(
          //           color: Colors.grey[200],
          //           elevation: 14.0,
          //           borderRadius: BorderRadius.circular(24.0),
          //           shadowColor: Color(0x802196F3),
          //           child: Row(
          //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //             children: <Widget>[
          //               Container(
          //                 child: Padding(
          //                   padding: const EdgeInsets.only(left: 16.0),
          //                   child: myDetailsContainer5(),
          //                 ),
          //               ),
          //               Container(
          //                 width: 250,
          //                 height: 150,
          //                 child: ClipRRect(
          //                   borderRadius: new BorderRadius.circular(24.0),
          //                   child: Image(
          //                     fit: BoxFit.contain,
          //                     alignment: Alignment.topRight,
          //                     image: AssetImage("assets/images/qr.png"),
          //                   ),
          //                 ),
          //               ),
          //             ],
          //           )),
          //     ),
          //   ),
          // ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              child: new FittedBox(
                child: Material(
                    color: Colors.grey[200],
                    elevation: 14.0,
                    borderRadius: BorderRadius.circular(24.0),
                    shadowColor: Color(0x802196F3),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 16.0),
                            child: myDetailsContainer6(),
                          ),
                        ),
                        Container(
                          width: 250,
                          height: 150,
                          child: ClipRRect(
                            borderRadius: new BorderRadius.circular(24.0),
                            child: Image(
                              fit: BoxFit.contain,
                              alignment: Alignment.topRight,
                              image: AssetImage("assets/images/logout.png"),
                            ),
                          ),
                        ),
                      ],
                    )),
              ),
            ),
          ),
        ],
      ),
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
            "Covid Rounds",
            style: TextStyle(
                color: Colors.cyan[800],
                fontSize: 24.0,
                fontWeight: FontWeight.bold),
          )),
        ),
        Container(
            child: Text(
          "tap to view and add patients",
          style: TextStyle(
            color: Colors.black54,
            fontSize: 18.0,
          ),
        )),
      ],
    );
  }

  Widget myDetailsContainer4() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Container(
              child: Text(
            "Add Patients",
            style: TextStyle(
                color: Colors.cyan[800],
                fontSize: 24.0,
                fontWeight: FontWeight.bold),
          )),
        ),
        Container(
            child: Text(
          "Add patient details",
          style: TextStyle(
            color: Colors.black54,
            fontSize: 18.0,
          ),
        )),
      ],
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
            "Ward List",
            style: TextStyle(
                color: Colors.cyan[800],
                fontSize: 24.0,
                fontWeight: FontWeight.bold),
          )),
        ),
        Container(
            child: Text(
          "Tap to view the status",
          style: TextStyle(
              color: Colors.black54,
              fontSize: 18.0,
              fontWeight: FontWeight.bold),
        )),
      ],
    );
  }

  Widget myDetailsContainer3() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Container(
              child: Text(
            "Add doctor",
            style: TextStyle(
                color: Colors.cyan[800],
                fontSize: 24.0,
                fontWeight: FontWeight.bold),
          )),
        ),
        Container(
            child: Text(
          "To be added by admins only",
          style: TextStyle(
            color: Colors.black54,
            fontSize: 18.0,
          ),
        )),
      ],
    );
  }

  // Widget myDetailsContainer5() {
  //   return Column(
  //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //     children: <Widget>[
  //       Padding(
  //         padding: const EdgeInsets.only(left: 8.0),

  //           child: Container(
  //               child: Text(
  //             "Scan QR",
  //             style: TextStyle(
  //                 color: Colors.cyan[800],
  //                 fontSize: 24.0,
  //                 fontWeight: FontWeight.bold),
  //           )),
  //         ),

  //       Container(
  //           child: Text(
  //         "Tap to scan QR code",
  //         style: TextStyle(
  //           color: Colors.black54,
  //           fontSize: 18.0,
  //         ),
  //       )),
  //     ],
  //   );
  // }

  Widget myDetailsContainer6() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Container(
              child: Text(
            "Logout",
            style: TextStyle(
                color: Colors.cyan[800],
                fontSize: 24.0,
                fontWeight: FontWeight.bold),
          )),
        ),
        Container(
            child: Text(
          "Tap to logout and exit App",
          style: TextStyle(
            color: Colors.black54,
            fontSize: 18.0,
          ),
        )),
      ],
    );
  }

  Widget _buildBar(BuildContext context) {
    return new AppBar(
      centerTitle: true,
      backgroundColor: Colors.teal,
      title: Text("MyCovid App"),
    );
  }
}
