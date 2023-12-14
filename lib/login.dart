
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:social_app/cache_helper.dart';
import 'package:social_app/component.dart';
import 'package:social_app/cubit.dart';
import 'package:social_app/feeds.dart';
import 'package:social_app/loginCubit/cubit.dart';
import 'package:social_app/loginCubit/state.dart';
import 'package:social_app/main.dart';
import 'package:social_app/register.dart';
import 'package:social_app/socialLayout.dart';

class loginScreen extends StatelessWidget {

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {


    var emailController = TextEditingController();
    var passwordController = TextEditingController();

    return BlocProvider(
      create: (BuildContext)=>loginCubit(),
      child: BlocConsumer <loginCubit , LoginState>(
        // ignore: void_checks
        listener: (BuildContext context ,LoginState state){

          if(state is LoginErrorState){
            Fluttertoast.showToast(
                msg: 'Invalid User',
                timeInSecForIosWeb: 3,
                gravity: ToastGravity.BOTTOM,
                textColor: Colors.white,
                toastLength: Toast.LENGTH_LONG,
                fontSize: 16,
                backgroundColor: Colors.red,
            );
          }

          else if(state is LoginSuccessState) {
            CacheHelper.saveData(
              key: 'uId',
              value: state.uId,
            ).then((value) {
              UID = CacheHelper.getData(key: 'uId');

              Fluttertoast.showToast(
                msg: 'Login success',
                timeInSecForIosWeb: 3,
                gravity: ToastGravity.BOTTOM,
                textColor: Colors.white,
                toastLength: Toast.LENGTH_LONG,
                fontSize: 16,
                backgroundColor: Colors.green,
              );
              AppCubit()..getUser()..getAllUsers()..getPosts();
            });
            navigateTo(context,
              AnimatedSplashScreen(splash: Center(child: CircularProgressIndicator()),duration: 300,
                backgroundColor: Colors.white,
                nextScreen: socialLayout(),
              ),
            );

          }




        },
          builder: (BuildContext context , LoginState state){

          loginCubit cubit = loginCubit.get(context);
          return SafeArea(
            child: Scaffold(
              body: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: SingleChildScrollView(
                    child: Column(
                      key: formKey,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Login Screen',
                          style: TextStyle(
                            color: Colors.blue,
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          validator: (value){
                            if(value.isEmpty){
                              return 'please enter your email address';
                            }
                          },
                          decoration: InputDecoration(
                              label: Text('Email Address'),
                              prefixIcon:Icon(
                                Icons.email,
                              )
                          ),
                        ),
                        TextFormField(
                          controller: passwordController,
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: true,
                          validator: (value){
                            if(value.isEmpty){
                              return 'please enter your password';
                            }
                          },
                          decoration: InputDecoration(
                              label: Text('Password'),
                              prefixIcon: Icon(
                                Icons.lock,
                              )
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          child: MaterialButton(onPressed: (){
                            cubit.userLogin(
                                email: emailController.text ,
                                password: passwordController.text,
                            );
                          },
                            shape: new RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            color: Colors.blue,
                            child: Text('Login',
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Center(
                          child: TextButton(onPressed: (){
                            navigateTo(context, registerScreen());
                          },
                            child: Text('Create an account',
                              style: TextStyle(
                                color: Colors.blue,
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
          }
      ),
    );
  }
}
