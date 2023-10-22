// ignore_for_file: use_build_context_synchronously

import 'package:contact_app/contacts/request.dart';
import 'package:contact_app/model/contact_model.dart';
import 'package:contact_app/utils/feedbacktoast.dart';
import 'package:flutter/material.dart';

class AppProvider extends ChangeNotifier {
  List<ContactInfo> contacts = [];

  Future<bool> createNewContact(
      ContactInfo contact, BuildContext context) async {
    final response = await ContactRequest.createNewContact(contact);

    if (response["status"]) {
      showFeedbackToast(context, response["message"],type: ToastType.success);
      final newContact = ContactInfo.fromJson(response["result"]);
      contacts.add(newContact);
      notifyListeners();
      return true;
    }
    showFeedbackToast(context, response["message"]);
    return false;
  }
}
