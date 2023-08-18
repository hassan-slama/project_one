import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

// import '../../screens/home_screen.dart';
import '../../screens/servicies/firebase_auth.dart';

part 'sign_in_state.dart';

class SignInCubit extends Cubit<SignInState> {
  SignInCubit() : super(SignInInitial());
void signIn(String email, String password, BuildContext context) {
  if(email.isEmpty||password.isEmpty){
    emit(const SignInErrorState('Invalid Email Or Password'));
  }else{
    emit(SignInLoadingState());
    FirebaseAuthService.SignIn(email: email, password: password)
        .then(
            (credential) {
         emit(SignInSuccessState());
        },
        onError: (error) {
          if (error is FirebaseAuthException) {
            emit(SignInErrorState(error.code));
          } else {
            emit(SignInErrorState(error.toString()));
          }


        }
    );
  }

  }
}
