import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';


class AuthProvider extends ChangeNotifier {
  final FirebaseAuth _firebaseAuth;

  final userRef = FirebaseFirestore.instance.collection("users");
  
 final doc = FirebaseFirestore.instance.collection("sends");
  AuthProvider(this._firebaseAuth);

  // managing the user state via stream.
  // stream provides an immediate event of
  // the user's current authentication state,
  // and then provides subsequent events whenever
  // the authentication state changes.
  Stream<User> get authStateChanges => _firebaseAuth.authStateChanges();

  File image;
  File newIamge;
  File weaccert;
  String pickerError = '';
  bool isPicAvail = false;
  bool isnewImageAvail = false;
  bool waeccert = false;
  bool isLinkavail = false;
  String error = "";
  double shopLatitude;
  double shopLongitude;
  String shopAddress;
  String username;
  String newUsername;
  String placeName;
  String email = "";

  getUsername(username) {
    this.username = username;
  }

  Future<File> getImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(
      source: ImageSource.gallery,
      imageQuality: 20,
    );
    if (pickedFile != null) {
      image = File(pickedFile.path);
      notifyListeners();
    } else {
      pickerError = "No Image Selected";
      print('No image selected.');
      notifyListeners();
    }
    return image;
  }  
  Future<File> getnewImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(
      source: ImageSource.gallery,
      imageQuality: 20,
    );
    if (pickedFile != null) {
      newIamge = File(pickedFile.path);
      notifyListeners();
    } else {
      pickerError = "No Image Selected";
      print('No image selected.');
      notifyListeners();
    }
    return newIamge;
  }
  Future<File> getweaccert() async {
    final image = ImagePicker();
    final pickedImage = await image.getImage(
      source: ImageSource.gallery,
      imageQuality: 20,
    );
    if (pickedImage != null) {
      newIamge = File(pickedImage.path);
      notifyListeners();
    } else {
      pickerError = "No Image Selected";
      print('No image selected.');
      notifyListeners();
    }
    return weaccert;
  }

  Future<File> getChatImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(
      source: ImageSource.gallery,
      imageQuality: 20,
    );
    if (pickedFile != null) {
      image = File(pickedFile.path);
      notifyListeners();
    } else {
      pickerError = "No Image Selected";
      print('No image selected.');
      notifyListeners();
    }
    return image;
  }

  Future<String> getProductImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(
      source: ImageSource.gallery,
      imageQuality: 20,
    );
    if (pickedFile != null) {
      image = File(pickedFile.path);
      notifyListeners();
    } else {
      pickerError = "No Image Selected";
      print('No image selected.');
      notifyListeners();
    }
    return image.path.trim();
  }

  Future<UserCredential> registerUser(email, password) async {
    this.email = email;
    notifyListeners();
    UserCredential userCrendential;
    try {
      userCrendential = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        error = "The account already exists for that email.";
      error = e.code;
      notifyListeners();
      }
    } catch (e) {
      error = e.ecode();
      notifyListeners();
      print(e);
    }
    return userCrendential;
  }

  Future<UserCredential> loginUser(email, password) async {
    this.email = email;
    notifyListeners();
    UserCredential userCrendential;
    try {
      userCrendential = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        error = 'The password provided is too weak.';
        notifyListeners();
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        error = 'The account already exists for that email.';
        notifyListeners();
        print('The account already exists for that email.');
         notifyListeners();
      }else if (e.code == 'wrong-password') {
        error = "Wrong password provided for that user.";
        notifyListeners();
      } 
      else if (e.code == 'user-not-found') {
        error = 'No user found for that email';
        notifyListeners();
        
      }
      else{
        error ='you are currently offline, please reconnect to internet';
        notifyListeners();
      }

    } catch (e) {
      error = e.code();
      notifyListeners();
      print(e);
    }
    return userCrendential;
  }
   Future<void> updateProfileItems({
    String newurl,
    String newName,
    String newAddress,
    String newmobile,
  }) async {
    User user = FirebaseAuth.instance.currentUser;
    DocumentReference updateUser =
        FirebaseFirestore.instance.collection('users').doc(user.email);
    updateUser.update({
      "photo": newurl,
      "phone-number": newmobile,
      "username": newName,
      "Home-Address":newAddress,
    });
    return null;
  }
  Future<void> updateProfile({
    String waecurl,
    String stateoforigin,
    String dob,
  }) async {
    User user = FirebaseAuth.instance.currentUser;
    DocumentReference updateUser =
        FirebaseFirestore.instance.collection('users').doc(user.email);
    updateUser.update({
      "waec ceartificate": waecurl,
      'dob':dob,
      'state of origin':stateoforigin,

    });
    return null;
  }

  // Future<void> updatePaymentMethod({String paymentMethod,  fee, status, encodedPoints}) async {
  //   User user = FirebaseAuth.instance.currentUser;
  //  // DocumentSnapshot doc = QuerySnapshot querySnapshot;;
    
  //  DocumentReference users =
  //       FirebaseFirestore.instance.collection('Sends').doc(user.email);
  //   await users.update({
  //     "Payment Method": paymentMethod,
  //     "fee": int.parse(fee),
  //      "Order Placed": true,
  //      "Reached Pickup Station": false,
  //      "On the way to drop off": false,
  //      "Reached drop off station": false,
  //      "Package delivered": false,
  //      "driverspercent": null,
  //      'Status': status,
  //      "Encoded Points": encodedPoints,
  //   });
  //    return null;
  // }

  Future<void> resettPassword(email) async {
    this.email = email;
    notifyListeners();
    UserCredential userCrendential;
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      error = e.code;
      notifyListeners();
    } catch (e) {
      error = e.toString();
      notifyListeners();
      print(e);
    }
    return userCrendential;
  }

  Future siginOut() async {
    try {
      return await _firebaseAuth.signOut();
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

  Future<void> saveusertodb(
      {String url, String username, String email, String matricnumber, String mobile, String photo}) async {
    User user = FirebaseAuth.instance.currentUser;
    DocumentReference users =
        FirebaseFirestore.instance.collection('users').doc(user.email);
    users.set({
      'uid': user.uid,
      "username": username,
      'email': email,
      'photo': null,
      'Matric Number': matricnumber,
      
      'phone-number': null,
      'Home-Address': null,
      'Work-address': null,
    });
    return null;
  }

 Future<void> recentactivities(
      {String title, String message, String date,}) async {
    User user = FirebaseAuth.instance.currentUser;
    DocumentReference users =
        FirebaseFirestore.instance.collection('recentactivies').doc();
    users.set({
    'email': user.email,
    'title': title,
    'mesage': message,
    'date': date,
    
    });
    return null;
  }

  Future<void> savesendtypetoDb({
    String description,
    String collection,
    String sendersusername,
    String pending,
    String dropOffnumber,
    String pickupNumber,
    String pickup,
    String dropOff,
    String paymentMethod,  fee, status, encodedPoints,
  }) async {
    User user = FirebaseAuth.instance.currentUser;
    //this is the add document code
    // DocumentSnapshot doc;
   DocumentReference updateSends = FirebaseFirestore.instance.collection("Sends").doc(); 
    updateSends.set({
      'uid': user.uid,
      "username": sendersusername,
      'email': user.email,
      'Pickup Number': pickupNumber,
      'Dropoff Number': dropOffnumber,
      'img': null,
      'collection type': collection,
      'Description': description,
      'Promo Code': null,
      'Accepted': false,
      "Pickup Location":pickup,
      "Dropoff Location": dropOff,
      "Payment Method": paymentMethod,
      "fee": int.parse(fee),
      "Order Placed": true,
      "Reached Pickup Station": false,
      "On the way to drop off": false,
      "Reached drop off station": false,
      "Package delivered": false,
      "driverspercent": null,
      "Status": status,
      "Encoded Points": encodedPoints,
      'createdOn':FieldValue.serverTimestamp(),
      "time": DateTime.now().microsecondsSinceEpoch,
    }).catchError((e){
      
    });
    return null;
  }
 
  Future<void> updateSend({
    String pickup,
    String dropOff,
  }) async {
    User user = FirebaseAuth.instance.currentUser;
   // DocumentSnapshot doc = QuerySnapshot querySnapshot;;
   //this is the update
    
    DocumentReference users =
        FirebaseFirestore.instance.collection('Sends').doc(user.email);
   
    
    users.update({
      'Pickup Station': pickup,
      'DropOff Station': dropOff,
    });
    return null;
  }
  Future<void>storeWalletId({
  String walletId,
 })async{
     User user = FirebaseAuth.instance.currentUser;
    DocumentReference users = FirebaseFirestore.instance.collection('users').doc(user.email);
  await users.update({
    'wallet_id': walletId,
  });
 }

  signOut(context) async {
    EasyLoading.show(
      status: "Signing Out",
      dismissOnTap: false,
    );
    try{
     await FirebaseAuth.instance.signOut();
    }catch(e){
     Fluttertoast.showToast(msg: e.toString());
    }
    EasyLoading.dismiss();

    notifyListeners();
  }
  Future sendResetPassword(String email)async{
     try{
     _firebaseAuth.sendPasswordResetEmail(email: email);
     }catch(error){
       Fluttertoast.showToast(msg: error.toString(),
       
       
       );
     }
    //notifyListeners();
  }

//fb signin

  // Future<void> getCurrentAddress() async {
  // Location location = new Location();

  /// bool _serviceEnabled;
  //PermissionStatus _permissionGranted;
  //LocationData _locationData;

  //_serviceEnabled = await location.serviceEnabled();
  //if (!_serviceEnabled) {
  // _serviceEnabled = await location.requestService();
  // if (!_serviceEnabled) {
  //   return;
  /// }
  //}

  //  _permissionGranted = await location.hasPermission();
  //  if (_permissionGranted == PermissionStatus.denied) {
  //    _permissionGranted = await location.requestPermission();
  ///    if (_permissionGranted != PermissionStatus.granted) {
  //    return;
  //     }
  //   }

  //  _locationData = await location.getLocation();
  //  this.shopLatitude = _locationData.latitude;
  //  this.shopLongitude = _locationData.longitude;
  //  notifyListeners();
  //  final coordinates =
  //  new Coordinates(_locationData.latitude, _locationData.longitude);
  //  var address =
  // await Geocoder.local.findAddressesFromCoordinates(coordinates);
  // var shopAddress = address.first;
  //  this.shopAddress = shopAddress.addressLine;
  // this.placeName = shopAddress.featureName;
  // print("${first.featureName} : ${first.addressLine}");
  //  notifyListeners();
  //return shopAddress;
//  }
//}

}
