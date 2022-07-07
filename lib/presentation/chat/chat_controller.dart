import 'package:chat_intern/network/response/chat_response.dart';
import 'package:chat_intern/presentation/chat/chat_list.dart';
import 'package:chat_intern/repository/chat_repository/chat_repository.dart';

class ChatController {
  ChatResponse? _response;
  ChatResponse? get response => _response;

  ChatListView _chatListView;
  ChatController(this._chatListView);

  ChatRepository _repository = ChatRepository();

  void fetchData() async {
    _chatListView.showLoading();
    await Future.delayed(Duration(seconds: 1));
    _repository.fetchChatList().then((value) {
      value.when(
          success: (data) {
            _response = data;
            _chatListView.showData(response!);
          },
          failure: (_) {});
    });
  }
}
