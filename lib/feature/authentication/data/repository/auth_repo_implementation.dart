import 'package:dartz/dartz.dart';
import 'package:spotify/core/injection/service_locator.dart';
import 'package:spotify/feature/authentication/data/model/sign_response.dart';
import 'package:spotify/feature/authentication/logic/repositoy/auth_repo.dart';
import 'package:spotify/feature/authentication/data/source/auth_service_data_source.dart';

class AuthRepoImplementation extends AuthRepository {
  @override
  signOut() async {
    await serviceLocator<AuthDataSourse>().signOut();
  }

  @override
  Future<Either> signUp(SignRequest user) async {
    return await serviceLocator<AuthDataSourse>().signUp(user);
  }

  @override
  Future<Either> signIn(SignRequest user) async {
    return await serviceLocator<AuthDataSourse>().signIn(user);
  }
}
