import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/cache_helper.dart';
import 'package:social_app/component.dart';
import 'package:social_app/cubit.dart';
import 'package:social_app/feeds.dart';
import 'package:social_app/login.dart';
import 'package:social_app/regCubit/cubit.dart';
import 'package:social_app/regCubit/state.dart';
import 'package:social_app/register.dart';
import 'package:social_app/registration_model.dart';
import 'package:social_app/socialLayout.dart';
import 'package:social_app/state.dart';

import 'loginCubit/state.dart';

// Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//   print('firebaseMessagingBackgroundHandler');
// }



void main() async{


  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();


  //كل جهاز بيسجل في الاب بيبقي ليه توكين زي بالظبط unique id
  // var token = await FirebaseMessaging.instance.getToken();
  // print(token);


  // FirebaseMessaging.onMessage.listen((event){
  //   print(event.data.toString());
  // });
  //
  // FirebaseMessaging.onMessageOpenedApp.listen((event){
  //   print(event.data.toString());
  // });
  //
  // FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);



  await CacheHelper.init();
  Widget widget;



  UID = CacheHelper.getData(key: 'uId');


  if (UID != null){
    widget = AnimatedSplashScreen(splash: Center(child: CircularProgressIndicator()),duration: 300,
      backgroundColor: Colors.white,
      nextScreen: socialLayout(),
    );
  }
  else{
    widget = loginScreen();
  }



  runApp(MyApp(
    startWidget: widget,

  ));
}


class MyApp extends StatelessWidget {

  final Widget startWidget;

  MyApp({
    this.startWidget,
});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context)=>AppCubit()..getUser()..getAllUsers()..getPosts(),
      child: BlocConsumer<AppCubit , AppState>(
        listener: (BuildContext context , AppState state){},
          builder: (BuildContext context , AppState state){

            return MaterialApp(


            theme: ThemeData(
              appBarTheme: AppBarTheme(
                color: Colors.white,
                titleTextStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),

            home: AnimatedSplashScreen(splash: Image.asset('assets/chat.png',color: Colors.white,),splashIconSize: 100,
              duration: 3000,
              splashTransition: SplashTransition.fadeTransition,
              backgroundColor: Colors.green,
              nextScreen: startWidget,
            ),
            debugShowCheckedModeBanner: false,

          );
          },
      ),
    );
  }
}




