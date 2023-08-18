part of 'sign_up_cubit.dart';

abstract class SignUpState extends Equatable {
  const SignUpState();
}

class SignUpInitial extends SignUpState {
  @override
  List<Object> get props => [];
}
class SignUpLoading extends SignUpState {
  @override
  List<Object> get props => [];
}
class SignUpError extends SignUpState {
  final String msg;
  const SignUpError(this.msg);
  @override
  List<Object> get props => [msg];
}
class SignUpSuccess extends SignUpState {
  @override
  List<Object> get props => [];
}