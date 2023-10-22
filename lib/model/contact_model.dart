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
    this.email,this.facebook,this.profilePicture,this.twitter
  }){
    tagIndex = firstName[0];
  }
  @override
  String getSuspensionTag() => tagIndex!;


  @override
  String toString() => json.encode(this);


}