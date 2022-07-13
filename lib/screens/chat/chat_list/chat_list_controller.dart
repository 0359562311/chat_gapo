import 'package:base_flutter/base/controller/base_controller.dart';
import 'package:base_flutter/base/networking/services/chat_api.dart';
import 'package:base_flutter/models/api/chat_response.dart';
import 'package:base_flutter/utils/string_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatListController extends BaseListController<ChatData>
    with GetTickerProviderStateMixin {
  late final AnimationController animationController;
  List<ChatData> _coreListItems = [];
  final RxBool hasText = false.obs;
  final RxString _text = "".obs;
  final Rx<ChatData?> archivedChat = Rx(null);

  @override
  void onInit() {
    super.onInit();
    animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));
    debounce(_text, (_) => getListItems(),
        time: const Duration(milliseconds: 300));
    getListItems();
  }

  @override
  void dispose() {
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
