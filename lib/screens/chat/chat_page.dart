import 'package:base_flutter/base/widgets/base_smart_refresher.dart';
import 'package:base_flutter/screens/chat/chat_list/chat_list_controller.dart';
import 'package:base_flutter/screens/chat/chat_list/chat_list_page.dart';
import 'package:base_flutter/theme/colors.dart';
import 'package:base_flutter/theme/text_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'chat_controller.dart';
import 'chat_item.dart';

enum ChatType { all, tagged, notSeen, product }

class ChatListScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ChatController());
    ChatType.values.forEach((element) { 
      Get.put(ChatListController(element), tag: element.name);
    });
  }
}

class ChatPage extends GetView<ChatController> {
  const ChatPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: ChatType.values.length,
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              _appBar(),
              _searchBox(),
              _tabBar(),
              _tabBarView(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _appBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          const SizedBox(
            width: 12,
          ),
          Stack(
            children: [
              const CircleAvatar(
                backgroundImage: NetworkImage(
                    "https://cdn.britannica.com/60/8160-050-08CCEABC/German-shepherd.jpg"),
                radius: 16,
              ),
              Positioned(
                top: 22,
                left: 20,
                child: Container(
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                      color: GPColor.functionLinkPrimary,
                      borderRadius: BorderRadius.circular(100),
                      border: Border.all(width: 1.5, color: GPColor.white)),
                ),
              )
            ],
          ),
          const SizedBox(
            width: 12,
          ),
          Expanded(
            child: Text(
              "Nguyen Kiem Tan",
              overflow: TextOverflow.ellipsis,
              style: textStyle(GPTypography.headingMedium),
            ),
          ),
          InkWell(
            onTap: () {},
            child: Padding(
              padding: const EdgeInsets.all(6.0),
              child: Image.asset(
                "assets/ic_more.png",
                width: 24,
                height: 24,
              ),
            ),
          ),
          const SizedBox(
            width: 8,
          ),
          InkWell(
            onTap: () {},
            child: Padding(
              padding: const EdgeInsets.all(6.0),
              child: Image.asset(
                "assets/ic_folder.png",
                width: 24,
                height: 24,
              ),
            ),
          ),
          const SizedBox(
            width: 8,
          ),
          InkWell(
            onTap: () {},
            child: Padding(
              padding: const EdgeInsets.all(6.0),
              child: Image.asset(
                "assets/ic_edit.png",
                width: 24,
                height: 24,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _searchBox() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: SizedBox(
        width: double.infinity,
        height: 36,
        child: TextField(
          controller: controller.textEditingController,
          style: textStyle(GPTypography.bodyLarge)
              ?.copyWith(color: GPColor.contentSecondary),
          decoration: InputDecoration(
            hintText: "Tìm kiếm",
            filled: true,
            prefixIcon: const Padding(
              padding: EdgeInsets.only(left: 4.0),
              child: Icon(
                CupertinoIcons.search,
                size: 16,
                color: GPColor.contentSecondary,
              ),
            ),
            prefixIconConstraints:
                const BoxConstraints(maxWidth: 36, minWidth: 36),
            suffixIcon: Obx(
              () => Visibility(
                visible: controller.hasText.value,
                child: InkWell(
                  onTap: () {
                    controller.clearText();
                  },
                  child: const Icon(
                    CupertinoIcons.clear_circled,
                    size: 16,
                    color: GPColor.contentSecondary,
                  ),
                ),
              ),
            ),
            fillColor: GPColor.bgSecondary,
            hintStyle: textStyle(GPTypography.bodyLarge)
                ?.copyWith(color: GPColor.contentSecondary),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16),
            enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.transparent),
                borderRadius: BorderRadius.circular(100)),
            focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.transparent),
                borderRadius: BorderRadius.circular(100)),
          ),
        ),
      ),
    );
  }

  Widget _tabBar() {
    final titles = [
      "Tất cả",
      "Nhắc đến",
      "Chưa đọc",
      "Sản phẩm"
    ];
    return Obx(
      () => TabBar(
          controller: controller.tabController,
          indicator: const UnderlineTabIndicator(
              borderSide:
                  BorderSide(color: GPColor.functionLinkPrimary, width: 2)),
          tabs: List.generate(titles.length, (index) => Tab(
            height: 54,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: Text(
                  titles[index],
                  style: index == controller.tabIndex.value ? textStyle(GPTypography.headingMedium)
                      ?.copyWith(color: GPColor.functionLinkPrimary) : textStyle(GPTypography.headingMedium),
                ),
              ),
            ))),
    );
  }

  Widget _tabBarView() {
    return Expanded(
        child: TabBarView(
                controller: controller.tabController,
                physics: const NeverScrollableScrollPhysics(),
                children: const [
                  ChatListWidget(chatType: ChatType.all),
                  ChatListWidget(chatType: ChatType.tagged),
                  ChatListWidget(chatType: ChatType.notSeen),
                  ChatListWidget(chatType: ChatType.product),
                ],
              ));
  }
}
