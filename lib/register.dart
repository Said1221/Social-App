
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:social_app/component.dart';
import 'package:social_app/cubit.dart';
import 'package:social_app/login.dart';
import 'package:social_app/regCubit/cubit.dart';
import 'package:social_app/regCubit/state.dart';

class registerScreen extends StatelessWidget {

  var formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {

    return BlocProvider(
      create: (BuildContext)=>regCubit(),
      child: BlocConsumer<regCubit , RegState>(
        listener: (BuildContext context , RegState state){

          if(state is RegCreateUserSuccessState){

            Fluttertoast.showToast(
              msg: 'Register Success',
              timeInSecForIosWeb: 3,
              gravity: ToastGravity.BOTTOM,
              textColor: Colors.white,
              toastLength: Toast.LENGTH_LONG,
              fontSize: 16,
              backgroundColor: Colors.green,
            );

            NavigatAndFinish(context, loginScreen());
          }

           if (state is RegCreateUserErrorState){
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

        },
          builder: (BuildContext context , RegState state){

            var nameController = TextEditingController();
            var emailController = TextEditingController();
            var phoneController = TextEditingController();
            var passwordController = TextEditingController();

          regCubit cubit = regCubit.get(context);
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
                          'Create an account',
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
                          controller: nameController,
                          keyboardType: TextInputType.text,
                          validator: (value){
                            if(value.isEmpty){
                              return 'please enter your name';
                            }
                          },
                          decoration: InputDecoration(
                              label: Text('Name'),
                              prefixIcon:Icon(
                                Icons.person,
                              )
                          ),
                        ),
                        TextFormField(
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          validator: (value){
                            if(value.isEmpty){
                              return 'please enter your Email address';
                            }
                          },
                          decoration: InputDecoration(
                              label: Text('Email Address'),
                              prefixIcon: Icon(
                                Icons.email,
                              )
                          ),
                        ),
                        TextFormField(
                          controller: phoneController,
                          keyboardType: TextInputType.phone,
                          validator: (value){
                            if(value.isEmpty){
                              return 'please enter your phone number';
                            }
                          },
                          decoration: InputDecoration(
                              label: Text('Phone Number'),
                              prefixIcon:Icon(
                                Icons.phone,
                              )
                          ),
                        ),
                        TextFormField(
                          controller: passwordController,
                          obscureText: true,
                          keyboardType: TextInputType.visiblePassword,
                          validator: (value){
                            if(value.isEmpty){
                              return 'please enter your password';
                            }
                          },
                          decoration: InputDecoration(
                              label: Text('Password'),
                              prefixIcon: Icon(
                                Icons.lock,
                              ),
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          child: MaterialButton(onPressed: (){
                            // if(formKey.currentState.validate()){
                              cubit.userReg(
                                name: nameController.text,
                                email: emailController.text ,
                                phone: phoneController.text,
                                password: passwordController.text ,
                              );
                            // }
                          },
                            shape: new RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            color: Colors.blue,
                            child: Text('Register',
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.white,
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
          },
      ),
    );
  }
}
