import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:social_app/cubit.dart';
import 'package:social_app/message_model.dart';
import 'package:social_app/post_model.dart';
import 'package:social_app/registration_model.dart';

BuildContext context;

postModel modelOfPost;
regModel userModel;
List<postModel>posts = [];
List<regModel>users = [];
List<String>postsId = [];
List<messageModel>messages = [];
List<int>likes = [];

List<regModel>chats = [];

var p = FileImage(AppCubit.get(context).profileImage);

var c = FileImage(AppCubit.get(context).coverImage);

String errors ;


Future<void> saveStringToLocalStorage(String key, String value) async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  await pref.setString(key, value);
  print('data saved');
}

Future<String> getStringFromLocalStorage(String key) async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  var x = await pref.getString(key);
  return pref.getString(key);
}




Map<String, dynamic> selectedTimes = {
  "Pomodoro Setting": 15,
  "Rest Time Setting": 5,
  "Long Rest Time Setting": 15,
  "Term of Resting Time Setting": 5
};

constra(){
  String dd = json.encode(selectedTimes);
  saveStringToLocalStorage('content' , dd);
}








String id;

var UID;

var imageUrl;

var exImage = '' ;



// var imageUrl;



Widget myDivider() => Padding(
  padding: const EdgeInsetsDirectional.only(
    start: 20.0,
  ),
  child: Container(
    width: double.infinity,
    height: 1.0,
    color: Colors.grey[300],
  ),
);

void navigateTo(context , widget) => Navigator.push(
  context,
  MaterialPageRoute(
      builder: (context) => widget
  ),
);

void NavigatAndFinish (context , widget)=> Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => widget), (Route<dynamic>route) => false);







//   ConditionalBuilder(
//   condition: 1+1==2,
//   // AppCubit.get(context).model != null,
//   builder: (context){
//
//     // var model = AppCubit.get(context).model;
//
//     if(!FirebaseAuth.instance.currentUser.emailVerified){
//       return Container(
//         color: Colors.amberAccent,
//         child: Padding(
//           padding: const EdgeInsets.symmetric(
//             horizontal: 10,
//           ),
//           child: Row(
//             children: [
//               Icon(Icons.info_outlined),
//               SizedBox(
//                 width: 5,
//               ),
//               Expanded(child: Text('please verify your email')),
//               TextButton(onPressed: (){
//                 FirebaseAuth.instance.currentUser.sendEmailVerification()
//                     .then((value){
//                   Fluttertoast.showToast(
//                     msg: 'check your mail',
//                     timeInSecForIosWeb: 3,
//                     gravity: ToastGravity.BOTTOM,
//                     textColor: Colors.white,
//                     toastLength: Toast.LENGTH_LONG,
//                     fontSize: 16,
//                     backgroundColor: Colors.green,
//                   );
//
//                 }).catchError((error){
//
//                 });
//               },
//                 child: Text('SEND',
//                   style: TextStyle(
//                     color: Colors.blue,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       );
//     }
//
//   },
//   fallback: (context)=>Center(child: CircularProgressIndicator()),
// );