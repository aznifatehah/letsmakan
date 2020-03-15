import 'package:flutter/material.dart';
import 'package:letsmakan/loginscreen.dart';
import 'package:http/http.dart' as http;
import 'package:toast/toast.dart';

void main() => runApp(RegisterScreen());

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  double screenHeight;
  bool _isChecked = false;
  String name, email, phone, password;
  String urlRegister = "http://asaboleh.com/letsmakan/php/register_user.php";
  TextEditingController _nameEditingController = new TextEditingController();
  TextEditingController _emailEditingController = new TextEditingController();
  TextEditingController _phoneEditingController = new TextEditingController();
  TextEditingController _passEditingController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: new ThemeData(
          primarySwatch: Colors.purple,
        ),
        title: 'Material App',
        home: Scaffold(
          
          backgroundColor: Colors.purple[200],
          resizeToAvoidBottomPadding: false,
          body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Card(
                  elevation: 10,
                  child: Container(
                    padding: EdgeInsets.fromLTRB(20, 20, 20, 40),
                    child: Column(
                      children: <Widget>[
                        Align(
                          alignment: Alignment.center,
                          child: Text(
                            "Register New Account",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 26,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        new TextFormField(
                            controller: _nameEditingController,
                            keyboardType: TextInputType.text,
                             validator: _validateName,
                          onSaved: (String val){
                              name = val;
                          },
                            decoration: InputDecoration(
                              labelText: 'Name',
                              icon: Icon(Icons.person,color: Colors.purple[200]),
                            )),
                        new TextFormField(
                            controller: _emailEditingController,
                            keyboardType: TextInputType.emailAddress,
                             validator: _validateEmail,
                           onSaved: (String val){
                              email = val;
                          },
                            decoration: InputDecoration(
                              labelText: 'Email',
                              icon: Icon(Icons.email, color: Colors.purple[200]),
                            )),
                            new TextFormField(
                            controller: _phoneEditingController,
                            keyboardType: TextInputType.phone,
                             validator: _validatePhone,
                           onSaved: (String val){
                              phone = val;
                          },
                            decoration: InputDecoration(
                              labelText: 'Phone',
                              icon: Icon(Icons.phone, color: Colors.purple[200]),           
                            )),
                            new TextFormField(
                          controller: _passEditingController,
                           validator: _validatePass,
                         onSaved: (String val){
                              password = val;
                          },
                          decoration: InputDecoration(
                            labelText: 'Password',
                            icon: Icon(Icons.lock, color: Colors.purple[200]),
                          ),
                          obscureText: true,
                        ), 
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Checkbox(
                              value: _isChecked,
                              onChanged: (bool value) {
                                _onChange(value);
                              },
                            ),
                            GestureDetector(
                              onTap: _showEULA,
                              child: Text('I Agree to Terms  ',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold)),
                            ),
                            MaterialButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5.0)),
                              minWidth: 115,
                              height: 50,
                              child: Text('Register'),
                              color: Colors.brown,
                              textColor: Colors.white,
                              elevation: 10,
                              onPressed: _userConfirmation,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text("Already register? ",
                                style: TextStyle(fontSize: 16.0)),
                            GestureDetector(
                              onTap: _loginScreen,
                              child: Text(
                                "Login",
                                style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ]),
        ));
  }

void _userConfirmation() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Confirmation"),
          content: new Container(
            height: 20,
            child: Column(
              children: <Widget>[
                Text("Are you sure want to register ?"),
              ],
            ),
          ),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Yes"),
              onPressed: _onRegister
            ),
            new FlatButton(
              child: new Text("No"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
  void _onRegister() {
    String name = _nameEditingController.text;
    String email = _emailEditingController.text;
    String phone = _phoneEditingController.text;
    String password = _passEditingController.text;
    if (!_isChecked) {
      Toast.show("Please Accept Term", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      return;
    }

    http.post(urlRegister, body: {
      "name": name,
      "email": email,
      "phone": phone,
      "password": password,
    }).then((res) {
      if (res.body == "success") {
        Navigator.pop(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => LoginScreen()));
        Toast.show("Registration success", context,
            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      } else {
        Toast.show("Registration failed", context,
            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      }
    }).catchError((err) {
      print(err);
    });
  }


  void _loginScreen() {
    Navigator.pop(context,
        MaterialPageRoute(builder: (BuildContext context) => LoginScreen()));
  }

  void _onChange(bool value) {
    setState(() {
      _isChecked = value;
      //savepref(value);
    });
  }

  void _showEULA() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("EULA"),
          content: new Container(
            height: screenHeight / 2,
            child: Column(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: new SingleChildScrollView(
                    child: RichText(
                        softWrap: true,
                        textAlign: TextAlign.justify,
                        text: TextSpan(
                            style: TextStyle(
                              color: Colors.black,
                              //fontWeight: FontWeight.w500,
                              fontSize: 12.0,
                            ),
                            text:
                                "This End-User License Agreement is a legal agreement between you and Asaboleh This EULA agreement governs your acquisition and use of our LET's MAKAN software (Software) directly from Asaboleh or indirectly through a Asaboleh authorized reseller or distributor (a Reseller).Please read this EULA agreement carefully before completing the installation process and using the LET's MAKAN software. It provides a license to use the LET's MAKAN software and contains warranty information and liability disclaimers. If you register for a free trial of the LET's MAKAN software, this EULA agreement will also govern that trial. By clicking accept or installing and/or using the LET's MAKAN software, you are confirming your acceptance of the Software and agreeing to become bound by the terms of this EULA agreement. If you are entering into this EULA agreement on behalf of a company or other legal entity, you represent that you have the authority to bind such entity and its affiliates to these terms and conditions. If you do not have such authority or if you do not agree with the terms and conditions of this EULA agreement, do not install or use the Software, and you must not accept this EULA agreement.This EULA agreement shall apply only to the Software supplied by Asaboleh herewith regardless of whether other software is referred to or described herein. The terms also apply to any Asaboleh updates, supplements, Internet-based services, and support services for the Software, unless other terms accompany those items on delivery. If so, those terms apply. This EULA was created by EULA Template for LET's MAKAN. Asaboleh shall at all times retain ownership of the Software as originally downloaded by you and all subsequent downloads of the Software by you. The Software (and the copyright, and other intellectual property rights of whatever nature in the Software, including any modifications made thereto) are and shall remain the property of Asaboleh. Asaboleh reserves the right to grant licences to use the Software to third parties"
                            //children: getSpan(),
                            )),
                  ),
                )
              ],
            ),
          ),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ],
        );
      },
    );
  }
}

String _validateName(String value) {
  String patttern = r'(^[a-zA-Z ]*$)';
  RegExp regExp = new RegExp(patttern);
  if (value.length == 0) {
    return "Name is Required";
  } else if (!regExp.hasMatch(value)) {
    return "Name must be a-z and A-Z";
  }
  return null;
}

String _validatePhone(String value) {
  String patttern = r'(^[0-9]*$)';
  RegExp regExp = new RegExp(patttern);
  if (value.length == 0) {
    return "Phone no is Required";
  } else if (value.length < 10) {
    return "Phone no  must be at least 10 digits";
  } else if (!regExp.hasMatch(value)) {
    return "Phone no  must be digits";
  }
  return null;
}

String _validateEmail(String value) {
  String pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regExp = new RegExp(pattern);
  if (value.length == 0) {
    return "Email is Required";
  } else if (!regExp.hasMatch(value)) {
    return "Invalid Email";
  } else {
    return null;
  }
}

String _validatePass(String value) {
  String patttern = r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{6,}$';
  RegExp regExp = new RegExp(patttern);
  if (value.length == 0) {
    return "Password is Required";
  } else if (value.length < 6) {
    return "Password must be at least 6 alphanumerics";
  } else if (!regExp.hasMatch(value)) {
    return "Password must contain at least a alphabert and a digit";
  }
  return null;
}
