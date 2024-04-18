import 'package:casestudy1/component/p_dio.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class PFetchException implements Exception {
  final String message;

  const PFetchException(this.message);
}

class PFetch {
  final String url;
  final PFetchMethod method;
  final Object? body;
  final Map<String, dynamic>? queryParameters;
  final Function(int? sent, int? total)? onSendProgress;

  PFetch(
    this.url, {
    required this.method,
    this.body,
    this.onSendProgress,
    this.queryParameters,
  });

  Future<dynamic> authorizedRequest() async {
    final agDio = DioFactory().getDio();

    final storage = FlutterSecureStorage();

    final token = await storage.read(key: 'token');

    final response = await agDio.request(
      url,
      data: body,
      queryParameters: queryParameters,
      options: Options(
        method: method.name,
        headers: {
          'Authorization': 'Bearer $token',
        },
      ),
    );

    if (response.statusCode != 200) {
      throw PFetchException(response.data['message'] ??
          'Something went wrong. Please try again later.');
    }

    return response.data;
  }

  Future<dynamic> request() async {
    final agDio = DioFactory().getDio();

    final response = await agDio.request(
      url,
      data: body,
      options: Options(
        method: method.name,
      ),
      onSendProgress: onSendProgress,
    );

    if (response.statusCode != 200) {
      print(response);
      print(response.data.runtimeType);

      if (response.data.runtimeType == String) {
        print('here');
        throw PFetchException(
          response.data ?? 'Something went wrong. Please try again later.',
        );
      } else {
        throw PFetchException(
          response.data['message'] ??
              'Something went wrong. Please try again later.',
        );
      }
    }

    return response.data;
  }
}

enum PFetchMethod {
  GET,
  POST,
  PUT,
  DELETE,
}
