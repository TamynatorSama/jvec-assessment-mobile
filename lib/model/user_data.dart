// ignore_for_file: prefer_final_fields

import 'dart:convert';

import 'package:contact_app/model/contact_model.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class UserData {
  // Create storage
  static late FlutterSecureStorage storage;

  static String _token = '';
  static String _fullName = '';
  static String _email = '';
  static String _identifier = '';
  static List<ContactInfo> userSavedContacts = [];

  //getters for above fields

  static String get token => _token;
  static String get fullName => _fullName;
  static String get email => _email;
  static String get identifier => _identifier;

  //setters for above fields.
  //Sets the value and saves to hive

  static set token(String value) {
    _token = value;
    storage.write(key: 'access_token', value: value);
  }

  static set fullName(String value) {
    _fullName = value;
    storage.write(key: 'full_name', value: value);
  }

  static set email(String value) {
    _email = value;
    storage.write(key: 'email', value: value);
  }

  static set identifier(String value) {
    _identifier = value;
    storage.write(key: 'identifier', value: value);
  }

  static Future<void> initialize() async {
    // intializing and setting locally store user data
    storage = const FlutterSecureStorage();
    _token = await storage.read(key: 'access_token') ?? '';
    _fullName = await storage.read(key: 'full_name') ?? '';
    _email = await storage.read(key: 'email') ?? '';
    _identifier = await storage.read(key: 'identifier') ?? '';
    await getSavedContact();
  }

  static Future<void> getSavedContact() async {
    if (await storage.containsKey(key: 'user_contacts')) {
      var parsedContact =
          jsonDecode(await storage.read(key: 'user_contacts') ?? "");

      userSavedContacts =
          (parsedContact as List).map((e) => ContactInfo.fromJson(e)).toList();
    }
  }
}
