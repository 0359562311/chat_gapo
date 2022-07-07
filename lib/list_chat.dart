import 'package:chat_intern/const.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class ListChatPage extends StatefulWidget {
  const ListChatPage({Key? key}) : super(key: key);

  @override
  State<ListChatPage> createState() => _ListChatPageState();
}

class _ListChatPageState extends State<ListChatPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        body: Column(
          children: [
            _appBar(),
            _search(),
            _tabBar(),
            _listChatItem(),
          ],
        ),
      ),
    );
  }

  Widget _appBar() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          SizedBox(width: 12,),
          Stack(
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage("https://upload.wikimedia.org/wikipedia/commons/thumb/3/3a/Cat03.jpg/1200px-Cat03.jpg"),
                radius: 16,
              ),
              Positioned(
                top: 22,
                left: 20,
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.linkPrimary,
                    borderRadius: BorderRadius.circular(100),
                    border: Border.all(width: 1.5)
                  ),
                ),
              )
            ],
          ),
          SizedBox(width: 12,),
          Expanded(child: Text("Nguyen Kiem Tan", overflow: TextOverflow.ellipsis,),),
          Padding(
            padding: const EdgeInsets.all(6.0),
            child: Image.asset("assets/ic_more.png"),
          ),
          SizedBox(width: 8,),
          Padding(
            padding: const EdgeInsets.all(6.0),
            child: Image.asset("assets/ic_edit.png"),
          ),
          SizedBox(width: 8,),
          Padding(
            padding: const EdgeInsets.all(6.0),
            child: Image.asset("assets/ic_folder.png"),
          ),
        ],
      ),
    );
  }

  Widget _search() {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color: AppColors.backgroundSecondary,
      ),
      child: TextField(),
    );
  }

  Widget _tabBar() {
    return TabBar(tabs: [
      Tab(text: "Tất cả",),
    ]);
  }

  Widget _listChatItem() {
    return Expanded(child: ListView());
  }
}