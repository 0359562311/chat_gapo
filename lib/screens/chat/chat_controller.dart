import 'package:base_flutter/base/controller/base_controller.dart';
import 'package:base_flutter/base/networking/services/chat_api.dart';
import 'package:base_flutter/models/api/chat_response.dart';
import 'package:base_flutter/utils/string_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatController extends BaseListController<ChatData>
    with GetTickerProviderStateMixin {
  late final TabController tabController;
  late final TextEditingController textEditingController;
  late final AnimationController animationController;
  List<ChatData> _coreListItems = [];
  final RxBool hasText = false.obs;
  final RxString _text = "".obs;
  final Rx<ChatData?> archivedChat = Rx(null);

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: 4, vsync: this);
    animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));
    textEditingController = TextEditingController(text: _text.string)
      ..addListener(() {
        hasText(textEditingController.text.isNotEmpty);
        _text(textEditingController.text);
      });
    debounce(_text, (_) => getListItems(),
        time: const Duration(milliseconds: 300));
    getListItems();
  }

  @override
  void dispose() {
    tabController.dispose();
    textEditingController.dispose();
    animationController.dispose();
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
    }).catchError((e) {
      handleError(e);
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

  void archive(int index) async {
    final removedChat = listItem.removeAt(index);
    _coreListItems.remove(removedChat);
    archivedChat(removedChat);
    animationController.forward();
    await Future.delayed(const Duration(seconds: 2));
    animationController.reverse();
  }

  void delete(int index) {
    final removedChat = listItem.removeAt(index);
    _coreListItems.remove(removedChat);
  }

  void undoArchive() {
    if (archivedChat.value != null) {
      _coreListItems.add(archivedChat.value!);
      _filter();
    }
  }
}
