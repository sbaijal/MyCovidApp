import 'dart:io';

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:mycovid/dashboard.dart';
import 'package:mycovid/mainpage.dart';

//void main() => runApp(FormScreen());

class FormScreen extends StatefulWidget {
  final String cookie;
  final String doc_name;
  FormScreen(this.cookie, this.doc_name);
  @override
  State<StatefulWidget> createState() {
    return FormScreenState();
  }
}

class FormScreenState extends State<FormScreen> {
  String _name;
  String _namem;
  String _namel;
  String _rel;
  String _ipd;
  String _rname;
  String _phoneNumber;
  String _rno;
  String ward_id;

  Dio dio = new Dio();

  Future postData() async {
    final String Url =
        'https://my-covid-hospital-api.herokuapp.com/patients/newPatient';

    dynamic data = {
      "IPDNumber": int.parse(_ipd),
      "FirstName": _name,
      "MiddleName": _namem,
      "LastName": _namel,
      "PhoneNumber": _phoneNumber,
      "RelativeName": _rname,
      "RelativePhoneNumber": _rno,
      "Relationship": _rel,
      "AdmissionDateTime": "2021-06-25 21:52:00",
      "WardId": int.parse(ward_id)
    };

    var response = await dio.post(Url,
        data: data,
        options: Options(
          headers: {
            'content-type': 'application/json; charset=UTF-8',
            'Cookie': "connect.sid=" + widget.cookie,
          },
        ));
    print(response.statusCode);
    return response.data;
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Widget _buildName() {
    return TextFormField(
      decoration: InputDecoration(
          labelText: 'First Name',
          suffixText: '*',
          suffixStyle: TextStyle(
            fontSize: 25,
            color: Colors.red,
          )),
      validator: (String value) {
        if (value.isEmpty) {
          return 'Name is Required';
        }

        return null;
      },
      onSaved: (String value) {
        _name = value;
      },
    );
  }

  Widget _buildNamem() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Middle Name'),
      validator: (String value) {
        return null;
      },
      onSaved: (String value) {
        _namem = value;
      },
    );
  }

  Widget _buildNamel() {
    return TextFormField(
      decoration: InputDecoration(
          labelText: 'Last Name',
          suffixText: '*',
          suffixStyle: TextStyle(
            fontSize: 25,
            color: Colors.red,
          )),
      validator: (String value) {
        return null;
      },
      onSaved: (String value) {
        _namel = value;
      },
    );
  }

  Widget _builRelname() {
    return TextFormField(
      decoration: InputDecoration(
          labelText: "Relative's Name",
          suffixText: '*',
          suffixStyle: TextStyle(
            fontSize: 25,
            color: Colors.red,
          )),
      keyboardType: TextInputType.name,
      validator: (String value) {
        if (value.isEmpty) {
          return 'data is Required';
        }

        return null;
      },
      onSaved: (String value) {
        _rname = value;
      },
    );
  }

  Widget _buildPhoneNumber() {
    return TextFormField(
      decoration: InputDecoration(
          labelText: 'Phone number',
          suffixText: '*',
          suffixStyle: TextStyle(
            fontSize: 25,
            color: Colors.red,
          )),
      maxLength: 10,
      keyboardType: TextInputType.phone,
      validator: (String value) {
        if (value.isEmpty) {
          return 'Phone number is Required';
        }

        return null;
      },
      onSaved: (String value) {
        _phoneNumber = value;
      },
    );
  }

  Widget _buildRelphNo() {
    return TextFormField(
      decoration: InputDecoration(
          labelText: "Relative's phone number",
          suffixText: '*',
          suffixStyle: TextStyle(
            fontSize: 25,
            color: Colors.red,
          )),
      maxLength: 10,
      keyboardType: TextInputType.phone,
      validator: (String value) {
        if (value.isEmpty) {
          return 'Phone number is Required';
        }

        return null;
      },
      onSaved: (String value) {
        _rno = value;
      },
    );
  }

  Widget _buildRelre() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Relationship with relative'),
      validator: (String value) {
        if (value.isEmpty) {
          return 'data is Required';
        }

        return null;
      },
      onSaved: (String value) {
        _rel = value;
      },
    );
  }

  Widget _wardID() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Enter Ward Number',
      ),
      validator: (String value) {
        if (value.isEmpty) {
          return 'data is Required';
        }

        return null;
      },
      onSaved: (String value) {
        ward_id = value;
      },
    );
  }

  Widget _buildipd() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Enter IPD Number'),
      validator: (String value) {
        if (value.isEmpty) {
          return 'data is Required';
        }

        return null;
      },
      onSaved: (String value) {
        _ipd = value;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  builder: (context) => dashb(widget.cookie, widget.doc_name),
                ),
              );
            },
          )),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _buildipd(),
                _buildName(),
                _buildNamem(),
                _buildNamel(),
                _buildPhoneNumber(),
                _builRelname(),
                _buildRelphNo(),
                _buildRelre(),
                _wardID(),
                SizedBox(height: 100),
                RaisedButton(
                  child: Text(
                    'Next',
                    style: TextStyle(color: Colors.blue, fontSize: 16),
                  ),
                  onPressed: () async {
                    _formKey.currentState.save();
                    if (!_formKey.currentState.validate()) {
                      return;
                    } else {
                      showAlertDialog(context);
                      await postData();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              dash(widget.cookie, widget.doc_name),
                        ),
                      );
                    }

                    print(_name);
                    print(_namem);
                    print(_namel);
                    print(_ipd);
                    print(_phoneNumber);
                    print(_rname);
                    print(_rno);
                    print(_rel);
                  },
                )
              ],
            ),
          ),
        ),
      ),
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
