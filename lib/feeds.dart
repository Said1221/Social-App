
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/component.dart';
import 'package:social_app/component.dart';
import 'package:social_app/component.dart';
import 'package:social_app/cubit.dart';
import 'package:social_app/post_model.dart';
import 'package:social_app/state.dart';

import 'component.dart';

class feedsScreen extends StatefulWidget {


  @override
  State<feedsScreen> createState() => _feedsScreenState();
}

class _feedsScreenState extends State<feedsScreen> {
  @override
  Widget build(BuildContext context) {
            return BlocProvider(
              create: (BuildContext)=>AppCubit()..getPosts(),
              child: BlocConsumer<AppCubit , AppState>(
                listener: (BuildContext context , AppState state){
                },
                  builder: (BuildContext context , AppState state){
                    return ListView.separated(
                      itemBuilder: (context , index)=>buildPosts(posts[index] , context , index),
                      separatorBuilder: (context , index) => myDivider(),
                      itemCount: posts.length,
                    );
                  },
              ),
            );
  }



  Widget buildPosts(postModel modelOfPost , context , index)=>Padding(
    padding: const EdgeInsets.all(6.0),

    child: Card(
      elevation: 10,
      clipBehavior: Clip.antiAliasWithSaveLayer,

      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          child: Column(

            children: [

              Row(
                children: [
                  CircleAvatar(
                    radius: 20,
                    backgroundImage: NetworkImage('${modelOfPost.image}'),


                  ),

                  SizedBox(width: 5,),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(modelOfPost.name,
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
                      Text('${modelOfPost.date}',
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),

                ],
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: myDivider(),
              ),


              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('${modelOfPost.text}'),

                  SizedBox(height: 8,),

                  if(modelOfPost.postImage!=null)
                    Image(
                      image: NetworkImage('${modelOfPost.postImage}'),
                    ),
                ],
              ),

              SizedBox(
                height: 5,
              ),

              Row(
                children: [

                  Expanded(
                    child: Row(
                      children: [
                        ImageIcon(AssetImage('assets/like.png') , color: Colors.red, size: 20,),
                        SizedBox(width: 3,),
                        Text('0'),
                      ],
                    ),
                  ),

                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Icon(Icons.comment,color: Colors.yellow,size: 20,),
                        SizedBox(width: 3,),
                        Text('10 comment'),
                      ],
                    ),
                  ),

                ],
              ),

              SizedBox(height: 5,),

              myDivider(),

              SizedBox(height: 5,),


              Row(
                children: [


                  Expanded(
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 20,
                          backgroundImage: NetworkImage('${userModel.image}'),),
                        SizedBox(width: 5,),
                        
                        Expanded(child: Text('write a comment...')),
                      ],
                    ),
                  ),

                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(onPressed:(){
                          AppCubit.get(context).likePosts(postsId[index]);
                        }, icon: ImageIcon(AssetImage('assets/like.png',),color: Colors.red, size: 20,

                        ),
                        ),

                        Text('Like'),
                      ],
                    ),
                  )
                ],
              ),

            ],
          ),
        ),
      ),
    ),
  );
}







