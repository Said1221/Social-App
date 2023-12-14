import 'package:social_app/registration_model.dart';

class messageModel{
  String text;
  String receiverId;
  String senderId;
  String date;

  messageModel ({
    this.text,
    this.receiverId,
    this.senderId,
    this.date,
  });


  messageModel.fromJson(Map<String , dynamic> json){
    text = json['text'];
    receiverId = json['receiverId'];
    senderId = json['senderId'];
    date = json['date'];
  }

  Map<String , dynamic>toMap(){
    return{
      'text' :  text,
      'receiverId' : receiverId,
      'senderId' : senderId,
      'date' : date,
    };
  }

}