import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify/core/injection/service_locator.dart';
import 'package:spotify/feature/home/logic/usecases/like_unlike_usecase.dart';

class LikeCubit extends Cubit<bool> {
  LikeCubit(bool initialValue) : super(initialValue);

  void toggle(String songId) {
    serviceLocator<LikeOrUnlikeSongUseCase>().call(params: songId);
    emit(!state);
  }
}
