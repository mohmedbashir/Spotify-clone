import 'package:dartz/dartz.dart';
import 'package:spotify/feature/authentication/data/model/sign_response.dart';
// import 'package:spotify/feature/authentication/presentation/pages/signin.dart';

abstract class AuthRepository {
  Future<Either> signUp(SignRequest user);
  Future<Either> signIn(SignRequest user);
  signOut();
}
