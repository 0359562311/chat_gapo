import 'dart:convert';

LoginResponse apiResponseFromJson(String str) =>
    LoginResponse.fromJson(json.decode(str));

String loginnResponseToJson(LoginResponse data) => json.encode(data.toJson());

class LoginResponse {
  LoginResponse({required this.accessToken});

  final String accessToken;

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
        accessToken: json["access_token"],
      );

  Map<String, dynamic> toJson() => {"access_token": accessToken};
}
