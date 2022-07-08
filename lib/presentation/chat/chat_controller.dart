import 'package:chat_intern/network/response/chat_response.dart';
import 'package:chat_intern/presentation/chat/chat_list.dart';
import 'package:chat_intern/repository/chat_repository/chat_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatController extends GetxController with SingleGetTickerProviderMixin {
  late final TabController tabController;
  late final TextEditingController textEditingController;
  List<ChatData> coreData = [];
  RxList<ChatData> data = <ChatData>[].obs;
  Rx<bool> isLoading = true.obs;
  int _searchDelay = 0;

  ChatController();

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: 4, vsync: this);
    textEditingController = TextEditingController();
    fetchData();
  }

  @override
  void dispose() {
    tabController.dispose();
    textEditingController.dispose();
    super.dispose();
  }


  ChatRepository _repository = ChatRepository();

  void fetchData() async {
    isLoading(true);
    await Future.delayed(Duration(seconds: 1));
    _repository.fetchChatList().then((value) {
      value.when(
          success: (data) {
            coreData = data.data ?? [];
            this.data.call(coreData);
          },
          failure: (_) {});
      isLoading(false);
    });
  }

  void search(String query) async {
    _searchDelay++;
    await Future.delayed(const Duration(milliseconds: 200));
    _searchDelay--;
    if(_searchDelay > 0) return;
    this.data(coreData.where((element) {
      return element.name!.toLowerCase().contains(query.toLowerCase());
    }).toList());
  }

  void delete(int index) {
    print(index);
    this.data.removeAt(index);
  }
}
