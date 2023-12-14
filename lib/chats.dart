
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:social_app/chattingScreen.dart';
import 'package:social_app/component.dart';
import 'package:social_app/cubit.dart';
import 'package:social_app/message_model.dart';
import 'package:social_app/registration_model.dart';
import 'package:social_app/state.dart';

class chatsScreen extends StatefulWidget {

  regModel userModel;

  chatsScreen({
    this.userModel,
  });





  @override
  State<chatsScreen> createState() => _chatsScreenState();
}

class _chatsScreenState extends State<chatsScreen> {
  @override
  Widget build(BuildContext context) {
          return BlocProvider(
            create: (BuildContext)=>AppCubit(),
            child: BlocConsumer<AppCubit , AppState>(
              listener: (BuildContext context , AppState state){},
              builder: (BuildContext context , AppState state){
                if (chats.length >0) {
                  return ListView.separated(
                  itemBuilder: (context , index)=>buildChatItems(chats[index] , context),
                  separatorBuilder: (context , index)=>myDivider(),
                  itemCount: chats.length,
                );
                }
                else
                  return Center(child: Text('NO messages available',
                  style: TextStyle(fontSize: 20,fontStyle: FontStyle.italic),
                  ),
                  );

              },
            ),
          );
  }

  Widget buildChatItems(regModel usermodel , context)=>InkWell(
    onTap: (){
      navigateTo(context, chatting(
        userModel : usermodel,
      ));
      AppCubit.get(context).getMessage(
        receiverId: userModel.Uid,
      );
    },
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          CircleAvatar(
            radius: 20,
            backgroundImage: NetworkImage(usermodel.image),
          ),

          SizedBox(width: 5,),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Text(usermodel.name,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(width: 5,),
                  Icon(Icons.verified,
                    size: 20,
                    color: Colors.blue,
                  ),
                ],
              ),
            ],
          ),

        ],
      ),
    ),
  );
}
