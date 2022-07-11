import 'package:base_flutter/base/controller/base_controller.dart';
import 'package:base_flutter/base/networking/services/chat_api.dart';
import 'package:base_flutter/models/api/chat_response.dart';
import 'package:base_flutter/utils/string_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatController extends BaseListController<ChatData>
    with GetSingleTickerProviderStateMixin {
  late final TabController tabController;
  late final TextEditingController textEditingController;
  List<ChatData> _coreListItems = [];
  RxBool hasText = false.obs;
  final RxString _text = "".obs;
  ChatController();

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: 4, vsync: this);
    textEditingController = TextEditingController(text: _text.string)
      ..addListener(() {
        hasText(textEditingController.text.isNotEmpty);
        _text(textEditingController.text);
      });
    debounce(_text, (_) => getListItems(), time: const Duration(milliseconds: 300));
    getListItems();
  }

  @override
  void dispose() {
    tabController.dispose();
    textEditingController.dispose();
    super.dispose();
  }

  final ChatAPI _repository = ChatAPI();

  @override
  Future getListItems() async {
    super.getListItems();
    await Future.delayed(const Duration(seconds: 1));
    _repository.fetchChatList().then((value) {
      _coreListItems = value.data ?? [];
      _filter();
      isLoading(false);
    });
  }

  void _filter() async {
    String query = textEditingController.text;
    listItem(_coreListItems.where((element) {
      return element.name!.match(query) ||
          element.lastMessage!.body!.match(query);
    }).toList());
  }

  void clearText() {
    textEditingController.text = "";
    _filter();
  }

  void delete(int index) {
    final removedChat = listItem.removeAt(index);
    _coreListItems.remove(removedChat);
  }
}
