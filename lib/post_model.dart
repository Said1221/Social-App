import 'package:social_app/registration_model.dart';

class postModel{
  String name;
  String image;
  String Uid;
  String date;
  String text;
  String postImage;

  postModel ({
    this.name,
    this.image,
    this.Uid,
    this.date,
    this.text,
    this.postImage,
  });


  postModel.fromJson(Map<String , dynamic> json){
    name = json['name'];
    image = json['image'];
    Uid = json['Uid'];
    date = json['date'];
    text = json['text'];
    postImage = json['postImage'];
  }

  Map<String , dynamic>toMap(){
    return{
      'name' :  name,
      'image' : image,
      'Uid' : Uid,
      'date' : date,
      'text' : text,
      'postImage' : postImage,
    };
  }

}