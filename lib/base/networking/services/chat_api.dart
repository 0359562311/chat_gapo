import 'dart:convert';

import 'package:base_flutter/base/networking/base/api.dart';
import 'package:base_flutter/configs/constants.dart';
import 'package:base_flutter/models/api/chat_response.dart';
import 'package:base_flutter/screens/chat/chat_page.dart';
import 'package:base_flutter/utils/string_utils.dart';
import 'package:flutter/services.dart';

class ChatAPI {
  final ApiService _service = ApiService(Constants.apiDomain);

  Future<ChatResponse> fetchChatList(ChatType chatType, int page, String query) {
    if(page > 0) return Future.value(ChatResponse(data: []));
    return rootBundle
        .loadString("assets/json/chat_response.json")
        .then((value) => (ChatResponse.fromJson(jsonDecode(value))))
        .then((value) async {
          value.data = value.data!.where((element) => element.name!.match(query) || element.lastMessage!.body!.match(query)).toList();
          if(chatType == ChatType.notSeen) {
            value.data = value.data!.where((element) => element.unreadCount! > 0).toList();
          }
          return value;
        });
  }
}
