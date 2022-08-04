import 'package:base_flutter/base/networking/base/api.dart';
import 'package:base_flutter/configs/constants.dart';
import 'package:base_flutter/models/api/code_response.dart';
import 'package:base_flutter/models/api/user_info.dart';
import 'package:base_flutter/models/base/api_response.dart';
import 'package:base_flutter/models/api/login_response.dart';
import 'package:base_flutter/models/api/request_email_response.dart';
import 'package:base_flutter/utils/string_utils.dart';

class AuthAPI {
  final ApiService _service = ApiService(Constants.apiDomain);

  Future<bool> requestEmailOTP(String email) async {
    try {
      final response = await _service.postData(
          endPoint: Constants.requestEmailOTP, body: {"email_address": email});
      ApiResponse<RequestEmailResponse> result =
          ApiResponse<RequestEmailResponse>.fromJson(response.data);
      return result.data.status >= 0;
    } catch (e) {
      rethrow;
    }
  }

  Future<LoginResponse> loginWithOtp(String email, String otp) async {
    try {
      final response = await _service.postData(
          endPoint: Constants.loginWithOTP,
          body: {"email_address": email, "otp": otp});
      ApiResponse<LoginResponse> result =
          ApiResponse<LoginResponse>.fromJson(response.data);
      return result.data;
    } catch (e) {
      rethrow;
    }
  }

  Future<LoginResponse> loginWithPassword(String email, String password) async {
    try {
      String hashedPassword = password.hashSha256();
      final response =
          await _service.postData(endPoint: Constants.loginWithPassword, body: {
        "email": "nguyenmanhtoan@gapo.com.vn",
        "password":
            "4bff60a3797bc8053cd40253218c93afa7962fb966d012c844e254ad7788147e",
        "client_id": "6n6rwo86qmx7u8aahgrq",
        "device_model": "Simulator iPhone 11",
        "device_id": "76cce865cbad4d02",
        "trusted_device": true,
      });
      ApiResponse<LoginResponse> result =
          ApiResponse<LoginResponse>.fromJson(response.data);
      return result.data;
    } catch (e) {
      rethrow;
    }
  }

  Future<UserInfo> getUserInfo() async {
    try {
      final response = await _service.getData(endPoint: Constants.getUserInfo);
      ApiResponse<UserInfo> result =
          ApiResponse<UserInfo>.fromJson(response.data);
      return result.data;
    } catch (e) {
      rethrow;
    }
  }

  Future<LoginResponse> activateCode(String code) async {
    try {
      final response = await _service
          .postData(endPoint: Constants.activateCode, body: {"code": code});
      ApiResponse<LoginResponse> result =
          ApiResponse<LoginResponse>.fromJson(response.data);
      return result.data;
    } catch (e) {
      rethrow;
    }
  }

  Future<CodeResponse> getCode(String refId) async {
    try {
      final response = await _service
          .getData(endPoint: Constants.getCode, query: {"ref_id": refId});
      ApiResponse<CodeResponse> result =
          ApiResponse<CodeResponse>.fromJson(response.data);
      return result.data;
    } catch (e) {
      rethrow;
    }
  }

  Future<UserInfo> bindOnChainWallet(String address, String? otp) async {
    var params = {"on_chain_wallet": address};
    if (otp != null) {
      params["otp"] = otp;
    }
    try {
      final response =
          await _service.postData(endPoint: Constants.bindWallet, body: params);
      ApiResponse<UserInfo> result =
          ApiResponse<UserInfo>.fromJson(response.data);
      return result.data;
    } catch (e) {
      rethrow;
    }
  }

  Future<LoginResponse> setPassword(String password, String otp) async {
    var hashedPass = password.hashSha256();
    var params = {"password_hashed": hashedPass, "otp": otp};
    try {
      final response = await _service.postData(
          endPoint: Constants.setPassword, body: params);
      ApiResponse<LoginResponse> result =
          ApiResponse<LoginResponse>.fromJson(response.data);
      return result.data;
    } catch (e) {
      rethrow;
    }
  }

  Future<LoginResponse> changePassword(
      String oldPassword, String newPassword, String otp) async {
    var oldHashedPass = oldPassword.hashSha256();
    var newHashedPass = newPassword.hashSha256();
    var params = {
      "old_password_hashed": oldHashedPass,
      "new_password_hashed": newHashedPass,
      "otp": otp
    };
    try {
      final response = await _service.patchData(
          endPoint: Constants.setPassword, body: params);
      ApiResponse<LoginResponse> result =
          ApiResponse<LoginResponse>.fromJson(response.data);
      return result.data;
    } catch (e) {
      rethrow;
    }
  }
}
