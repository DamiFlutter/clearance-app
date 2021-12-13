import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ClearedStatus extends StatefulWidget {
  const ClearedStatus({Key key}) : super(key: key);

  @override
  _ClearedStatusState createState() => _ClearedStatusState();
}

class _ClearedStatusState extends State<ClearedStatus> {
  @override
  void initState() {
    super.initState();
    getUserData();
  }

  User user = FirebaseAuth.instance.currentUser;
  var userData;
  Future<DocumentSnapshot> getUserData() async {
    var result = await FirebaseFirestore.instance
        .collection("users")
        .doc(user.email)
        .get();
    setState(() {
      userData = result;
    });
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Congratulations you have been cleared successfully',
              style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10,),
            Row(
              children: [
                Text('Matric Number: '),
                Text(userData.data()['Matric Number']),
              ],
            ),
             SizedBox(height: 10,),
            Row(
              children: [
                Text('E-mail: '),
                Text(userData.data()['email']),
              ],
            )
          ],
        ),
      ),
      bottomSheet: BottomSheet(
        backgroundColor: Colors.white,
          onClosing: () {},
          builder: (context) {
            return Container(
              height: 80,
              width: MediaQuery.of(context).size.width,
              child: Expanded(
                  child: Row(
                children: [
                  Container(
                    color: CupertinoColors.systemBlue,
                    height: 40,
                    width: MediaQuery.of(context).size.width,
                    child: Center(
                      child: Text('Print Clearance'),
                    ),
                  )
                ],
              )),
            );
          }),
    );
  }
}
