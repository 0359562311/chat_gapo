import 'package:base_flutter/base/widgets/base_smart_refresher.dart';
import 'package:base_flutter/screens/chat/chat_item.dart';
import 'package:base_flutter/screens/chat/chat_list/chat_list_controller.dart';
import 'package:base_flutter/screens/chat/chat_page.dart';
import 'package:base_flutter/theme/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatListWidget extends StatelessWidget {
  final ChatType chatType;
  const ChatListWidget({Key? key, required this.chatType}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ChatListController>(tag: chatType.name);
    return Obx(() {
      return controller.isLoading.value
          ? const Expanded(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            )
          : Expanded(
              child: controller.listItem.isNotEmpty
                  ? BaseSmartRefresher(
                    onReload: () {
                      return controller.reload();
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
                              _showMore(context, index, controller);
                            },
                          ),
                        );
                      },
                      itemCount: controller.listItem.length,
                    ),
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

  void _showMore(BuildContext context, int index, ChatListController controller) {
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
