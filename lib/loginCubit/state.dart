
import 'package:flutter/material.dart';
import 'package:social_app/component.dart';
import 'package:social_app/cubit.dart';

BuildContext context;

class LoginState{}

class LoginInitialState extends LoginState{}

class LoginSuccessState extends LoginState{

  final String uId;
  LoginSuccessState(this.uId);


}

class LoginErrorState extends LoginState{}



