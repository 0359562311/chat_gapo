import 'package:base_flutter/models/api/chat_response.dart';
import 'package:base_flutter/theme/colors.dart';
import 'package:base_flutter/theme/text_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ChatItem extends StatelessWidget {
  final ChatData data;
  final void Function() onDelete;
  final void Function() onMore;
  const ChatItem(
      {Key? key,
      required this.data,
      required this.onDelete,
      required this.onMore})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Slidable(
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            // An action can be bigger than the others.
            flex: 1,
            onPressed: (_) {
              onMore();
            },
            backgroundColor: GPColor.bgTertiary,
            foregroundColor: GPColor.contentPrimary,
            icon: Icons.more_vert,
            spacing: 8,
            label: 'Thêm',
          ),
          SlidableAction(
            flex: 1,
            onPressed: (_) {
              onDelete();
            },
            backgroundColor: GPColor.negativePrimary,
            foregroundColor: Colors.white,
            icon: CupertinoIcons.trash,
            spacing: 8,
            label: 'Xoá',
          ),
        ],
      ),

      // The child of the Slidable is what the user sees when the
      // component is not dragged.
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        child: Row(
          children: [
            Stack(
              children: [
                CircleAvatar(
                  radius: 32,
                  backgroundImage: (_isEmpty(data.avatar)
                      ? (data.type == "group"
                          ? const AssetImage("assets/ic_group_chat.png")
                          : const AssetImage("assets/ic_profile.png"))
                      : NetworkImage(data.avatar!)) as ImageProvider,
                ),
                Positioned(
                    top: 48,
                    left: 48,
                    child: Container(
                      width: 14,
                      height: 14,
                      decoration: BoxDecoration(
                          color: GPColor.functionLinkPrimary,
                          borderRadius: BorderRadius.circular(100),
                          border: Border.all(width: 2, color: Colors.white)),
                    ))
              ],
            ),
            const SizedBox(
              width: 16,
            ),
            Expanded(
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                          child: Text(
                        data.alias ?? data.name ?? "",
                        overflow: TextOverflow.ellipsis,
                        style: (data.unreadCount ?? 0) == 0
                            ? textStyle(GPTypography.bodyLarge)
                            : textStyle(GPTypography.bodyLarge)
                                ?.copyWith(fontWeight: FontWeight.bold),
                      )),
                      const SizedBox(
                        width: 8,
                      ),
                      Visibility(
                          visible: (data.unreadCount ?? 0) > 0,
                          child: Container(
                            constraints: const BoxConstraints(minWidth: 16),
                            padding:
                                const EdgeInsets.symmetric(horizontal: 3.5),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: GPColor.functionLinkPrimary,
                                borderRadius: BorderRadius.circular(100)),
                            child: Text(
                              "${data.unreadCount ?? 0}",
                              style: textStyle(GPTypography.bodySmallBold)
                                  ?.copyWith(color: GPColor.white),
                            ),
                          )),
                      const SizedBox(
                        width: 8,
                      ),
                      Visibility(
                        visible: data.pinnedAt != null,
                        child: Image.asset(
                          "assets/ic_pin.png",
                          width: 16,
                          height: 16,
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: Text(
                        _getDescription(),
                        overflow: TextOverflow.ellipsis,
                        style: (data.unreadCount ?? 0) == 0
                            ? textStyle(GPTypography.bodyMedium)
                            : textStyle(GPTypography.bodyMedium)
                                ?.copyWith(fontWeight: FontWeight.bold),
                      )),
                      const SizedBox(
                        width: 8,
                      ),
                      Text(
                        _getDateDifference(),
                        overflow: TextOverflow.ellipsis,
                        style: textStyle(GPTypography.bodyMedium),
                      )
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  String _getDescription() {
    String lastMessage = data.lastMessage?.body ?? "";
    // TODO: Replace my id
    bool isSender = data.lastMessage?.sender?.id == "myid";
    bool isGroup = data.type == "group";

    String sender = "";
    if (isSender) {
      if (isGroup) sender = "Bạn: ";
    } else {
      sender = (data.lastMessage?.sender?.name ?? "").split(" ").first + ": ";
    }

    return "${sender}${lastMessage}";
  }

  String _getDateDifference() {
    Duration dif = DateTime.now().difference(data.lastMessage!.createdAt!);
    if (dif.inDays > 0)
      return "${dif.inDays} ngày";
    else if (dif.inHours > 0)
      return "${dif.inHours} giờ";
    else if (dif.inMinutes > 0) return "${dif.inMinutes} phút";
    return "< 1 phút";
  }

  bool _isEmpty(String? str) {
    return (str ?? "").isEmpty;
  }
}
