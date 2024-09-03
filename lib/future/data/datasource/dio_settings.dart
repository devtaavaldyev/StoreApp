import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class DioSettings {
  DioSettings() {
    setup();
  }
  final Dio dio = Dio(
    BaseOptions(
      baseUrl: 'https://fakestoreapi.com/',
      receiveTimeout: const Duration(seconds: 3),
      connectTimeout: const Duration(seconds: 5),
      sendTimeout: const Duration(seconds: 5),
    ),
  );

  void setup() {
    final interceptors = dio.interceptors;

    interceptors.clear();

    final logInterceptor = LogInterceptor(
      request: true,
      requestBody: true,
      requestHeader: true,
      responseBody: true,
      responseHeader: true,
      error: true,
    );

    final headerInterseptors = QueuedInterceptorsWrapper(
      onRequest: (options, handler) {
        log('ON REQUEST');
        return handler.next(options);
      },
      onError: (DioError error, handler) {
        log('ON ERROR');

        handler.next(error);
      },
      onResponse: (response, handler) {
        log('ON Response');
        return handler.next(response);
      },
    );

    interceptors.addAll([
      logInterceptor,
      headerInterseptors,
    ]);
  }
}
