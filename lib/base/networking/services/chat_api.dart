import 'dart:convert';

import 'package:base_flutter/base/networking/base/api.dart';
import 'package:base_flutter/configs/constants.dart';
import 'package:base_flutter/models/api/chat_response.dart';
import 'package:base_flutter/screens/chat/chat_page.dart';
import 'package:base_flutter/utils/string_utils.dart';
import 'package:flutter/services.dart';

class ChatAPI {
  final ApiService _service = ApiService(Constants.chatApiDomain);

  Future<ChatResponse> fetchChatList(
      ChatType chatType, int? lastId, String query) async {
    Map<String, dynamic> params = {"page_size": 100};
    if (lastId != null) params['last_id'] = lastId;
    final res =
        await _service.getData(endPoint: Constants.chatThreads, query: params);
    return ChatResponse.fromJson(res.data);
  }
}
