


import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/component.dart';
import 'package:social_app/component.dart';
import 'package:social_app/component.dart';
import 'package:social_app/component.dart';
import 'package:social_app/component.dart';
import 'package:social_app/cubit.dart';
import 'package:social_app/edit_screen.dart';
import 'package:social_app/registration_model.dart';
import 'package:social_app/state.dart';

import 'component.dart';

class settingScreen extends StatelessWidget {





  @override
  Widget build(BuildContext context) {

    return
      BlocProvider(
      create: (BuildContext)=>AppCubit(),
      child: BlocConsumer<AppCubit , AppState>(
          listener: (BuildContext context , AppState state){

          },
          builder: (BuildContext context , AppState state){



            return Container(
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Column(
                  children: [
                    Container(
                      height: 260,
                      child: Stack(
                        alignment: AlignmentDirectional.bottomCenter,
                        children: [

                          Container(
                              alignment: AlignmentDirectional.topCenter,
                              child: Image(image:  NetworkImage('${userModel.cover}'),)),


                          CircleAvatar(
                            radius: 47,
                            backgroundColor: Colors.white,
                            child: CircleAvatar(
                              radius: 45,
                              backgroundImage: NetworkImage('${userModel.image}'),
                            ),
                          ),
                        ],
                      ),
                    ),

                    Text('${userModel.name}',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    SizedBox(
                      height: 5,
                    ),

                    Text('${userModel.bio}',
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),

                    SizedBox(
                      height: 15,
                    ),

                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              Text('5.2K',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text('likes',
                                style: TextStyle(
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              Text('2',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text('posts',
                                style: TextStyle(
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              Text('1.5K',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text('followers',
                                style: TextStyle(
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              Text('500',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text('following',
                                style: TextStyle(
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    SizedBox(
                      height: 15,
                    ),


                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(

                        child: Row(
                          children: [
                            Expanded(
                              child: OutlinedButton(onPressed: (){
                                navigateTo(context, editScreen());
                              },
                                child: Text('Edit Profile',
                                  style: TextStyle(
                                    color: Colors.blue,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
      ),
    );
  }
}
