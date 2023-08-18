import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../screens/home_screen.dart';
import '../../screens/servicies/firebase_auth.dart';

part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit() : super(SignUpInitial());

  void signUp(String email,String password,String phone,String name,BuildContext context){
    if(email.isEmpty||password.isEmpty||phone.isEmpty||name.isEmpty){
      emit(const SignUpError("All fields must be filled"));
    }
    FirebaseAuthService.SignUp(
        email: email,
        password: password,
        phone: phone,
        name: name
    )
        .then(

            (credential){
          FirebaseFirestore.instance.collection("users").doc(credential.user?.uid);
          Navigator.pushAndRemoveUntil(context,
              MaterialPageRoute(
                  builder: (builder)=>const HomeScreen()

              ),
          (route) => false,
          );

        },
        onError: (error){
      if(error is FirebaseAuthException){
        emit(SignUpError(error.code));
      }else{
        emit(SignUpError(error.toString()));
      }
    }
    );
  }
}
