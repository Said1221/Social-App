import 'dart:convert';

import 'package:social_app/registration_model.dart';

class regModel{
  String name;
  String email;
  String phone;
  String image;
  String cover;
  String bio;
  String Uid;
  bool isVerf;

  regModel ({
    this.name,
    this.email,
    this.phone,
    this.image,
    this.cover,
    this.bio,
    this.Uid,
    this.isVerf,
});

  regModel.fromJson(Map<String , dynamic> json){
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    image = json['image'];
    cover = json['cover'];
    bio = json['bio'];
    Uid = json['Uid'];
    isVerf = json['isVerf'];
  }

  Map<String , dynamic>toMap(){
    return{
      'name' :  name,
      'email' : email,
      'phone' : phone,
      'image' : image,
      'cover' : cover,
      'bio' : bio,
      'Uid' : Uid,
      'isVerf' : isVerf,
    };
  }

}