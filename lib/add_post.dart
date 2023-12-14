
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:social_app/component.dart';
import 'package:social_app/cubit.dart';
import 'package:social_app/cubit.dart';
import 'package:social_app/feeds.dart';
import 'package:social_app/post_model.dart';
import 'package:social_app/socialLayout.dart';
import 'package:social_app/state.dart';

import 'cubit.dart';


class addPost extends StatelessWidget {


  @override
  Widget build(BuildContext context) {

    var postController = TextEditingController();

    return BlocProvider(
      create: (BuildContext)=>AppCubit(),
      child: BlocConsumer<AppCubit , AppState>(
          listener:(BuildContext context , AppState){},
          builder: (BuildContext context ,AppState state){
            return Scaffold(
              appBar: AppBar(
                titleSpacing: 0,
                title: Text('Create Post'),
                actions: [
                  TextButton(onPressed: (){
                    if(AppCubit.get(context).postImage == null) {
                      AppCubit.get(context).createPost(
                        date: DateTime.now().toString(),
                        text: postController.text,
                      );
                      // Navigator.pop(context);
                    }





                    if(AppCubit.get(context).postImage != null) {
                      AppCubit.get(context).uploadPostImage(
                        date: DateTime.now().toString(),
                        text: postController.text,
                      );
                      // Navigator.pop(context);
                    }
                    //
                    // if(state is AppSuccessState){
                    //   AppCubit.get(context).getPosts();
                    // }
                    // AppCubit.get(context).getPosts();


                  },
                    child: Text('Post',
                      style: TextStyle(
                        color: Colors.tealAccent,
                      ),
                    ),
                  ),
                  SizedBox(width: 5,),


                ],
              ),
              body: Column(
                children: [

                  if(state is AppLoadingPostsSuccessState)
                    LinearProgressIndicator(),

                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Row(
                      children: [
                        CircleAvatar(
                          backgroundImage: NetworkImage('${userModel.image}'),
                          radius: 30,
                        ),
                        SizedBox(width: 10,),
                        Text('${userModel.name}',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: TextFormField(
                      controller : postController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        label: Text('what is in your mind...'),
                      ),
                    ),
                  ),

                  if(state is AppPostSelectedSuccessState)
                  Expanded(
                    child: Container(
                      child: Image(
                        image:FileImage(AppCubit.get(context).postImage),
                      ),
                    ),
                  ),


                  TextButton(onPressed: (){
                    AppCubit.get(context).getPostImage();
                  },
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.photo),
                          SizedBox(width: 3,),
                          Text('add photo'),
                        ],
                      )
                  ),
                  SizedBox(height: 10,)
                ],
              ),
            );
            },
          ),
    );
  }
}
