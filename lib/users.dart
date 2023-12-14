


import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/chats.dart';
import 'package:social_app/registration_model.dart';
import 'package:social_app/state.dart';

import 'chattingScreen.dart';
import 'component.dart';
import 'cubit.dart';

class usersScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext)=>AppCubit(),
      child: BlocConsumer<AppCubit , AppState>(
        listener: (BuildContext context , AppState state){},
        builder: (BuildContext context , AppState state){
          return ListView.separated(
            itemBuilder: (context , index)=>buildChatItems(users[index] , context),
            separatorBuilder: (context , index)=>myDivider(),
            itemCount: users.length,
          );


        },
      ),
    );
  }

  Widget buildChatItems(regModel userModel , context)=>InkWell(
    onTap: (){
      navigateTo(context, chatting(
        userModel : userModel,
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
            backgroundImage: NetworkImage(userModel.image),
          ),

          SizedBox(width: 5,),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Text(userModel.name,
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
