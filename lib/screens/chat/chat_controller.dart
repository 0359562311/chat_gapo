import 'package:base_flutter/base/controller/base_controller.dart';
import 'package:base_flutter/base/networking/services/chat_api.dart';
import 'package:base_flutter/models/api/chat_response.dart';
import 'package:base_flutter/screens/chat/chat_list/chat_list_controller.dart';
import 'package:base_flutter/screens/chat/chat_page.dart';
import 'package:base_flutter/utils/string_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatController extends BaseController
    with GetTickerProviderStateMixin {
  late final TabController tabController;
  late final TextEditingController textEditingController;
  late final AnimationController animationController;
  final RxBool hasText = false.obs;
  final RxInt tabIndex = 0.obs;
  final RxString _text = "".obs;
  final Rx<ChatData?> archivedChat = Rx(null);

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: 4, vsync: this)..addListener(() {
      if(!tabController.indexIsChanging) tabIndex(tabController.index);
    });
    animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));
    textEditingController = TextEditingController(text: _text.string)
      ..addListener(() {
        hasText(textEditingController.text.isNotEmpty);
        _text(textEditingController.text);
      });
    debounce(_text, (_) => Get.find<ChatListController>(tag: ChatType.values[tabController.index].name).getListItems(),
        time: const Duration(milliseconds: 300));
    Get.find<ChatListController>(tag: ChatType.all.name).getListItems();
  }

  @override
  void dispose() {
    tabController.dispose();
    textEditingController.dispose();
    animationController.dispose();
    super.dispose();
  }

  void clearText() {
    textEditingController.text = "";
  }

}
