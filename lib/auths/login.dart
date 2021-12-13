import 'package:clearance/auths/authmodel.dart';
import 'package:clearance/auths/register.dart';
import 'package:clearance/widgets/progressdialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/size_extension.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:flushbar/flushbar.dart';
import 'package:provider/provider.dart';

class LoginWidget extends StatefulWidget {
  const LoginWidget({Key key}) : super(key: key);

  @override
  _LoginWidgetState createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  String _email;
  String _imageUrl;

  final _formKey = GlobalKey<FormState>();
  Icon icon;
  var _emailTextController = TextEditingController();
  String email;
  String password;
  bool isLoading = false;
  bool isVisible = false;
  @override
  Widget build(BuildContext context) {
    final _authData = Provider.of<AuthProvider>(context);
    return Scaffold(
      body: Center(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.only(left: 15, right: 15),
            child: Padding(
              padding: const EdgeInsets.only(
                top: 10.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Column(
                    children: [
                      Container(
                        height: 120.h,
                        //   child: Image.asset('assets/assets/assets/images/login_logo.png'
                      ),
                    ],
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Great to see you again',
                        style: GoogleFonts.ptSans(
                            color: CupertinoColors.systemGreen,
                            fontWeight: FontWeight.w900,
                            fontSize: 20),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  TextFormField(
                    controller: _emailTextController,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please provide an Email';
                      }
                      setState(() {
                        email = value;
                      });
                      return null;
                    },
                    decoration: InputDecoration(
                      suffixIcon: const Icon(Icons.face,
                          color: Color(0xFFB0B9C0), size: 22.0),
                      hintStyle: GoogleFonts.ptSans(
                        fontSize: 14,
                        color: const Color(0xFFB0B9C0),
                      ),
                      labelStyle: const TextStyle(
                        color: Color(0xFFB0B9C0),
                      ),
                      fillColor: const Color(0xfff3f3f4),
                      filled: true,
                      border: InputBorder.none,
                      hintText: 'Johndoe@gmail.com',
                    ),
                  ),
                  const SizedBox(
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
                    obscureText: isVisible == false ? true : false,
                    decoration: InputDecoration(
                      hintStyle: GoogleFonts.ptSans(
                        fontSize: 14,
                        color: const Color(0xFFB0B9C0),
                      ),
                      labelStyle: const TextStyle(
                        color: Color(0xFFB0B9C0),
                      ),
                      suffixIcon: isVisible
                          ? IconButton(
                              icon: const Icon(
                                Icons.lock_open_rounded,
                                color: Colors.green,
                              ),
                              onPressed: () {
                                setState(() {
                                  isVisible = false;
                                });
                              },
                            )
                          : IconButton(
                              icon: const Icon(
                                Icons.lock,
                                color: Color(0xFFB0B9C0),
                              ),
                              onPressed: () {
                                setState(() {
                                  isVisible = true;
                                });
                              },
                            ),
                      fillColor: Color(0xfff3f3f4),
                      filled: true,
                      hintText: 'Password',
                      border: InputBorder.none,
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                        onTap: () {
                          //  Navigator.push(context, MaterialPageRoute(builder: (context)=>ResetPassword()));
                        },
                        child: Text(
                          'Forgot Password?',
                          textAlign: TextAlign.end,
                          style: GoogleFonts.ptSans(
                            color: CupertinoColors.systemGreen,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  isLoading
                      ? const CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(
                            Color(0xffff7518),
                          ),
                        )
                      : Row(
                          children: [
                            Expanded(
                                child: TextButton(
                                    onPressed: () {
                                      if (_formKey.currentState.validate()) {
                                        EasyLoading.show(
                                          status: 'Logging in...',
                                          dismissOnTap: false,
                                        );
                                        _authData
                                            .loginUser(email, password)
                                            .then((credential) {
                                          EasyLoading.dismiss();
                                          if (credential != null) {
                                            // Navigator.pushReplacementNamed(
                                            //     context, HomeScreen.id);
                                          } else {
                                            setState(() {
                                              isLoading = false;
                                            });
                                            print(_authData.error);
                                            Flushbar(
                                              title: "Auth Error",
                                              messageText: Text(
                                                _authData.error,
                                                style: GoogleFonts.ptSans(
                                                  color: Colors.white,
                                                ),
                                              ),
                                              backgroundColor: Colors.red,
                                              flushbarPosition:
                                                  FlushbarPosition.TOP,
                                              flushbarStyle:
                                                  FlushbarStyle.FLOATING,
                                              duration:
                                                  const Duration(seconds: 3),
                                            ).show(context);
                                          }
                                        });
                                      }
                                    },
                                    child: const Text(
                                      'Login',
                                    ),
                                    style: ButtonStyle(
                                        foregroundColor:
                                            MaterialStateProperty.all(
                                                CupertinoColors.white),
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                CupertinoColors.systemGreen),
                                        padding: MaterialStateProperty.all(
                                            EdgeInsets.symmetric(vertical: 11.h)),
                                        textStyle: MaterialStateProperty.all(
                                            GoogleFonts.poppins(
                                          color: Colors.white,
                                          fontSize: 14.sp,
                                        ))))),
                          ],
                        ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => RegisterWidget())
                                      );
                            },
                            child: RichText(
                                text: TextSpan(text: '', children: [
                              TextSpan(
                                  text: 'Dont have an account?  ',
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    color: Colors.black,
                                  )),
                              TextSpan(
                                  text: 'Register',
                                  style: GoogleFonts.ptSans(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: CupertinoColors.systemGreen,
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
    );
  }

  void showdAlertDialog() {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return ProgressDialog(
            message: 'Authenticating, Please Wait......',
          );
        });
  }
}
