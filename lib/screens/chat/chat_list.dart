import 'package:base_flutter/base/widgets/base_smart_refresher.dart';
import 'package:base_flutter/theme/colors.dart';
import 'package:base_flutter/theme/text_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'chat_controller.dart';
import 'chat_item.dart';

class ChatListScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ChatController());
  }
}

class ListChatPage extends GetView<ChatController> {
  const ListChatPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        body: SafeArea(
          child: Stack(
            children: [
              Column(
                children: [
                  _appBar(),
                  _searchBox(),
                  _tabBar(),
                  _tabBarView(),
                ],
              ),
              Positioned(
                top: 25,
                child: FadeTransition(
                  opacity: Tween<double>(begin: 0, end: 1)
                      .animate(controller.animationController),
                  child: Row(
                    children: [
                      Text("ngusdhds"),
                      TextButton(
                          onPressed: () {
                            controller.undoArchive();
                          },
                          child: Text("Hoan tac"))
                    ],
                  ),
                ),
              ),
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
    return TabBar(
        controller: controller.tabController,
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
      return controller.isLoading.value
          ? const Expanded(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            )
          : Expanded(
              child: controller.listItem.isNotEmpty
                  ? TabBarView(
                      controller: controller.tabController,
                      children: [
                        BaseSmartRefresher(
                          onReload: () {
                            return controller.getListItems();
                          },
                          onLoadMore: () {
                            return controller.loadMoreItems();
                          },
                          isFinish: false,
                          child: ListView.builder(
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {},
                                child: ChatItem(
                                  data: controller.listItem[index],
                                  onDelete: () {
                                    controller.delete(index);
                                  },
                                  onMore: () {
                                    _showMore(context, index);
                                  },
                                ),
                              );
                            },
                            itemCount: controller.listItem.length,
                          ),
                        ),
                        const SizedBox(),
                        const SizedBox(),
                        const SizedBox(),
                      ],
                    )
                  : controller.hasText.value
                      ? const Center(
                          child: Text("Không có kết quả"),
                        )
                      : const Center(
                          child: Text("Bạn chưa có hội thoại nào!"),
                        ));
    });
  }

  void _showMore(BuildContext context, int index) {
    final features = [
      _BottomSheetOption(name: "Chặn tin nhắn", onPress: () {}),
      _BottomSheetOption(name: "Ghim", onPress: () {}),
      _BottomSheetOption(name: "Tắt thông báo", onPress: () {}),
      _BottomSheetOption(name: "Bật trò chuyện bí mật", onPress: () {}),
      _BottomSheetOption(
          name: "Lưu trữ cuộc hội thoại",
          onPress: () {
            controller.archive(index);
            Navigator.of(Get.overlayContext!).pop();
          }),
      _BottomSheetOption(
          name: "Xoá cuộc hội thoại",
          onPress: () {
            controller.delete(index);
            Navigator.of(Get.overlayContext!).pop();
          }),
    ];
    showCupertinoModalPopup(
        context: context,
        builder: (context) {
          return IntrinsicHeight(
            child: SafeArea(
              child: Column(
                children: [
                  InkWell(
                    onTap: () {},
                    child: Container(
                      decoration: const BoxDecoration(
                          color: GPColor.bgPrimary,
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(13))),
                      width: MediaQuery.of(context).size.width - 20,
                      padding: const EdgeInsets.all(16.0),
                      alignment: Alignment.center,
                      child: const Text(
                        "Chọn chức năng",
                        style: TextStyle(
                            color: GPColor.contentSecondary,
                            fontSize: 13,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                  ...List.generate(
                      features.length,
                      (index) => Column(
                            children: [
                              const Divider(
                                height: 1,
                                color: GPColor.contentSecondary,
                              ),
                              InkWell(
                                onTap: () {
                                  features[index].onPress();
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: GPColor.bgPrimary,
                                      borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(
                                            index == features.length - 1
                                                ? 13
                                                : 0),
                                        bottomRight: Radius.circular(
                                            index == features.length - 1
                                                ? 13
                                                : 0),
                                      )),
                                  width: MediaQuery.of(context).size.width - 20,
                                  padding: const EdgeInsets.all(16.0),
                                  alignment: Alignment.center,
                                  child: Text(
                                    features[index].name,
                                    style: TextStyle(
                                        color: index == features.length - 1
                                            ? GPColor.negativePrimary
                                            : GPColor.functionLinkPrimary,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ),
                            ],
                          ))
                ],
              ),
            ),
          );
        });
  }
}

class _BottomSheetOption {
  final String name;
  final void Function() onPress;

  _BottomSheetOption({required this.name, required this.onPress});
}
