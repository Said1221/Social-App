
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/add_post.dart';
import 'package:social_app/component.dart';
import 'package:social_app/cubit.dart';
import 'package:social_app/state.dart';

class socialLayout extends StatelessWidget {


  @override
  Widget build(BuildContext context) {

    return BlocProvider(
      create: (BuildContext)=>AppCubit(),
      child: BlocConsumer<AppCubit , AppState>(
          listener: (BuildContext context , AppState state){},
          builder: (BuildContext context , AppState state){
            AppCubit cubit = AppCubit.get(context);
            return Scaffold(
              appBar: AppBar(title: Text(cubit.title[cubit.currentIndex] , style: TextStyle(color: Colors.black),),elevation: 0,
                actions: [
                  IconButton(onPressed: (){}, icon: Icon(Icons.notifications) , color: Colors.black,),
                  IconButton(onPressed: (){}, icon: Icon(Icons.search), color: Colors.black),
                  IconButton(onPressed: (){
                    navigateTo(context, addPost());
                  },
                      icon: Icon(Icons.post_add), color: Colors.black),
                ],
              ),


              body: cubit.screens[cubit.currentIndex],


              bottomNavigationBar: BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                currentIndex: cubit.currentIndex,
                selectedItemColor: Colors.teal,
                onTap: (index){
                  cubit.onItemTaped(index);
                },

                items: [
                  BottomNavigationBarItem(
                    icon: Icon(
                      Icons.home_outlined,
                    ),
                    label: 'Home',
                  ),

                  BottomNavigationBarItem(
                    icon: Image.asset(
                      'assets/chat.png',scale: 25,
                    ),
                    label: 'Chats',
                  ),

                  BottomNavigationBarItem(
                    icon: Image.asset(
                      'assets/group.png',scale: 25,
                    ),
                    label: 'Users',
                  ),


                  BottomNavigationBarItem(
                    icon: Icon(
                      Icons.settings_outlined,
                    ),
                    label: 'Setting',
                  ),
                ],
              ),

            );
      },
      ),
    );
  }
}
