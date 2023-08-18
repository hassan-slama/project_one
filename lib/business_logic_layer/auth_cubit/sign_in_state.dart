part of 'sign_in_cubit.dart';

abstract class SignInState extends Equatable {
  const SignInState();
}

class SignInInitial extends SignInState {
  @override
  List<Object> get props => [];
}
class SignInLoadingState extends SignInState {
  @override
  List<Object> get props => [];
}

class SignInSuccessState extends SignInState {
  @override
  List<Object> get props => [];
}
class SignInErrorState extends SignInState {
  final String errmsg;
  const SignInErrorState(this.errmsg);
  @override
  List<Object> get props => [errmsg];
}

