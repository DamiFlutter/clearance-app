import 'package:clearance/auths/authmodel.dart';
import 'package:clearance/auths/home/hompage.dart';
import 'package:clearance/auths/home/mainhome.dart';
import 'package:clearance/auths/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
void main()async {
   WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
   runApp(
    MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (_) => AuthProvider(FirebaseAuth.instance),
          ),
          StreamProvider(
              create: (context) =>
                  context.read<AuthProvider>().authStateChanges),
        ],
    child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
     builder:()=> MaterialApp(
       debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        builder: EasyLoading.init(),
        theme: ThemeData(
          primarySwatch: Colors.blue,
          
        ),
        
        home:  AuthenticationWrapper(),
         
      ),
    );
  }
}

class AuthenticationWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User>();

    if (firebaseUser != null) {
      //If the user is successfully Logged-In.
      return MainHome();
    } else {
      //If the user is not Logged-In.
      return LoginWidget();
    }
  }
}
