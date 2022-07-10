import 'package:base_flutter/screens/loading/loading_screen.dart';
import 'package:base_flutter/theme/colors.dart';
import 'package:base_flutter/theme/text_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'chat_controller.dart';
import 'chat_item.dart';

class ListChatPage extends GetView<ChatController> {
  late final ChatController _chatController = Get.put(ChatController());

  ListChatPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
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
          controller: _chatController.textEditingController,
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
                visible: _chatController.hasText.value,
                child: InkWell(
                  onTap: () {
                    _chatController.clearText();
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
          onChanged: (text) {
            _chatController.search(text);
          },
        ),
      ),
    );
  }

  Widget _tabBar() {
    return TabBar(
        controller: _chatController.tabController,
        indicator: const UnderlineTabIndicator(
            borderSide:
                BorderSide(color: GPColor.functionLinkPrimary, width: 2)),
        tabs: [
          Tab(
            child: Text(
              "Tất cả",
              style: textStyle(GPTypography.headingMedium)
                  ?.copyWith(color: GPColor.functionLinkPrimary),
            ),
          ),
          Tab(
            child: Text("Nhắc đến",
                overflow: TextOverflow.visible,
                softWrap: false,
                style: textStyle(GPTypography.headingMedium)),
          ),
          Tab(
            child: Text("Chưa đọc",
                overflow: TextOverflow.visible,
                softWrap: false,
                style: textStyle(GPTypography.headingMedium)),
          ),
          Tab(
            child: Text("Product",
                overflow: TextOverflow.visible,
                softWrap: false,
                style: textStyle(GPTypography.headingMedium)),
          ),
        ]);
  }

  Widget _tabBarView() {
    return Obx(() {
      return _chatController.isLoading.value
          ? const Expanded(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            )
          : Expanded(
              child: _chatController.data.isNotEmpty
                  ? TabBarView(
                      controller: _chatController.tabController,
                      children: [
                        ListView.builder(
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {},
                              child: ChatItem(
                                data: _chatController.data[index],
                                onDelete: () {
                                  _chatController.delete(index);
                                },
                              ),
                            );
                          },
                          itemCount: _chatController.data.length,
                        ),
                        const SizedBox(),
                        const SizedBox(),
                        const SizedBox(),
                      ],
                    )
                  : const Center(
                      child: const Text("Bạn chưa có hội thoại nào!"),
                    ));
    });
  }
}
