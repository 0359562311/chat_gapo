import 'package:chat_intern/network/response/chat_response.dart';
import 'package:chat_intern/presentation/chat/chat_list.dart';
import 'package:chat_intern/repository/chat_repository/chat_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatController extends GetxController with SingleGetTickerProviderMixin {
  late final TabController tabController;
  RxList<ChatData> data = <ChatData>[].obs;
  Rx<bool> isLoading = true.obs;

  ChatController();

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: 4, vsync: this);
    fetchData();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }


  ChatRepository _repository = ChatRepository();

  void fetchData() async {
    isLoading(true);
    await Future.delayed(Duration(seconds: 1));
    _repository.fetchChatList().then((value) {
      value.when(
          success: (data) {
            this.data.call(data.data);
          },
          failure: (_) {});
      isLoading(false);
    });
  }

  void delete(int index) {
    print(index);
    this.data.removeAt(index);
  }
}
