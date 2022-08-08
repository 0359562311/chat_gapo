import 'package:base_flutter/base/controller/base_controller.dart';
import 'package:base_flutter/base/networking/services/chat_api.dart';
import 'package:base_flutter/models/api/chat_response.dart';
import 'package:base_flutter/screens/chat/chat_page.dart';
import 'package:base_flutter/utils/snack_bar.dart';
import 'package:base_flutter/utils/string_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatListController extends BaseListController<ChatData>
    with GetTickerProviderStateMixin {
  late final AnimationController animationController;
  final RxBool hasText = false.obs;
  final RxString _text = "".obs;

  final ChatType _chatType;
  ChatListController(this._chatType);

  String? _lastSearchQuery;

  List<ChatData> _originalData = [];

  void _setListItem(String query) {
    listItem.value = _originalData.where((element) {
      return element.name!.match(query) ||
          element.lastMessage!.body!.match(query);
    }).toList();
  }

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
    super.getListItems();
    if (query == _lastSearchQuery && !isReload) return;
    if (_lastSearchQuery != null) {
      _lastSearchQuery = query;
      _setListItem(query);
      return;
    }
    _lastSearchQuery = query;
    await Future.delayed(const Duration(seconds: 1));
    _repository
        .fetchChatList(_chatType,
            (isReload || listItem.isEmpty) ? null : listItem.last.id, query)
        .then((value) {
      _originalData = value.data ?? [];
      _setListItem(query);
    }).catchError((e) {
      handleError(e);
    }).whenComplete(() => isLoading(false));
  }

  @override
  Future reload() {
    return getListItems(query: _lastSearchQuery ?? "", isReload: true);
  }

  void archive(int index) async {
    final removedChat = listItem.removeAt(index);
    listItem.remove(removedChat);
    GPSnackbar.showUndoSnackBar("Lưu trữ cuộc hội thoại thành công", () {
      listItem.insert(index, removedChat);
    });
  }

  void delete(int index) {
    final removedChat = listItem.removeAt(index);
    listItem.remove(removedChat);
  }
}
