import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:spotify/core/utils/snackbars.dart';
import 'package:spotify/feature/home/presentation/pages/root_page.dart';
import 'package:spotify/feature/authentication/presentation/pages/welcome.dart';
import 'package:spotify/feature/onBoarding/presentation/pages/on_boarding.dart';
// import 'package:spotify/core/utils/functions/save_auth_state.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key, required this.hasSeenOnBoarding});

  final bool hasSeenOnBoarding;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator.adaptive());
              } else if (snapshot.hasError) {
                pushSnackBar(title: "Error", info: "Please try again");
              }
              if (snapshot.data == null) {
                return hasSeenOnBoarding ? AuthPage() : OnBoardingPage();
              } else {
                return RootPage();
              }
            }));
  }
}
