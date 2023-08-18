import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

// import '../../screens/home_screen.dart';
import '../../screens/servicies/firebase_auth.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());
void signIn(String email, String password, BuildContext context) {
  if(email.isEmpty||password.isEmpty){
    emit(AuthErrorState('Invalid Email Or Password'));
  }else{
    emit(AuthLoadingState());
    FirebaseAuthService.SignIn(email: email, password: password)
        .then(
            (credential) {
         emit(AuthSuccessState());
        },
        onError: (error) {
          if (error is FirebaseAuthException) {
            emit(AuthErrorState(error.code));
          } else {
            emit(AuthErrorState(error.toString()));
          }


        }
    );
  }

  }
}
