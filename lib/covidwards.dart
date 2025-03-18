import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:mycovid/ward5.dart';
import 'ward5.dart';
import 'ward15.dart';
import 'ward25.dart';
import 'package:mycovid/wards.dart';

class covidwards extends StatefulWidget {
  final String cookie;
  final String doc_name;
  covidwards(this.cookie, this.doc_name);
  @override
  _HomePageState createState() => _HomePageState(cookie);
}

class _HomePageState extends State<covidwards> {
  final String cookie;
  _HomePageState(this.cookie);
  final dio = new Dio(); // for http requests
  Widget _appBarTitle = new Text('Search...');
  Icon _searchIcon = new Icon(Icons.search);

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
                  builder: (context) => wards(cookie, widget.doc_name),
                ),
              );
            },
          )),
      body: ListView(
        scrollDirection: Axis.vertical,
        children: <Widget>[
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
                                war5(cookie, widget.doc_name)),
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
                                image: AssetImage("assets/images/ward.png"),
                              )),
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
                            builder: (context) =>
                                war15(cookie, widget.doc_name)),
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
                          height: 130,
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
                            builder: (context) =>
                                war25(cookie, widget.doc_name)),
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
                          height: 130,
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
            "Ward 5",
            style: TextStyle(
                color: Colors.cyan[800],
                fontSize: 24.0,
                fontWeight: FontWeight.bold),
          )),
        ),
        Container(
            child: Text(
          "13 patients",
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
            "Ward 25",
            style: TextStyle(
                color: Colors.cyan[800],
                fontSize: 24.0,
                fontWeight: FontWeight.bold),
          )),
        ),
        Container(
            child: Text(
          "15 Patients",
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
            "Ward 15",
            style: TextStyle(
                color: Colors.cyan[800],
                fontSize: 24.0,
                fontWeight: FontWeight.bold),
          )),
        ),
        Container(
            child: Text(
          "9 Patients",
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
      title: _appBarTitle,
      leading: new IconButton(
        icon: _searchIcon,
        onPressed: _searchPressed,
      ),
    );
  }

  void _searchPressed() {
    setState(() {
      if (this._searchIcon.icon == Icons.search) {
        this._searchIcon = new Icon(Icons.close);
        this._appBarTitle = new TextField(
          decoration: new InputDecoration(
              prefixIcon: new Icon(Icons.search), hintText: 'Search...'),
        );
      } else {
        this._searchIcon = new Icon(Icons.search);
        this._appBarTitle = new Text('Search Example');
      }
    });
  }
}
