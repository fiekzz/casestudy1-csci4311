import 'dart:convert';

import 'package:casestudy1/utils/models/user_token_model.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jwt_decode/jwt_decode.dart';

class PGetToken {
  static Future<String?> getRawToken() async {
    const storage = FlutterSecureStorage();

    final token = await storage.read(key: 'token');

    return token;
  }

  static UserTokenModel tokenParser(String token) {
    Map<String, dynamic> tokenMap = Jwt.parseJwt(token);

    final resToken = UserTokenModel.fromJson(tokenMap);

    return resToken;
  }
}
