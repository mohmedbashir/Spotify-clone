import 'package:get/get.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:spotify/core/helpers/failures.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:spotify/feature/authentication/data/model/sign_response.dart';
import 'package:spotify/feature/authentication/presentation/pages/welcome.dart';
// import 'package:flutter/material.dart';
// import 'package:spotify/core/router/app_routes.dart';
// import 'package:spotify/feature/authentication/presentation/pages/signin.dart';

abstract class AuthDataSourse {
  Future<Either> signIn(SignRequest user);
  Future<Either> signUp(SignRequest user);
  signOut();
}

final usersDocRef = FirebaseFirestore.instance.collection('users');

class AuthDataSourceImpl extends AuthDataSourse {
  FirebaseAuth auth = FirebaseAuth.instance;
  @override
  @override
  Future<Either> signUp(SignRequest user) async {
    try {
      await auth.createUserWithEmailAndPassword(
          email: user.email, password: user.password);
      auth.currentUser!.updateDisplayName(user.name);
      await usersDocRef
          .doc(auth.currentUser!.uid)
          .set({'name': user.name, 'email': user.email});
      return Right(auth.currentUser!.uid);
    } on FirebaseAuthException catch (e) {
      String message = handleFirebaseAuthError(e);

      return Left(message);
    }
  }

  @override
  Future<Either> signIn(SignRequest user) async {
    try {
      await auth.signInWithEmailAndPassword(
          email: user.email, password: user.password);
      return const Right("sucsessfull");
    } on FirebaseAuthException catch (e) {
      String message = handleFirebaseAuthError(e);
      return Left(message);
    }
  }

  @override
  signOut() {
    // Get.until(predicate)
    // Get.offNamed(Routes.signInPage);
    auth.signOut();
    Get.offAll(const AuthPage());
  }
}
