import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/component.dart';
import 'package:social_app/cubit.dart';
import 'package:social_app/loginCubit/cubit.dart';
import 'package:social_app/loginCubit/state.dart';
import 'package:social_app/registration_model.dart';

class loginCubit extends Cubit<LoginState>{

  loginCubit(): super (LoginInitialState());

  static loginCubit get(context)=>BlocProvider.of(context);

  void userLogin({
    String email,
    String password
})
  {
    emit(LoginInitialState());
    FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password)
    .then((value){
      emit(LoginSuccessState(value.user.uid));
    }).catchError((error){
      print(error.toString());
      emit(LoginErrorState());
    });
  }



}