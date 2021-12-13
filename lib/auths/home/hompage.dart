import 'package:clearance/auths/home/payment.dart';
import 'package:clearance/auths/home/reference.dart';
import 'package:clearance/auths/home/upload.dart';
import 'package:clearance/dummy_data/recent_activity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    getUserData();
  }

  User user = FirebaseAuth.instance.currentUser;
  var userData;
  int currentIndex = 0;

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
      Reference reference = Reference();
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        drawer: Drawer(
          child: ListView(
            children: <Widget>[
              UserAccountsDrawerHeader(
                accountName: Text(userData.data()['Matric Number'] ?? ""),
                accountEmail: Text(user.email),
                currentAccountPicture: CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Text(
                    userData.data()['Matric Number'][0] ?? "",
                    style: const TextStyle(fontSize: 40.0),
                  ),
                ),
              ),
              ListTile(
                title: const Text("Home"),
                leading: const Icon(Icons.home),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text("Profile"),
                leading: const Icon(Icons.person),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text("Upload credentials"),
                leading: const Icon(Icons.upload_file_rounded),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => UploadCredentials()));
                },
              ),
              ListTile(
                title: const Text("Logout"),
                leading: const Icon(Icons.exit_to_app),
                onTap: () {
                  FirebaseAuth.instance.signOut();
                  Navigator.pushReplacementNamed(context, "/login");
                },
              ),
            ],
          ),
        ),
        appBar: AppBar(
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 7.0),
              child: Icon(Icons.notifications_on_outlined),
            ),
          ],
          title: const Text('e-clearance'),
          centerTitle: true,
          backgroundColor: CupertinoColors.systemBlue,
          bottom: const TabBar(
            tabs: [
              Tab(
                icon: Icon(Icons.history),
                child: Text("Recent Activity"),
              ),
              Tab(
                icon: Icon(Icons.account_balance),
                child: Text("Progress"),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            StreamBuilder(
              stream: reference.sends.where("email", isEqualTo: user.email).snapshots(),
              builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                 if(snapshot.connectionState == ConnectionState.waiting){
                                 return Center(child: CircularProgressIndicator());
                               }
                return  CustomScrollView(
                         slivers: [
                           SliverList(
                             delegate: SliverChildListDelegate(snapshot.data.docs.map((DocumentSnapshot document){
                              
                               Map<String, dynamic> data = document.data();
                              // var fetchedTime = DateTime.fromMicrosecondsSinceEpoch(data['date']);
                              //  var d24 = DateFormat('dd/MM/yyyy,   HH:mm').format(fetchedTime);
                               return  Card(
                                 child: Dismissible(
                                   key: Key(document.id),
                                   onDismissed: (direction){
                                     reference.sends.doc(document.id).delete();
                                   },
                                   child: ListTile(
                                    
                                     
                                   
                                     trailing: Text(data["date"],
                                      style: GoogleFonts.poppins(
                                       fontSize: 12,
                                       color:  CupertinoColors.systemGreen,
                                      
                                     ),
                                     ),
                                     dense: true,
                                     title:Text(data["title"],
                                     style: GoogleFonts.poppins(
                                       fontSize: 12,
                                       
                                     ),
                                    
                                     ),
                                     subtitle: Text(data["mesage"],
                                     style: GoogleFonts.lato(
                                       fontSize: 12,   
                                     ), 
                                     ),
                                   ),
                                 ),
                               );
                             }).toList(),
                           ),
                           
                            ) ],
                        );
              }
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  const LinearProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                        CupertinoColors.systemGreen),
                    value: 1.5,
                    color: Colors.green,
                    backgroundColor: Colors.grey,
                    minHeight: 15,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Current Clearance Level: ',
                        style: GoogleFonts.lato(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        'Completed',
                        style: GoogleFonts.lato(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: CupertinoColors.systemGreen,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
       
      ),
    );
  }
}
