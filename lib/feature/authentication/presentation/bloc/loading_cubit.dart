import 'package:bloc/bloc.dart';

abstract class LoadingState {
  // @override
  List<Object> get props => [];
}

class LoadingInProgress extends LoadingState {}

class LoadingCompleted extends LoadingState {}

class LoadingCubit extends Cubit<LoadingState> {
  LoadingCubit() : super(LoadingCompleted());

  void startLoading() => emit(LoadingInProgress());

  void stopLoading() => emit(LoadingCompleted());
}
