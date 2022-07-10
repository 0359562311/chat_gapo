import 'package:base_flutter/base/controller/base_controller.dart';
import 'package:base_flutter/base/networking/services/chat_api.dart';
import 'package:base_flutter/models/api/chat_response.dart';
import 'package:base_flutter/utils/string_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatController extends BaseController
    with GetSingleTickerProviderStateMixin {
  late final TabController tabController;
  late final TextEditingController textEditingController;
  List<ChatData> _coreData = [];
  RxList<ChatData> data = <ChatData>[].obs;
  RxBool hasText = false.obs;

  int _searchDelay = 0;

  ChatController();

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: 4, vsync: this);
    textEditingController = TextEditingController()
      ..addListener(() {
        hasText(textEditingController.text.isNotEmpty);
      });
    fetchData();
  }

  @override
  void dispose() {
    tabController.dispose();
    textEditingController.dispose();
    super.dispose();
  }

  ChatAPI _repository = ChatAPI();

  void fetchData() async {
    isLoading(true);
    await Future.delayed(const Duration(seconds: 1));
    _repository.fetchChatList().then((value) {
      _coreData = value.data ?? [];
      data.call(_coreData);
      isLoading(false);
    });
  }

  void search(String query) async {
    _searchDelay++;
    await Future.delayed(const Duration(milliseconds: 400));
    _searchDelay--;
    if (_searchDelay > 0) return;
    data(_coreData.where((element) {
      return element.name!.match(query) ||
          element.lastMessage!.body!.match(query);
    }).toList());
  }

  void clearText() {
    textEditingController.text = "";
    search("");
  }

  void delete(int index) {
    this.data.removeAt(index);
  }
}
