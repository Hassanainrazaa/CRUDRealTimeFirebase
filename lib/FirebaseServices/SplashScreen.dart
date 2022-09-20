import 'dart:async';
import 'package:flutter/material.dart';
import 'package:firebasetasks/UI/auth/Login_screen.dart';

class SplashServices {
  void Login(BuildContext context) {
    Timer(
        const Duration(seconds: 3),
        () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const LoginScreen()),
            ));
  }
}
