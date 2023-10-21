import 'dart:convert';

import 'package:azlistview/azlistview.dart';

class ContactInfo extends ISuspensionBean {
  String name;
  String? tagIndex;
  String? phoneNumber;


  ContactInfo({
    required this.name,
    
    this.phoneNumber,
  }){
    tagIndex = name[0];
  }
  @override
  String getSuspensionTag() => tagIndex!;

  @override
  String toString() => json.encode(this);


}