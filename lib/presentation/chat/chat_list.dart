import 'package:chat_intern/network/response/chat_response.dart';
import 'package:chat_intern/presentation/chat/chat_controller.dart';
import 'package:chat_intern/presentation/chat/chat_item.dart';
import 'package:chat_intern/theme/color_theme.dart';
import 'package:chat_intern/theme/text_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ListChatPage extends StatefulWidget {
  const ListChatPage({Key? key}) : super(key: key);

  @override
  State<ListChatPage> createState() => _ListChatPageState();
}

class _ListChatPageState extends State<ListChatPage>
    with SingleTickerProviderStateMixin, ChatListView {
  late final TabController _tabController;
  late final ChatController _chatController;
  bool _isLoading = false;
  ChatResponse? _response;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    _chatController = ChatController(this);
    _chatController.fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              _appBar(),
              _search(),
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
      padding: EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          SizedBox(
            width: 12,
          ),
          Stack(
            children: [
              CircleAvatar(
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
                      color: AppColors.linkPrimary,
                      borderRadius: BorderRadius.circular(100),
                      border: Border.all(width: 1.5, color: AppColors.white)),
                ),
              )
            ],
          ),
          SizedBox(
            width: 12,
          ),
          Expanded(
            child: Text(
              "Nguyen Kiem Tan",
              overflow: TextOverflow.ellipsis,
              style: AppTextTheme.headingMedium,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(6.0),
            child: Image.asset(
              "assets/ic_more.png",
              width: 24,
              height: 24,
            ),
          ),
          SizedBox(
            width: 8,
          ),
          Padding(
            padding: const EdgeInsets.all(6.0),
            child: Image.asset(
              "assets/ic_folder.png",
              width: 24,
              height: 24,
            ),
          ),
          SizedBox(
            width: 8,
          ),
          Padding(
            padding: const EdgeInsets.all(6.0),
            child: Image.asset(
              "assets/ic_edit.png",
              width: 24,
              height: 24,
            ),
          ),
        ],
      ),
    );
  }

  Widget _search() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: SizedBox(
        width: double.infinity,
        height: 36,
        child: TextField(
          style: AppTextTheme.bodyLarge
              .copyWith(color: AppColors.contentSecondary),
          decoration: InputDecoration(
            hintText: "Tìm kiếm",
            filled: true,
            prefixIcon: Padding(
              padding: const EdgeInsets.only(left: 4.0),
              child: Icon(
                CupertinoIcons.search,
                size: 16,
                color: AppColors.contentSecondary,
              ),
            ),
            prefixIconConstraints: BoxConstraints(maxWidth: 36, minWidth: 36),
            fillColor: AppColors.backgroundSecondary,
            hintStyle: AppTextTheme.bodyLarge
                .copyWith(color: AppColors.contentSecondary),
            contentPadding: EdgeInsets.symmetric(horizontal: 16),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.transparent),
                borderRadius: BorderRadius.circular(100)),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.transparent),
                borderRadius: BorderRadius.circular(100)),
          ),
        ),
      ),
    );
  }

  Widget _tabBar() {
    return TabBar(
        controller: _tabController,
        indicator: UnderlineTabIndicator(
            borderSide: BorderSide(color: AppColors.linkPrimary, width: 2)),
        tabs: [
          Tab(
            child: Text(
              "Tất cả",
              style: AppTextTheme.headingMedium
                  .copyWith(color: AppColors.linkPrimary),
            ),
          ),
          Tab(
            child: Text("Nhắc đến",
                overflow: TextOverflow.visible,
                softWrap: false,
                style: AppTextTheme.headingMedium),
          ),
          Tab(
            child: Text("Chưa đọc",
                overflow: TextOverflow.visible,
                softWrap: false,
                style: AppTextTheme.headingMedium),
          ),
          Tab(
            child: Text("Product",
                overflow: TextOverflow.visible,
                softWrap: false,
                style: AppTextTheme.headingMedium),
          ),
        ]);
  }

  Widget _tabBarView() {
    return _isLoading
        ? Expanded(
            child: Center(
              child: CircularProgressIndicator(
                color: AppColors.contentPrimary,
              ),
            ),
          )
        : Expanded(
            child: TabBarView(
            controller: _tabController,
            children: [
              ListView.builder(
                itemBuilder: (context, index) {
                  return ChatItem(
                    data: _response!.data![index],
                  );
                },
                itemCount: _response?.data?.length ?? 0,
              ),
              SizedBox(),
              SizedBox(),
              SizedBox(),
            ],
          ));
  }

  @override
  void showData(ChatResponse response) {
    if (mounted)
      setState(() {
        _isLoading = false;
        _response = response;
      });
  }

  @override
  void showLoading() {
    if (mounted)
      setState(() {
        _isLoading = true;
      });
  }
}

abstract class ChatListView {
  void showLoading();
  void showData(ChatResponse response);
}
