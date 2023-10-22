// ignore_for_file: use_build_context_synchronously

import 'package:contact_app/contacts/request.dart';
import 'package:contact_app/model/contact_model.dart';
import 'package:contact_app/utils/feedbacktoast.dart';
import 'package:flutter/material.dart';

class AppProvider extends ChangeNotifier {
  List<ContactInfo> contacts = [];

  Future<bool> createNewContact(ContactInfo contact, BuildContext context,
      {String? image}) async {
    final response = await ContactRequest.createNewContact(contact);

    if (response["status"]) {
      showFeedbackToast(context, response["message"], type: ToastType.success);
      final newContact = ContactInfo.fromJson(response["result"]);
      if (image != null) {
        var response = await ContactRequest.uploadContactPicture(
            newContact.identifier, image);
        if (response["status"]) {
          newContact.profilePicture = response["result"];
        }
      }
      contacts.add(newContact);
      notifyListeners();
      return true;
    }
    showFeedbackToast(context, response["message"]);
    return false;
  }

  Future<bool> updateContact(ContactInfo contact, BuildContext context,
      {String? image}) async {
    final response = await ContactRequest.updateContact(contact);

    if (response["status"]) {
      showFeedbackToast(context, response["message"], type: ToastType.success);
      if (image != null) {
        var response = await ContactRequest.uploadContactPicture(
            contact.identifier, image);
        if (response["status"]) {
          contact.profilePicture = response["result"];
        }
      }
      contacts = contacts.map((e) {
        if (e.identifier == contact.identifier) {
          return contact;
        }
        return e;
      }).toList();
      notifyListeners();
      return true;
    }
    showFeedbackToast(context, response["message"]);
    return false;
  }

  Future<bool> deleteContact(
    String contactId,
    BuildContext context,
  ) async {
    final response = await ContactRequest.deleteContact(contactId);

    if (response["status"]) {
      showFeedbackToast(context, response["message"], type: ToastType.success);

      contacts.removeWhere((e) => e.identifier == contactId);
      notifyListeners();
      return true;
    }
    showFeedbackToast(context, response["message"]);
    return false;
  }

  Future<void> getAllContacts(BuildContext context,
      {bool shouldShowToast = false}) async {
    final response = await ContactRequest.getContacts();

    if (response["status"]) {
      if (shouldShowToast) {
        showFeedbackToast(context, response["message"],
            type: ToastType.success);
      }

      List<ContactInfo> allContacts = (response["result"] as List)
          .map((e) => ContactInfo.fromJson(e))
          .toList();
      contacts = allContacts;
      notifyListeners();
      return;
    }
    if (shouldShowToast) showFeedbackToast(context, response["message"]);
  }

  Future<bool> logOut(BuildContext context) async {

    // await 
    return false;
  }
}
