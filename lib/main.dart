import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:toll_gate/src/pages/account_details.dart';
import 'package:toll_gate/src/pages/dashboard.dart';
import 'package:toll_gate/src/pages/login.dart';
import 'package:toll_gate/src/pages/new_account.dart';
import 'package:toll_gate/src/pages/search_account.dart';
import 'package:toll_gate/src/pages/tag_scanner.dart';
import 'package:toll_gate/src/pages/new_vehicle.dart';
import 'package:toll_gate/src/pages/vehicle_enrollment.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
     home: Splash2(),
      // initialRoute: '/',
      routes: <String, WidgetBuilder>{
        '/dashboard': (BuildContext context) => SafeArea(
              top: true,
              child: Dashboard(response:' '),
            ),
        '/scanner': (context) => SafeArea(
              top: true,
              child: TagScanner(),
            ),
        '/new-account': (context) => SafeArea(
          top: true,
          child: NewAccount(),
        ),
        '/new-vehicle': (context) => SafeArea(
          top: true,
          child: VehicleRegistration(),
        ),
        '/enrollment': (context) => SafeArea(
          top: true,
          child: VehicleEnrollment(),
        ),
        '/account':(context)=> SafeArea(
          top: true,
          child: SearchAccount(),
        ),
        '/account-details':(context)=> SafeArea(
          top: true,
          child: AccountDetails(),
        )
      },
    );
  }
}
class Splash2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      seconds: 3,
      navigateAfterSeconds: new LoginScreen(),
      // title: new Text('TGMIS',textScaleFactor: 2,),
      image: new Image.asset('assets/image/nssf.png'),
      imageBackground: AssetImage('assets/image/nss.png'),
      loadingText: Text("Loading"),
      photoSize: 100.0,
      loaderColor: Colors.green,
    );
  }
}
