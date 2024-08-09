import 'package:get_it/get_it.dart';
import 'package:spotify/feature/home/logic/repositoy/song_repo.dart';
import 'package:spotify/feature/home/data/repository/song_repo_imp.dart';
import 'package:spotify/feature/authentication/logic/usecases/sign_In.dart';
import 'package:spotify/feature/authentication/logic/usecases/sign_up.dart';
import 'package:spotify/feature/home/data/source/firebase_data_source.dart';
import 'package:spotify/feature/authentication/logic/usecases/sign_out.dart';
import 'package:spotify/feature/home/logic/usecases/like_unlike_usecase.dart';
import 'package:spotify/feature/authentication/logic/repositoy/auth_repo.dart';
import 'package:spotify/feature/home/logic/usecases/fetch_songs_usecasse.dart';
import 'package:spotify/feature/home/logic/usecases/check_if_liked_usecase.dart';
import 'package:spotify/feature/home/logic/usecases/fetch_liked_sings_usecase.dart';
import 'package:spotify/feature/authentication/data/source/auth_service_data_source.dart';
import 'package:spotify/feature/authentication/data/repository/auth_repo_implementation.dart';

final serviceLocator = GetIt.instance;

Future<void> initializeDependencies() async {
//Auth Feature
  serviceLocator.registerSingleton<AuthDataSourse>(AuthDataSourceImpl());
  serviceLocator.registerSingleton<AuthRepository>(AuthRepoImplementation());
  serviceLocator.registerSingleton<SignUpUseCase>(SignUpUseCase());
  serviceLocator.registerSingleton<SignInUseCase>(SignInUseCase());
  serviceLocator.registerSingleton<SignOutUseCase>(SignOutUseCase());

//Home Feature
  serviceLocator
      .registerSingleton<SongsDataSource>(SongsDataSourceImplementation());
  serviceLocator.registerSingleton<SongRepository>(SongRepositoryImpl());
  serviceLocator.registerSingleton<FetchSongsUsecase>(FetchSongsUsecase());
  serviceLocator
      .registerSingleton<LikeOrUnlikeSongUseCase>(LikeOrUnlikeSongUseCase());
  serviceLocator.registerSingleton<CheckIfLikedUsecase>(CheckIfLikedUsecase());
  serviceLocator
      .registerSingleton<FetchLikedSongsUsecase>(FetchLikedSongsUsecase());
}
