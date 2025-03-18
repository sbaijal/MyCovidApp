import 'dart:io';

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:mycovid/dashboard.dart';
import 'package:mycovid/mainpage.dart';
import 'package:dropdownfield/dropdownfield.dart';

//void main() => runApp(FormScreen());

class FormScreend extends StatefulWidget {
  final String cookie;
  final String doc_name;
  FormScreend(this.cookie, this.doc_name);
  @override
  State<StatefulWidget> createState() {
    return FormScreendState();
  }
}

class FormScreendState extends State<FormScreend> {
  String status;
  String _name;
  String _namem;
  String _namel;
  String _email;
  String _phoneNumber;
  String _des;
  bool _admin = false;
  // final bool tristate=true;

  Dio dio = new Dio();

  Future postData() async {
    final String Url =
        'https://my-covid-hospital-api.herokuapp.com/admin/newStaff';

    dynamic data = {
      "FirstName": _name,
      "MiddleName": _namem,
      "LastName": _namel,
      "PhoneNumber": _phoneNumber,
      "Email": _email,
      "Designation": _des,
      "Admin": _admin,
    };

    var response = await dio.post(Url,
        data: data,
        options: Options(
          headers: {
            'content-type': 'application/json; charset=UTF-8',
            'Cookie': "connect.sid=" + widget.cookie,
          },
        ));
    status = response.data["status"];
    print(response.data);
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
        if (value.isEmpty) {
          return 'Name is Required';
        }
        return null;
      },
      onSaved: (String value) {
        _namel = value;
      },
    );
  }

  Widget _buildEmail() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Email'),
      validator: (String value) {
        // if (value.isEmpty) {
        //   return 'Email is Required';
        // }

        if (!RegExp(
                r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
            .hasMatch(value)) {
          return 'Please enter a valid email Address';
        }
        return null;
      },
      onSaved: (String value) {
        _email = value;
      },
    );
  }

  /*Widget _buildIPD() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'IPD number'),
      keyboardType: TextInputType.visiblePassword,
      validator: (String value) {
        if (value.isEmpty) {
          return 'number is Required';
        }
        return null;
      },
      onSaved: (String value) {
        _ipd = value;
      },
    );
  }*/

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

  String desig;
  List<String> des = [
    "Intern",
    "Resident 1",
    "Resident 2",
    "Resident 3",
  ];

  Widget _desig() {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          DropDownField(
            onValueChanged: (dynamic value) {
              desig = value;
            },
            value: desig,
            required: false,
            strict: true,
            hintText: 'Choose a designation',
            items: des,
          ),
        ]);
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
                _buildName(),
                _buildNamem(),
                _buildNamel(),
                _buildPhoneNumber(),
                _buildEmail(),
                SizedBox(height: 40),
                _desig(),
                SizedBox(height: 5),
                CheckboxListTile(
                  controlAffinity: ListTileControlAffinity.leading,
                  title: Text('Add as Admin'),
                  value: _admin,
                  onChanged: (value) {
                    setState(() {
                      _admin = value;
                    });
                  },
                ),
                SizedBox(height: 30),
                RaisedButton(
                  child: Text(
                    'Submit',
                    style: TextStyle(color: Colors.blue, fontSize: 16),
                  ),
                  onPressed: () async {
                    _formKey.currentState.save();
                    if (!_formKey.currentState.validate()) {
                      return;
                    } else {
                      await postData();
                      if (status == "success") {
                        showAlertDialog(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                dashb(widget.cookie, widget.doc_name),
                          ),
                        );
                      } else {
                        showAlertDialog(context);
                      }
                    }

                    print(_name);
                    print(_namem);
                    print(_namel);

                    print(_phoneNumber);
                    print(_email);
                    print(_des);
                  },
                ),
              ],
            ),
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
          "Details Updated",
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
          "You don't have admin rights",
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
