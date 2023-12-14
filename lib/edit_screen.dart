

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:social_app/component.dart';
import 'package:social_app/component.dart';
import 'package:social_app/cubit.dart';
import 'package:social_app/post_model.dart';
import 'package:social_app/setting.dart';
import 'package:social_app/socialLayout.dart';
import 'package:social_app/state.dart';

import 'component.dart';

class editScreen extends StatelessWidget {


  var nameController = TextEditingController();

  var phoneController = TextEditingController();

  var bioController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext) => AppCubit(),
      child: BlocConsumer<AppCubit, AppState>(
        listener: (BuildContext context, AppState state) {},
        builder: (BuildContext context, AppState state) {
          // var userModel = AppCubit.get(context).userModel;
          var profileImage = AppCubit.get(context).profileImage;
          var coverImage = AppCubit.get(context).coverImage;

          nameController.text = userModel.name;
          phoneController.text = userModel.phone;
          bioController.text = userModel.bio;



          return Scaffold(
            appBar: AppBar(
              title: Text('Edit Profile'),
              titleSpacing: 0,
              actions: [
                TextButton(onPressed: () {
                  AppCubit.get(context).updateUser(
                    name: nameController.text,
                    phone: phoneController.text,
                    bio: bioController.text,
                  );
                  saveStringToLocalStorage('name', userModel.name);
                  AppCubit.get(context).check();


                },
                  child: Text('Update',
                    style: TextStyle(
                        color: Colors.tealAccent
                    ),
                  ),
                ),
                SizedBox(width: 5,),
              ],
            ),




            body: Padding(
              padding: const EdgeInsets.all(5.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    if(state is Test)
                      LinearProgressIndicator(),
                    Column(
                      children: [
                        Container(
                          height: 260,
                          child: Stack(
                            alignment: AlignmentDirectional.bottomCenter,
                            children: [
                              Container(
                                alignment: AlignmentDirectional.topCenter,
                                child: Stack(
                                  alignment: AlignmentDirectional.topEnd,
                                  children: [
                                    Image(
                                      image: state is! AppCoverUpdatedSuccessState ? NetworkImage('${userModel.cover}') : FileImage(coverImage),
                                    ),
                                    IconButton(onPressed: () {
                                      AppCubit.get(context).getCover();
                                    },
                                      icon: CircleAvatar(
                                          child: Icon(Icons.camera_alt_outlined)),
                                    ),
                                  ],
                                ),
                              ),
                              Stack(
                                alignment: AlignmentDirectional.bottomEnd,
                                children: [
                                  CircleAvatar(
                                    radius: 47,
                                    backgroundColor: Colors.white,
                                    child: CircleAvatar(
                                      radius: 45,
                                      backgroundImage: state is! AppProfileUpdatedSuccessState
                                          ? NetworkImage('${userModel.image}')
                                          : FileImage(profileImage),
                                    ),
                                  ),
                                  IconButton(onPressed: () {
                                    AppCubit.get(context).getImage();
                                  },
                                    icon: CircleAvatar(
                                        radius: 15,
                                        child: Icon(
                                          Icons.camera_alt_outlined, size: 20,)),
                                  ),
                                ],
                              ),
                            ],
                          ),

                        ),

                        if(AppCubit.get(context).profileImage != null || AppCubit.get(context).coverImage != null)
                          Row(
                            children: [

                                Expanded(
                                  child: Column(
                                    children: [
                                      if(state is AppProfileLoadingSuccessState)
                                        LinearProgressIndicator(),
                                      if(AppCubit.get(context).profileImage != null && state is AppProfileSelectedSuccessState)
                                        OutlinedButton(onPressed: () {
                                          AppCubit.get(context).uploadProfileImage(
                                            name: nameController.text,
                                            phone: phoneController.text,
                                            bio: bioController.text,
                                          );
                                        },
                                          child: Text('UPDATE PROFILE IMAGE'),
                                        ),
                                    ],
                                  ),
                                ),




                                Expanded(
                                  child: Column(
                                    children: [
                                      if(state is AppCoverLoadingSuccessState)
                                        LinearProgressIndicator(),
                                      if(AppCubit.get(context).coverImage != null && state is AppCoverSelectedSuccessState)
                                      OutlinedButton(onPressed: () {
                                        AppCubit.get(context).uploadCoverImage(
                                          name: nameController.text,
                                          phone: phoneController.text,
                                          bio: bioController.text,
                                        );
                                      },
                                        child: Text('UPDATE COVER IMAGE'),
                                      ),
                                    ],
                                  ),
                                ),
                            ],
                          ),

                        TextFormField(
                          controller: nameController,
                          keyboardType: TextInputType.name,
                          validator: (String value) {
                            if (value.isEmpty) {
                              return 'please enter your name';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            label: Text('Name'),
                            prefixIcon: Icon(Icons.drive_file_rename_outline),
                          ),
                        ),
                        TextFormField(
                          controller: phoneController,
                          keyboardType: TextInputType.phone,
                          validator: (String value) {
                            if (value.isEmpty) {
                              return 'please enter your phone number';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            label: Text('Phone Number'),
                            prefixIcon: Icon(Icons.phone),
                          ),
                        ),
                        TextFormField(
                          controller: bioController,
                          keyboardType: TextInputType.text,
                          validator: (String value) {
                            if (value.isEmpty) {
                              return 'please enter your Bio';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            label: Text('Bio'),
                            prefixIcon: Icon(Icons.info_outlined),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

