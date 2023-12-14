
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/component.dart';
import 'package:social_app/cubit.dart';
import 'package:social_app/post_model.dart';
import 'package:social_app/regCubit/state.dart';
import 'package:social_app/registration_model.dart';

class regCubit extends Cubit<RegState>{

  regCubit() : super (RegInitialState());



  static regCubit get(context)=>BlocProvider.of(context);


  void userReg({
    String name,
    String email,
    String phone,
    String password,
}){
    emit(RegInitialState());
    FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password)
        .then((value){
          creatUser(
            name: name,
            email: email,
            phone: phone,
            Uid:value.user.uid,
          );
    }).catchError((error){
      print(error.toString());
      emit(RegErrorState());
    });
  }

  void creatUser({
    String name,
    String email,
    String phone,
    String Uid,

  }){
    regModel model = regModel(
      name : name,
      email: email,
      phone: phone,
      image: 'https://cdn-icons-png.flaticon.com/512/2815/2815428.png',
      cover: 'https://media.sproutsocial.com/uploads/2017/03/Facebook-Event-Photo.png',
      bio: 'write your bio...',
      Uid: Uid,
      isVerf: false,
    );

    FirebaseFirestore.instance.collection('user').doc(Uid).set(model.toMap())
    .then((value){
      // AppCubit.get(context).getUser();
      emit(RegCreateUserSuccessState());
    }).catchError((error){
      print(error.toString());
      errors = error.toString();
      emit(RegCreateUserErrorState());
    });

  }


}