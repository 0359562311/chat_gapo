import 'package:base_flutter/screens/change_password/change_password_screen.dart';
import 'package:base_flutter/screens/chat/chat_page.dart';
import 'package:base_flutter/screens/loading/loading_screen.dart';
import 'package:get/get.dart';
import 'package:base_flutter/screens/login/login_screen.dart';
import 'package:base_flutter/screens/login/account_login_screen.dart';
import 'router_name.dart';

class Pages {
  static List<GetPage> pages = [
    GetPage(
        name: RouterName.loading,
        transitionDuration: Duration.zero,
        page: () => LoadingScreen()),
    GetPage(
        name: RouterName.login,
        page: () => const LoginScreen(),
        binding: LoginScreenBinding()),
    GetPage(
        name: RouterName.accountLogin,
        page: () => const AccountLoginScreen(),
        binding: AccountLoginScreenBinding()),
    GetPage(
        name: RouterName.changePassword,
        page: () => const ChangePasswordScreen(),
        binding: ChangePasswordScreenBinding()),
    GetPage(
        name: RouterName.chat,
        page: () => const ChatPage(),
        binding: ChatListScreenBinding())
  ];
}
