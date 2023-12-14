

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_app/add_post.dart';
import 'package:social_app/component.dart';
import 'package:social_app/feeds.dart';
import 'package:social_app/loginCubit/state.dart';
import 'package:social_app/message_model.dart';
import 'package:social_app/post_model.dart';
import 'package:social_app/registration_model.dart';
import 'package:social_app/chats.dart';
import 'package:social_app/setting.dart';
import 'package:social_app/state.dart';
import 'package:social_app/users.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class AppCubit extends Cubit<AppState>{

  AppCubit() : super(AppInitialState());


  static AppCubit get(context) => BlocProvider.of(context);



  int currentIndex = 0;

  List<Widget>screens = [
    feedsScreen(),
    chatsScreen(),
    usersScreen(),
    settingScreen()
  ];



  List<String>title = [
    'Home',
    'Chats',
    'Users',
    'Setting'
  ];
  void onItemTaped(int index){
    // if(index==1){
    //   getAllUsers();
    // }

    currentIndex = index;
    emit(ChangeBottomNav());
  }


  void getUser(){
    emit(AppInitialState());
      FirebaseFirestore.instance.collection('user').doc(UID).get()
        .then((value){
          userModel = regModel.fromJson(value.data());
          // getAllUsers();
       // emit(AppSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(AppErrorState());
      });
  }

  void check(){
    emit(Test());
  }

  void uploadProfileImage({
    @required String name,
    @required String phone,
    @required String bio,
}){
    emit(AppProfileLoadingSuccessState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('user/${Uri.file(profileImage.path)
        .pathSegments.last}').putFile(profileImage)

        .then((value){
          value.ref.getDownloadURL()
              .then((value){

            updateUser(
                name: name,
                phone: phone,
                bio: bio,
                image: value,
            );
            emit(AppProfileUpdatedSuccessState());
          }).catchError((error){print(error.toString());});
    }).catchError((error){print(error.toString());});
  }


  void uploadCoverImage({
    @required String name,
    @required String phone,
    @required String bio,
}){
    emit(AppCoverLoadingSuccessState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(coverImage.path)
        .pathSegments.last}').putFile(coverImage)
        .then((value){
      value.ref.getDownloadURL()
          .then((value){
        print(value);
        updateUser(
            name: name,
            phone: phone,
            bio: bio,
            cover:value,
        );
        emit(AppCoverUpdatedSuccessState());
      }).catchError((error){print(error.toString());});
    }).catchError((error){print(error.toString());});
  }


  void updateUser({
    String name,
    String phone,
    String bio,
    String cover,
    String image,

  }){

    regModel model = regModel(
      name : name,
      email: userModel.email,
      phone: phone,
      cover: cover??userModel.cover,
      image: image??userModel.image,
      Uid: userModel.Uid,
      bio: bio,
      // Uid: userModel.Uid,
    );

      FirebaseFirestore.instance.collection('user').doc(UID).update(model.toMap())
        .then((value){
      getUser();
      emit(AppDataSuccessUpdatedState());
    }).catchError((error){
      print(error.toString());
    });

  }


  void createPost({
    @required String date,
    @required String text,
    String postImage,

  }){


    postModel modelPost = postModel(
      name : userModel.name,
      image: userModel.image,
      Uid: userModel.Uid,
      date: date,
      text: text,
      postImage: postImage,
    );


    emit(AppLoadingPostsSuccessState());
    FirebaseFirestore.instance.collection('posts').add(modelPost.toMap()) //يضيف ب id عشوائي
        .then((value){
          getPosts();
      emit(AppPostsSuccessState());
    }).catchError((error){
      print(error.toString());
    });
  }

  void uploadPostImage({
     String name,
     String Uid,
     String image,
     String date,
     String text,
}){
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('posts/${Uri.file(postImage.path)
        .pathSegments.last}').putFile(postImage)
        .then((value){
      value.ref.getDownloadURL()
          .then((value){
        createPost(
            date: date,
            text: text,
            postImage: value,
        );
        imageUrl = value;

      });
    }).catchError((error){});
  }


  void getPosts(){
     FirebaseFirestore.instance.collection('posts').get().then((value){
      value.docs.forEach((element){
        posts = [];
        modelOfPost = postModel.fromJson(element.data());
        element.reference.collection('Likes').get().then((value){
          likes.add(value.docs.length);
          postsId.add(element.id);
          posts.add(postModel.fromJson(element.data()));
        }).catchError((error){
        });
      });
    }).catchError((error){
      print(error.toString());
    });
  }










  void likePosts(String postId){
    FirebaseFirestore.instance.collection('posts').doc(postId).collection('Likes').doc(userModel.Uid)
        .set({'Like' : true}).then((value){
          emit(AppPostLikeSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(AppPostLikeErrorState());
    });
  }



  void getAllUsers(){
    FirebaseFirestore.instance.collection('user').get().then((value){
      value.docs.forEach((element){
        if(element.data()['Uid']!=userModel.Uid)
          users.add(regModel.fromJson(element.data()));
        // getPosts();
      });
    }).catchError((error){
      print(error.toString());
    });
  }

  void sendMessage({
    @required String text,
    String senderId,
    @required String receiverId,
    @required String date,
}){
    messageModel message = messageModel(
      text: text,
      senderId: userModel.Uid,
      receiverId: receiverId,
      date: date,
    );
    FirebaseFirestore.instance.collection('user').doc(userModel.Uid).collection('chats')
    .doc(receiverId).collection('messages').add(message.toMap()).then((value){
      print('message gooo');
    }).catchError((error){
      print('message noooo');
    });

    FirebaseFirestore.instance.collection('user').doc(receiverId).collection('chats')
        .doc(userModel.Uid).collection('messages').add(message.toMap()).then((value){
      print('message gooo');
    }).catchError((error){
      print('message noooo');
    });

  }


  void getMessage({
  @required String receiverId,
}){
    FirebaseFirestore.instance.collection('user').doc(userModel.Uid).collection('chats').doc(receiverId)
        .collection('messages').orderBy('date').snapshots().listen((event){
          messages = [];
          event.docs.forEach((element){
            messages.add(messageModel.fromJson(element.data()));
          });
          emit(AppGetMessageSuccessState());

    });
  }









  File profileImage;
  var pickerImage = ImagePicker();
  Future<void>getImage()async{
    final pickedFile = await pickerImage.getImage(
      source: ImageSource.gallery,
    );
    if(pickedFile !=null){
      profileImage = File(pickedFile.path);
      emit(AppProfileSelectedSuccessState());
    }
    else{
      print('No image selected');
    }
  }


  File coverImage;
  var x;
  var pickerCover = ImagePicker();
  Future<void>getCover()async{
    final pickedFile = await pickerCover.getImage(
      source: ImageSource.gallery,
    );
    if(pickedFile !=null){
      coverImage = File(pickedFile.path);
      x = coverImage = File(pickedFile.path);
      emit(AppCoverSelectedSuccessState());
    }
    else{
      print('No cover selected');
    }
  }


  File postImage;
  var pickerPost = ImagePicker();
  Future getPostImage()async{
    final pickedFile = await pickerPost.getImage(
      source: ImageSource.gallery,
    );
    if(pickedFile !=null){
      postImage = File(pickedFile.path);
      emit(AppPostSelectedSuccessState());
    }
    else{
      print('No image selected');
    }
  }











}


















// void updateUserImages({
//   @required String name,
//   @required String phone,
//   @required String bio,
//
// }){
//   if(coverImage != null){
//     uploadCoverImage();
//   }
//   else if (profileImage != null){
//     uploadProfileImage();
//   }
//   else if (coverImage != null && profileImage != null){
//
//   }
//   else{
//     updateUser(
//         name: name,
//         phone: phone,
//         bio: bio
//     );
//   }
// }


















