import 'package:spotify/core/injection/service_locator.dart';
import 'package:spotify/feature/authentication/logic/repositoy/auth_repo.dart';
// import 'package:dartz/dartz.dart';
// import 'package:spotify/core/usecase/usecase.dart';
// import 'package:spotify/feature/authentication/data/model/sign_response.dart';

class SignOutUseCase {
  Future<void> call() async {
    return serviceLocator<AuthRepository>().signOut();
  }
}
