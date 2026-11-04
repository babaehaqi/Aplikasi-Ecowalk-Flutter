import 'dart:convert';
import 'dart:typed_data';

import 'package:shared_preferences/shared_preferences.dart';

/// Profile persisted locally for the current prototype.
class EcowalkProfile {
  EcowalkProfile._();

  static final EcowalkProfile instance = EcowalkProfile._();

  String name = 'KAYI NYAP NYAP';
  String email = 'kayimail@gmail.com';
  String phone = '+629593599593';
  Uint8List? photoBytes;
  bool accountDeletionRequested = false;

  Future<void> load() async {
    final preferences = await SharedPreferences.getInstance();
    name = preferences.getString('profile.name') ?? name;
    email = preferences.getString('profile.email') ?? email;
    phone = preferences.getString('profile.phone') ?? phone;
    final encodedPhoto = preferences.getString('profile.photo');
    if (encodedPhoto != null) {
      try {
        photoBytes = base64Decode(encodedPhoto);
      } on FormatException {
        await preferences.remove('profile.photo');
      }
    }
  }

  Future<void> save() async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.setString('profile.name', name);
    await preferences.setString('profile.email', email);
    await preferences.setString('profile.phone', phone);
    final bytes = photoBytes;
    if (bytes != null) {
      await preferences.setString('profile.photo', base64Encode(bytes));
    }
  }
}
