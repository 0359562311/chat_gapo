import 'package:chat_intern/network/response/chat_response.dart';
import 'package:chat_intern/theme/color_theme.dart';
import 'package:chat_intern/theme/text_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

enum ChatType { individual, group }

class ChatItem extends StatelessWidget {
  final ChatData data;
  const ChatItem({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Slidable(
      endActionPane: ActionPane(
        motion: ScrollMotion(),
        children: [
          SlidableAction(
            // An action can be bigger than the others.
            flex: 1,
            onPressed: (_) {},
            backgroundColor: AppColors.bgTertiary,
            foregroundColor: AppColors.contentPrimary,
            icon: Icons.more_vert,
            spacing: 8,
            label: 'Thêm',
          ),
          SlidableAction(
            flex: 1,
            onPressed: (_) {},
            backgroundColor: AppColors.negativePrimary,
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
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        child: Row(
          children: [
            Stack(
              children: [
                CircleAvatar(
                  radius: 32,
                  backgroundImage: (_isEmpty(data.avatar)
                      ? (data.type == "group"
                          ? AssetImage("assets/ic_group_chat.png")
                          : AssetImage("assets/ic_profile.png"))
                      : NetworkImage(data.avatar!)) as ImageProvider,
                ),
                Positioned(
                    top: 48,
                    left: 48,
                    child: Container(
                      width: 14,
                      height: 14,
                      decoration: BoxDecoration(
                          color: AppColors.linkPrimary,
                          borderRadius: BorderRadius.circular(100),
                          border: Border.all(width: 2, color: Colors.white)),
                    ))
              ],
            ),
            SizedBox(
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
                            ? AppTextTheme.bodyLarge
                            : AppTextTheme.bodyLargeBold,
                      )),
                      SizedBox(
                        width: 8,
                      ),
                      Visibility(
                          visible: (data.unreadCount ?? 0) > 0,
                          child: Container(
                            constraints: BoxConstraints(minWidth: 16),
                            padding: EdgeInsets.symmetric(horizontal: 3.5),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: AppColors.linkPrimary,
                                borderRadius: BorderRadius.circular(100)),
                            child: Text(
                              "${data.unreadCount ?? 0}",
                              style: AppTextTheme.bodySmallBold
                                  .copyWith(color: AppColors.white),
                            ),
                          )),
                      SizedBox(
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
                  SizedBox(
                    height: 4,
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: Text(
                        _getDescription(),
                        overflow: TextOverflow.ellipsis,
                        style: (data.unreadCount ?? 0) == 0
                            ? AppTextTheme.bodyMedium
                            : AppTextTheme.bodyMediumBold,
                      )),
                      SizedBox(
                        width: 8,
                      ),
                      Text(
                        _getDateDifference(),
                        overflow: TextOverflow.ellipsis,
                        style: AppTextTheme.bodyMedium,
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
