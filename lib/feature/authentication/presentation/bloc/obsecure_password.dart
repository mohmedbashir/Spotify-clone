import 'package:bloc/bloc.dart';

abstract class PasswordTFFState {
  // @override
  List<Object> get props => [];
}

class IsObsecure extends PasswordTFFState {}

class IsNotObsecure extends PasswordTFFState {}

class PasswordTFFCubit extends Cubit<PasswordTFFState> {
  PasswordTFFCubit() : super(IsObsecure());

  void turnOnObsecure() => emit(IsObsecure());

  void turnOffObsecure() => emit(IsNotObsecure());
}
