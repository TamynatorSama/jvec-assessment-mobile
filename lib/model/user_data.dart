import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class UserData {

  // Create storage
  static late FlutterSecureStorage _storage;

  static String token = '';
  static String _firstName = '';
  static String _lastName = '';
  static String _email = '';
  static String _identifier = '';

  //getters for above fields

  // static String get token => _token;
  static String get firstName => _firstName;
  static String get lastName => _lastName;
  static String get email => _email;
  static String get identifier => _identifier;

  //setters for above fields.
  //Sets the value and saves to hive

  // static set token(String value) {
  //   _token = value;
  //   _storage.write(key:'token', value:value);
  // }

  static set firstName(String value) {
    _firstName = value;
    _storage.write(key:'first_name', value:value);
  }

  static set lastName(String value) {
    _lastName = value;
    _storage.write(key:'last_name',value:value);
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
    _firstName = await _storage.read(key:'first_name') ?? '';
    _lastName = await _storage.read(key:'last_name') ?? '';
    _email = await _storage.read(key:'email') ?? '';
    _identifier = await _storage.read(key:'identifier') ?? '';
  }
}