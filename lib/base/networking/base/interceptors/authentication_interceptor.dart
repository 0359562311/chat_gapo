import 'package:dio/dio.dart';
import 'package:base_flutter/models/token/token_manager.dart';
import 'package:base_flutter/utils/utils.dart';

class AuthenticationInterceptor extends Interceptor {
  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) {
    String token = TokenManager.accessToken();
    Map<String, String> headers = {
      'Authorization': 'Bearer $token',
      'x-gapo-lang': Utils.currentLanguageCode(),
      "x-gapo-workspace-id": "581860791816317",
      if (!options.path.contains("login")) "x-gapo-user-id": "1042179540"
    };
    options.headers.addAll(headers);
    handler.next(options);
  }
}
