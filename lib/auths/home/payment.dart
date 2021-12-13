// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'dart:io';

import 'package:clearance/auths/home/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_paystack/flutter_paystack.dart';
import 'package:google_fonts/google_fonts.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({Key key}) : super(key: key);

  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  User user = FirebaseAuth.instance.currentUser;
  var userData;
  String _getReference() {
    String platform;
    if (Platform.isIOS) {
      platform = 'iOS';
    } else {
      platform = 'Android';
    }

    return 'ChargedFrom${platform}_${DateTime.now().millisecondsSinceEpoch}';
  }

  PaymentCard _getCardUi() {
    return PaymentCard(
      number: "",
      cvc: "",
      expiryMonth: 0,
      expiryYear: 0,
    );
  }

  int hostelfee = 2000;
  int campusfee = 10000;
  int libraryfee = 5000;
  int extrasessionfee = 300000;
  Future initPlug() async {
    await PaystackPlugin.initialize(publicKey: ConstantKey.paystack_key);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: CupertinoColors.systemBlue,
          centerTitle: true,
          title: const Text('Payment'),
        ),
        body: ListView(
          children: [
            Column(
              children: [
                Center(
                    child: Column(children: <Widget>[
                  Container(
                    margin: EdgeInsets.all(10),
                    child: Table(
                        defaultVerticalAlignment:
                            TableCellVerticalAlignment.middle,
                        textBaseline: TextBaseline.alphabetic,
                        textDirection: TextDirection.ltr,
                        border: TableBorder
                            .all(), // Allows to add a border decoration around your table
                        children: [
                          // ignore: prefer_const_constructors
                          TableRow(children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'Hostel Amount Fee',
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'Status',
                                  style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'Link',
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ]),
                          TableRow(children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                hostelfee.toString(),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('Not paid'),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ElevatedButton(
                                  onPressed: () {
                                    initPlug().then((_) async {
                                      Charge charge = Charge()
                                        ..amount = hostelfee * 100
                                        ..email = user.email
                                        ..reference = _getReference()
                                        ..card = _getCardUi();

                                      CheckoutResponse response =
                                          await PaystackPlugin.checkout(
                                        context,
                                        charge: charge,
                                        method: CheckoutMethod.card,
                                        fullscreen: false,
                                        // logo: Image.asset(
                                        //   'assets/assets/assets/images/F.png',
                                        //   height: 60,
                                        //   width: 60,
                                        // )
                                      );
                                      print('Response $response');
                                    });
                                  },
                                  child: Text("pay")),
                            )
                          ]),
                        ]),
                  ),
                ])),
                SizedBox(
                  height: 20,
                ),
                Center(
                    child: Column(children: <Widget>[
                  Container(
                    margin: EdgeInsets.all(10),
                    child: Table(
                        defaultVerticalAlignment:
                            TableCellVerticalAlignment.middle,
                        textBaseline: TextBaseline.alphabetic,
                        textDirection: TextDirection.ltr,
                        border: TableBorder
                            .all(), // Allows to add a border decoration around your table
                        children: [
                          // ignore: prefer_const_constructors
                          TableRow(children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'Campus Amount Fee',
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'Status',
                                  style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'Link',
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ]),
                          TableRow(children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                campusfee.toString(),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('Not paid'),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ElevatedButton(
                                  onPressed: () {
                                      initPlug().then((_) async {
                                      Charge charge = Charge()
                                        ..amount = campusfee * 100
                                        ..email = user.email
                                        ..reference = _getReference()
                                        ..card = _getCardUi();

                                      CheckoutResponse response =
                                          await PaystackPlugin.checkout(
                                        context,
                                        charge: charge,
                                        method: CheckoutMethod.card,
                                        fullscreen: false,
                                        // logo: Image.asset(
                                        //   'assets/assets/assets/images/F.png',
                                        //   height: 60,
                                        //   width: 60,
                                        // )
                                      );
                                      print('Response $response');
                                    });
                                  }, child: Text("pay")),
                            )
                          ]),
                        ]),
                  ),
                ])),
                SizedBox(
                  height: 20,
                ),
                Center(
                    child: Column(children: <Widget>[
                  Container(
                    margin: EdgeInsets.all(10),
                    child: Table(
                        defaultVerticalAlignment:
                            TableCellVerticalAlignment.middle,
                        textBaseline: TextBaseline.alphabetic,
                        textDirection: TextDirection.ltr,
                        border: TableBorder
                            .all(), // Allows to add a border decoration around your table
                        children: [
                          // ignore: prefer_const_constructors
                          TableRow(children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'Library Amount Fee',
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'Status',
                                  style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'Link',
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ]),
                          TableRow(children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                libraryfee.toString(),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('Not paid'),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ElevatedButton(
                                  onPressed: () {
                                      initPlug().then((_) async {
                                      Charge charge = Charge()
                                        ..amount = libraryfee * 100
                                        ..email = user.email
                                        ..reference = _getReference()
                                        ..card = _getCardUi();

                                      CheckoutResponse response =
                                          await PaystackPlugin.checkout(
                                        context,
                                        charge: charge,
                                        method: CheckoutMethod.card,
                                        fullscreen: false,
                                        // logo: Image.asset(
                                        //   'assets/assets/assets/images/F.png',
                                        //   height: 60,
                                        //   width: 60,
                                        // )
                                      );
                                      print('Response $response');
                                    });
                                  }, child: Text("pay")),
                            )
                          ]),
                        ]),
                  ),
                ])),
                SizedBox(
                  height: 20,
                ),
                Center(
                    child: Column(children: <Widget>[
                  Container(
                    margin: EdgeInsets.all(10),
                    child: Table(
                        defaultVerticalAlignment:
                            TableCellVerticalAlignment.middle,
                        textBaseline: TextBaseline.alphabetic,
                        textDirection: TextDirection.ltr,
                        border: TableBorder
                            .all(), // Allows to add a border decoration around your table
                        children: [
                          // ignore: prefer_const_constructors
                          TableRow(children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'Extra Session Fee',
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'Status',
                                  style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'Link',
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ]),
                          TableRow(children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                extrasessionfee.toString(),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('Not paid'),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ElevatedButton(
                                  onPressed: () {
                                      initPlug().then((_) async {
                                      Charge charge = Charge()
                                        ..amount = extrasessionfee * 100
                                        ..email = user.email
                                        ..reference = _getReference()
                                        ..card = _getCardUi();

                                      CheckoutResponse response =
                                          await PaystackPlugin.checkout(
                                        context,
                                        charge: charge,
                                        method: CheckoutMethod.card,
                                        fullscreen: false,
                                        // logo: Image.asset(
                                        //   'assets/assets/assets/images/F.png',
                                        //   height: 60,
                                        //   width: 60,
                                        // )
                                      );
                                      print('Response $response');
                                    });
                                  }, child: Text("pay")),
                            )
                          ]),
                        ]),
                  ),
                ])),
              ],
            ),
          ],
        ));
  }
}
