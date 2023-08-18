part of 'auth_cubit.dart';

abstract class AuthState extends Equatable {
  const AuthState();
}

class AuthInitial extends AuthState {
  @override
  List<Object> get props => [];
}
class AuthLoadingState extends AuthState {
  @override
  List<Object> get props => [];
}

class AuthSuccessState extends AuthState {
  @override
  List<Object> get props => [];
}
class AuthErrorState extends AuthState {
  final String errmsg;
  AuthErrorState(this.errmsg);
  @override
  List<Object> get props => [errmsg];
}

