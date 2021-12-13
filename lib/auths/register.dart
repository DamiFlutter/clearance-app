
import 'package:clearance/auths/authmodel.dart';
import 'package:clearance/auths/home/hompage.dart';
import 'package:clearance/auths/home/mainhome.dart';
import 'package:clearance/widgets/progressdialog.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/size_extension.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class RegisterWidget extends StatefulWidget {
  @override
  _RegisterWidgetState createState() => _RegisterWidgetState();
}

class _RegisterWidgetState extends State<RegisterWidget> {
  final _formKey = GlobalKey<FormState>();

  Icon icon;

  var _emailTextController = TextEditingController();

  var _nameTextController = TextEditingController();
  var _matricNumber = TextEditingController();

  String email;
  String username;
  String password;

  bool isLoading = false;

  bool isVisible = false;
  bool confirmVisible = false;

  @override
  Widget build(BuildContext context) {
    final _authData = Provider.of<AuthProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CupertinoColors.systemGreen,
      ),
      body: Center(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.only(top: 40.0, left: 15, right: 15),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 40.0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Hello There',
                          style: GoogleFonts.ptSans(
                              color: Colors.green,
                              fontWeight: FontWeight.w900,
                              fontSize: 20),
                      
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    TextFormField(
                      controller: _nameTextController,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please provide an Username';
                        }
                        setState(() {
                          username = value;
                        });
                        return null;
                      },
                      decoration: InputDecoration(
                        suffixIcon: Icon(Icons.face,
                            color: Color(0xFFB0B9C0), size: 22.0),
                        hintStyle: GoogleFonts.poppins(
                            fontSize: 14,
                          color: Color(0xFFB0B9C0),
                        ),
                        labelStyle: TextStyle(
                          color: Color(0xFFB0B9C0),
                        ),
                        fillColor: Color(0xfff3f3f4),
                        filled: true,
                        border: InputBorder.none,
                        hintText: 'Username',
                      ),
                    ),
                    
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: _emailTextController,
                      validator: (value) {
                        EmailValidator.validate(value)? 'Enter a valid email':null;
                        if (value.isEmpty) {
                          return 'Please provide an Email';
                        }
                        setState(() {
                          email = value;
                        });
                        return null;
                      },
                      decoration: InputDecoration(
                        suffixIcon: Icon(Icons.mail,
                            color: Color(0xFFB0B9C0), size: 22.0),
                        hintStyle: GoogleFonts.poppins(
                            fontSize: 14,
                          color: Color(0xFFB0B9C0),
                        ),
                        labelStyle: TextStyle(
                          color: Color(0xFFB0B9C0),
                        ),
                        fillColor: Color(0xfff3f3f4),
                        filled: true,
                        border: InputBorder.none,
                        hintText: 'Email',
                      ),
                    ),
                     SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: _matricNumber,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please provide an Matric number';
                        }
                        setState(() {
                          
                        });
                        return null;
                      },
                      decoration: InputDecoration(
                        suffixIcon: Icon(Icons.confirmation_number,
                            color: Color(0xFFB0B9C0), size: 22.0),
                        hintStyle: GoogleFonts.poppins(
                            fontSize: 14,
                          color: Color(0xFFB0B9C0),
                        ),
                        labelStyle: TextStyle(
                          color: Color(0xFFB0B9C0),
                        ),
                        fillColor: Color(0xfff3f3f4),
                        filled: true,
                        border: InputBorder.none,
                        hintText: 'Matric Number',
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please Provide a password';
                        }
                        if (value.length < 6) {
                          return 'Minimum 6 Charachters';
                        }
                        setState(() {
                          password = value;
                        });
                        return null;
                      },
                      obscureText: isVisible ? false : true,
                      decoration: InputDecoration(
                        hintStyle: GoogleFonts.poppins(
                            fontSize: 14,
                          color: Color(0xFFB0B9C0),
                        ),
                        labelStyle: TextStyle(
                          color: Color(0xFFB0B9C0),
                        ),
                        suffixIcon: isVisible
                          ? IconButton(
                              icon: Icon(
                                Icons.lock_open_rounded,
                                color: Colors.green,
                              ),
                              onPressed: () {
                                setState(() {
                                  isVisible = false;
                                });
                              },
                            ): IconButton(
                              icon: Icon(
                                Icons.lock,
                               
                                color: Color(0xFFB0B9C0),
                              ),
                              onPressed: () {
                                setState(() {
                                  isVisible  = true;
                                });
                              },
                            ),
                        fillColor: Color(0xfff3f3f4),
                        filled: true,
                        hintText: 'Password',
                        border: InputBorder.none,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please Provide a password';
                        }
                        if (value.length < 6) {
                          return 'Minimum 6 Charachters';
                        }
                        setState(() {
                          // password = value;
                        });
                        return null;
                      },
                      obscureText: confirmVisible  ? false : true,
                      decoration: InputDecoration(
                        hintStyle: GoogleFonts.poppins(
                            fontSize: 14,
                          color: Color(0xFFB0B9C0),
                        ),
                        labelStyle: TextStyle(
                          color: Color(0xFFB0B9C0),
                        ),
                        suffixIcon:confirmVisible
                          ? IconButton(
                              icon: Icon(
                                Icons.lock_open_rounded,
                                color: Colors.green,
                              ),
                              onPressed: () {
                                setState(() {
                                  confirmVisible = false;
                                });
                              },
                            ): IconButton(
                              icon: Icon(
                                Icons.lock,
                               
                                color: Color(0xFFB0B9C0),
                              ),
                              onPressed: () {
                                setState(() {
                                  confirmVisible  = true;
                                });
                              },
                            ),
                        fillColor: Color(0xfff3f3f4),
                        filled: true,
                        hintText: 'Confirm Password',
                        border: InputBorder.none,
                      ),
                    ),
                    
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Expanded(
                            child: TextButton(
                          onPressed: () {
                            if (_formKey.currentState.validate()) {
                            EasyLoading.show(
                              status: 'Registering please wait...',
                              dismissOnTap: false,
                            );
                              _authData
                                  .registerUser(email, password)
                                  .then((crendential) {
                                Navigator.pop(context);
                                if (crendential.user.uid != null) {
                                  _authData
                                      .saveusertodb(
                                    username: username,
                                    email: email,
                                    matricnumber: _matricNumber.text,
                                  )

                                      .then((value) {
                                    setState(() {
                                      //  _formKey.currentState.reset();
                                      isLoading = false;
                                      EasyLoading.dismiss();
                                    });
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>MainHome()));
                                  });
                                } else {
                                  EasyLoading.dismiss();
                                   Flushbar(
                    title:  "Auth Error",
                    messageText:  Text( _authData.error,
                    style: GoogleFonts.ptSans(
                      color: Colors.white,
                    ),
                    ),
                    backgroundColor: Colors.red,
                    
                   
                    flushbarPosition: FlushbarPosition.TOP,
                    flushbarStyle: FlushbarStyle.FLOATING,
                    duration:  Duration(seconds: 3),              
                  )..show(context);
                                }
                              });
                            }
                          },
                          child: Text(
                            'Create Account',
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w900,
                                fontSize: 16,
                                color: Colors.white),
                          ),
                       style: ButtonStyle(
                               foregroundColor: MaterialStateProperty.all( CupertinoColors.white),
                               backgroundColor: MaterialStateProperty.all( CupertinoColors.systemGreen),
                               padding: MaterialStateProperty.all(EdgeInsets.symmetric(vertical: 11.h)),
                               textStyle: MaterialStateProperty.all(GoogleFonts.poppins(
                                 color:Colors.white,
                                 fontSize: 14.sp,
                               ))
                             )
                        )),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          FlatButton(
                              onPressed: () {
                                // Navigator.pushReplacementNamed(
                                //     context, LoginScreen.id);
                              },
                              child: RichText(
                                  text: TextSpan(text: '', children: [
                                TextSpan(
                                    text: 'Already have an account?  ',
                                    style: TextStyle(
                                      fontSize: 14,
                                   
                                      color: Colors.black,
                                    )),
                                TextSpan(
                                    text: 'Login',
                                    style: GoogleFonts.poppins(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w900,
                                      color: Colors.green,
                                    ))
                              ]))),
                        ],
                      ),
                    ),
                    
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void showdAlertDialog() {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return ProgressDialog(
            message: 'Registering, Please Wait......',
          );
        });
  }
}
