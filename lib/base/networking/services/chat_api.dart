import 'dart:convert';

import 'package:base_flutter/base/networking/base/api.dart';
import 'package:base_flutter/configs/constants.dart';
import 'package:base_flutter/models/api/chat_response.dart';
import 'package:flutter/services.dart';

class ChatAPI {
  final ApiService _service = ApiService(Constants.apiDomain);

  Future<ChatResponse> fetchChatList() {
    return rootBundle
        .loadString("assets/json/chat_response.json")
        .then((value) => (ChatResponse.fromJson(jsonDecode(value))));
  }
}
