import 'package:base_flutter/base/controller/base_controller.dart';
import 'package:base_flutter/base/networking/services/chat_api.dart';
import 'package:base_flutter/models/api/chat_response.dart';
import 'package:base_flutter/screens/chat/chat_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatListController extends BaseListController<ChatData>
    with GetTickerProviderStateMixin {
  late final AnimationController animationController;
  final RxBool hasText = false.obs;
  final RxString _text = "".obs;
  final Rx<ChatData?> archivedChat = Rx(null);

  final ChatType _chatType;
  ChatListController(this._chatType);

  String? _lastSearchQuery;

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
  Future getListItems({String query = "", bool isReload = false}) async {
    print(query);
    super.getListItems();
    if(query == _lastSearchQuery && !isReload) return;
    _lastSearchQuery = query;
    await Future.delayed(const Duration(seconds: 1));
    _repository.fetchChatList(_chatType, page, query).then((value) {
      listItem.value = value.data ?? [];
      
    }).catchError((e) {
      handleError(e);
    }).whenComplete(() => isLoading(false));
  }

  @override
  Future reload() {
    getListItems(query: _lastSearchQuery ?? "", isReload: true);
    return super.reload();
  }

  void archive(int index) async {
    final removedChat = listItem.removeAt(index);
    listItem.remove(removedChat);
    archivedChat(removedChat);
  }

  void delete(int index) {
    final removedChat = listItem.removeAt(index);
    listItem.remove(removedChat);
  }

  void undoArchive() {
    if (archivedChat.value != null) {
      listItem.add(archivedChat.value!);
    }
  }
}
