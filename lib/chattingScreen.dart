


import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/chats.dart';
import 'package:social_app/component.dart';
import 'package:social_app/cubit.dart';
import 'package:social_app/message_model.dart';
import 'package:social_app/registration_model.dart';
import 'package:social_app/state.dart';

import 'component.dart';

class chatting extends StatelessWidget {

  var chatController = TextEditingController();

  regModel userModel;

  chatting({
    this.userModel,
});

  @override
  Widget build (BuildContext context) {



    return Builder(
      builder: (BuildContext context){
        AppCubit.get(context).getMessage(
          receiverId: userModel.Uid,
        );
        return BlocProvider(
          create: (BuildContext)=>AppCubit(),
          child: BlocConsumer<AppCubit , AppState>(
            listener: (BuildContext context , AppState state){},
            builder: (BuildContext context , AppSatet){
              return Scaffold(
                  appBar: AppBar(
                    iconTheme: IconThemeData(color: Colors.black),
                    titleSpacing: 0,
                    title : Row(
                      children: [
                        CircleAvatar(
                          radius: 20,
                          backgroundImage: NetworkImage('${userModel.image}'),
                        ),

                        SizedBox(width: 5,),

                        Row(
                          children: [
                            Text('${userModel.name}',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black
                              ),
                            ),
                          ],
                        ),

                      ],
                    ),
                  ),
                body: Column(
                  children: [

                      Expanded(
                        child: ListView.separated(
                          itemBuilder: (context , index){

                            var message = messages[index];

                            if (userModel.Uid == message.senderId)
                              return buildMessagesSender(message);



                            return buildMessagesReceiver(message);


                          },
                          separatorBuilder: (context , index) => SizedBox(height: 5,),
                          itemCount: messages.length,
                        ),
                      ),


                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        decoration: BoxDecoration(
                          border: Border.all(),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: TextFormField(
                                  controller: chatController,
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: '  type your message...'
                                  ),
                                ),
                              ),
                            ),
                            MaterialButton(onPressed:(){
                              AppCubit.get(context).sendMessage(
                                  text: chatController.text,
                                  receiverId: userModel.Uid,
                                  date: DateTime.now().toString(),
                              );
                              AppCubit.get(context).getMessage(receiverId: userModel.Uid);
                              chatsScreen(
                                userModel: userModel,
                              );

                              chats = [];
                              chats.add(userModel);

                              // AppCubit.get(context).getConnections(receiverId: userModel.Uid);
                            },
                              minWidth: 1,
                              height: 50,
                              child: Icon(Icons.send,color: Colors.blue,),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),

              );
            },
          ),
        );
      },

    );
  }

  Widget buildMessagesSender(messageModel model)=> Align(

        alignment: AlignmentDirectional.topStart,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(10),
                topLeft: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ),
              color: Colors.grey[300],
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(model.text,
                style: TextStyle(fontSize: 15),
              ),
            ),
          ),
        ),
      );

  Widget buildMessagesReceiver(messageModel model)=>Align(
        alignment: AlignmentDirectional.bottomEnd,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(10),
                topLeft: Radius.circular(10),
                bottomLeft: Radius.circular(10),
              ),
              color: Colors.blue[200],
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(model.text,
                style: TextStyle(fontSize: 15),
              ),
            ),
          ),
        ),
      );

}
