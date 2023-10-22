// ignore_for_file: prefer_final_fields

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class UserData {

  // Create storage
  static late FlutterSecureStorage _storage;

  static String _token = '';
  static String _fullName = '';
  static String _email = '';
  static String _identifier = '';

  //getters for above fields

  static String get token => _token;
  static String get fullName => _fullName;
  static String get email => _email;
  static String get identifier => _identifier;

  //setters for above fields.
  //Sets the value and saves to hive

  static set token(String value) {
    _token = value;
    _storage.write(key:'access_token', value:value);
  }

  static set fullName(String value) {
    _fullName = value;
    _storage.write(key:'full_name', value:value);
  }


  static set email(String value) {
    _email = value;
    _storage.write(key:'email', value:value);
  }

  static set identifier(String value) {
    _identifier = value;
    _storage.write(key:'identifier', value:value);
  }


  static Future<void> initialize() async {

    // intializing and setting locally store user data 
    _storage = const FlutterSecureStorage();
    _token = await _storage.read(key:'access_token') ?? '';
    _fullName = await _storage.read(key:'full_name') ?? '';
    _email = await _storage.read(key:'email') ?? '';
    _identifier = await _storage.read(key:'identifier') ?? '';
  }
}