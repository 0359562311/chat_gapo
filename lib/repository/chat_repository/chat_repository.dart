import 'dart:convert';

import 'package:chat_intern/network/api_result.dart';
import 'package:chat_intern/network/response/chat_response.dart';
import 'package:flutter/services.dart';

class ChatRepository {
  Future<ApiResult<Exception, ChatResponse>> fetchChatList() {
    return rootBundle.loadString("assets/chat_response.json").then(
        (value) => ApiResult.success(ChatResponse.fromJson(jsonDecode(value))));
  }
}
