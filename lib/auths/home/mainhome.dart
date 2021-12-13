import 'package:clearance/auths/home/hompage.dart';
import 'package:clearance/auths/home/payment.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:google_fonts/google_fonts.dart';


class MainHome extends StatefulWidget {
  const MainHome({ Key key }) : super(key: key);

  @override
  _MainHomeState createState() => _MainHomeState();
}

class _MainHomeState extends State<MainHome> {
   int currentIndex = 0;
  List screens = [HomePage(),
  PaymentPage(),
  ];
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: screens.elementAt(currentIndex),
       bottomNavigationBar: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(
                icon: Icon(AntDesign.home), title: Text("Home",
                style: GoogleFonts.lato(),
                )),
            BottomNavigationBarItem(
                icon: Icon(AntDesign.creditcard), title: Text("Payment",
                style: GoogleFonts.lato(),
                )),
          ],
          currentIndex: currentIndex,
          onTap: (int index) {
            setState(() {
              currentIndex = index;
            });
          },
          selectedItemColor: CupertinoColors.systemBlue,
          unselectedItemColor: Colors.grey,
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          elevation: 0,
        ),
    );
  }
}