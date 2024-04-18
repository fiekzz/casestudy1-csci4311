import 'package:flutter/foundation.dart';

class Constants {
  static const String prodDomain = 'casestudy1.api.fiekzz.com';
  static const String devDomain = '5a8e-167-71-207-71.ngrok-free.app';
  static const String domain = kDebugMode ? devDomain : prodDomain;
  static const String protocol = 'https';
}
