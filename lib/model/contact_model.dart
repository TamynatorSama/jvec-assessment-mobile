import 'dart:convert';

import 'package:azlistview/azlistview.dart';

class ContactInfo extends ISuspensionBean {
  final String firstName;
  final String lastName;
  final String phoneNumber;
  String? profilePicture;
  String? facebook;
  String? twitter;
  String? email; 
  String? tagIndex;


  ContactInfo({
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    this.email,this.facebook,this.profilePicture="",this.twitter
  }){
    tagIndex = firstName[0];
  }
  @override
  String getSuspensionTag() => tagIndex!;


  Map<String,dynamic> toJson() {

    Map<String,dynamic> returnjson = {
    "first_name": firstName,
    "last_name": lastName,
    "phone_number": phoneNumber,
    "email":email,
    "profile_picture": profilePicture
  };

    if(email !=null){
      returnjson["email"] = email;
    }
    if(facebook !=null){
      returnjson["facebook"] = facebook;
    }
    if(twitter !=null){
      returnjson["twitter"] = twitter;
    }
    return returnjson;
  }


  

  @override
  String toString() => 'ContactInfo(firstname $firstName,lastname: $lastName, phonenumber: $phoneNumber)';


}