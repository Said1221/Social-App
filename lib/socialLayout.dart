
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
              appBar: AppBar(title: Text(cubit.title[cubit.currentIndex]),
                actions: [
                  IconButton(onPressed: (){}, icon: Icon(Icons.notifications)),
                  IconButton(onPressed: (){}, icon: Icon(Icons.search)),
                  IconButton(onPressed: (){
                    navigateTo(context, addPost());
                  },
                      icon: Icon(Icons.post_add)),
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
                      Icons.home,
                    ),
                    label: 'Home',
                  ),

                  BottomNavigationBarItem(
                    icon: Icon(
                      Icons.chat,
                    ),
                    label: 'Chats',
                  ),

                  BottomNavigationBarItem(
                    icon: Icon(
                      Icons.supervised_user_circle,
                    ),
                    label: 'Users',
                  ),


                  BottomNavigationBarItem(
                    icon: Icon(
                      Icons.settings,
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
