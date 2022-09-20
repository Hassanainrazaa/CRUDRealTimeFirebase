import 'package:firebasetasks/FirebaseServices/SplashScreen.dart';
import "package:flutter/material.dart";

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  SplashServices splashScreen = SplashServices();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    splashScreen.Login(context);
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          "Firebase Realtime Database",
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
