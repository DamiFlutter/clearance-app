import 'dart:io';

import 'package:clearance/auths/authmodel.dart';
import 'package:clearance/auths/home/hompage.dart';
import 'package:clearance/auths/home/mainhome.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class UploadCredentials extends StatefulWidget {
  const UploadCredentials({Key key}) : super(key: key);

  @override
  _UploadCredentialsState createState() => _UploadCredentialsState();
}

File _image;
File waeccert;

class _UploadCredentialsState extends State<UploadCredentials> {
  Future<String> uploadFile(filepath) async {
    File file = File(filepath);
    FirebaseStorage _storage = FirebaseStorage.instance;
    try {
      await _storage.ref('credentials/user' + '.jpg').putFile(file);
    } on FirebaseException catch (e) {
      print(e.code);
    }
    String downloadUrl =
        await _storage.ref('credentials/user' + '.jpg').getDownloadURL();
    return downloadUrl;
  }
   Future<String> uploadnewfile(filepath) async {
    File file = File(filepath);
    FirebaseStorage _storage = FirebaseStorage.instance;
    try {
      await _storage.ref('credentials/userss' + '.jpg').putFile(file);
    } on FirebaseException catch (e) {
      print(e.code);
    }
    String downloadUrl =
        await _storage.ref('credentials/userss' + '.jpg').getDownloadURL();
    return downloadUrl;
  }


  DateTime _selectedDate;
  void _pickDateDialog() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(1950),
            lastDate: DateTime.now())
        .then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final authData = Provider.of<AuthProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CupertinoColors.systemBlue,
        centerTitle: true,
        title: const Text('Upload Credentials'),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 40.0, left: 8, right: 8),
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                _pickDateDialog();
              },
              child: Container(
                height: 40,
                width: MediaQuery.of(context).size.width,
                color: Colors.grey[200],
                child: Center(
                    child: _selectedDate == null
                        ? Text(" Date of birth")
                        : Text(DateFormat.yMMMd().format(_selectedDate))),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 50,
              width: MediaQuery.of(context).size.width,
              child: InkWell(
                onTap: () {
                  authData.getnewImage().then((image) {
                    setState(() {
                      _image = image;
                      if (image != null) {
                        authData.isnewImageAvail = true;
                      }
                    });
                    setState(() {});
                  });
                },
                child: Card(
                  elevation: 2,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: _image == null
                        ? Center(child: Text("Upload State of origin"))
                        : Center(
                            child: Text(
                              _image.path.split('/').last,
                            ),
                          ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 50,
              width: MediaQuery.of(context).size.width,
              child: InkWell(
                onTap: () {
                  authData.getImage().then((weaccc) {
                    setState(() {
                      waeccert = weaccc;
                      if (weaccc != null) {
                        authData.waeccert = true;
                      }
                    });
                  });
                },
                child: Card(
                  elevation: 2,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: waeccert == null
                        ? Center(child: Text("Upload Waec Certificate"))
                        : Center(
                            child: Text(
                              waeccert.path.split('/').last,
                            ),
                          ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              height: 40,
              width: MediaQuery.of(context).size.width,
              color: Colors.grey[200],
              child: Center(child: Text("Upload Jamb Result")),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              height: 40,
              width: MediaQuery.of(context).size.width,
              color: Colors.grey[200],
              child: Center(child: Text("Upload Birth Certificate")),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              height: 40,
              width: MediaQuery.of(context).size.width,
              color: Colors.grey[200],
              child: Center(child: Text("Upload School ID")),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              height: 40,
              width: MediaQuery.of(context).size.width,
              color: Colors.grey[200],
              child: Center(child: Text("Upload School fees Receipts")),
            ),
          ],
        ),
      ),
      bottomSheet: BottomSheet(
          backgroundColor: Colors.transparent,
          onClosing: () {},
          builder: (context) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () {
                  EasyLoading.show(status: 'Uploading...');
                  if (authData.isnewImageAvail = true) {
                    if (authData.waeccert = true) {
                      if (_selectedDate != null) {
                        authData.updateProfile().then((crendential) {
                          uploadFile(authData.newIamge.path).then((url) {
                            if (url != null) {
                              authData.updateProfile().then((crendential) {
                                uploadnewfile(authData.image.path).then((newurl) {
                                  if (newurl != null) {
                                    authData.recentactivities(
                                      date:DateFormat('yMMMd').format(DateTime.now()),
                                      message: 'your credentials has been uploaded successfully',
                                      title: 'Uploaded Succesfully'
                                    );
                                    authData
                                        .updateProfile(
                                     dob: _selectedDate.toString(),
                                     stateoforigin: url,
                                     waecurl: newurl,
                                    )
                                        .then((value) {
                                      EasyLoading.showSuccess("Uploaded");
                                      EasyLoading.dismiss();
                                      Navigator.push(context, MaterialPageRoute(builder: (context)=>MainHome()));
                                     setState(() {
                                       _image = null;
                                       waeccert = null;
                                       _selectedDate = null;
                                     });
                                     
                                    });
                                  } else {
                                    Fluttertoast.showToast(
                                        msg: "An Error Occured");
                                    EasyLoading.dismiss();
                                  }
                                });
                              });
                            } else {
                              Fluttertoast.showToast(msg: "An Error Occured");
                              EasyLoading.dismiss();
                            }
                          });
                        });
                      } else {
                        Fluttertoast.showToast(msg: "An Error Occured");
                        EasyLoading.dismiss();
                      }
                    } else {
                      Fluttertoast.showToast(msg: "An Error Occured");
                      EasyLoading.dismiss();
                    }
                  } else {
                    Fluttertoast.showToast(msg: "An Error Occured");
                    EasyLoading.dismiss();
                  }
                 
                },
                child: Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  color: CupertinoColors.systemBlue,
                  child: Center(
                    child: Text(
                      "Submit",
                      style: GoogleFonts.lato(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            );
          }),
    );
  }
}
