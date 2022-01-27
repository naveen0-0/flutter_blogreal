import 'package:blogreal/pages/SignIn.dart';
import 'package:flutter/material.dart';
import './SignUp.dart';

class Authentication extends StatefulWidget {
  const Authentication({ Key? key }) : super(key: key);

  @override
  State<Authentication> createState() => _AuthenticationState();
}

class _AuthenticationState extends State<Authentication> {
  bool showSignUpPage = true;
  @override
  Widget build(BuildContext context) {
    return showSignUpPage? SignUp(changeTab) : SignIn(changeTab);
  }

  void changeTab () {
    setState(() {
      showSignUpPage = !showSignUpPage;
    });
  }
}