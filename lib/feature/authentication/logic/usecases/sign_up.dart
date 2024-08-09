import 'package:dartz/dartz.dart';
import 'package:spotify/core/usecase/usecase.dart';
import 'package:spotify/core/injection/service_locator.dart';
import 'package:spotify/feature/authentication/data/model/sign_response.dart';
import 'package:spotify/feature/authentication/logic/repositoy/auth_repo.dart';

class SignUpUseCase implements UseCase<Either, SignRequest> {
  @override
  Future<Either> call({SignRequest? params}) async {
    return serviceLocator<AuthRepository>().signUp(params!);
  }
}
