import 'package:contact_app/contacts/request.dart';
import 'package:contact_app/model/contact_model.dart';
import 'package:flutter/material.dart';

class AppProvider extends ChangeNotifier{

  List<ContactInfo> contacts=[];

  Future<void> createNewContact(ContactInfo contact)async{

    await ContactRequest.createNewContact(contact);


  } 

}
