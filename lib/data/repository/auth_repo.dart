import 'package:dash/data/api/api_client.dart';
import 'package:dash/models/sign_up_body_model.dart';
import 'package:dash/utils/app_constant.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepo {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;

  AuthRepo({
    required this.apiClient,
    required this.sharedPreferences,
  });
  Future<Response> registeration(SignUpBody signUpBody) async {
    return await apiClient.postData(
        AppConstant.REGISTERATION_URL, signUpBody.toJson());
  }

  Future<Response> login(String email, String password) async {
    return await apiClient.postData(AppConstant.LOGIN_URL, {
      "email": email,
      "password": password,
    });
  }

  bool userLoggedIn() {
    return sharedPreferences.containsKey(AppConstant.TOKEN);
  }

  Future<bool> saveUserToken(String token) async {
    apiClient.token = token;
    apiClient.updateHeaders(token);
    return await sharedPreferences.setString(AppConstant.TOKEN, token);
  }

  Future<String> getUserToken() async {
    return sharedPreferences.getString(AppConstant.TOKEN) ?? "None";
  }

  Future<void> saveUserNumberAndPassword(String number, String password) async {
    try {
      await sharedPreferences.setString(AppConstant.NUMBER, number);
      await sharedPreferences.setString(AppConstant.PASSWORD, password);
    } catch (e) {
      rethrow;
    }
  }

  bool clearSharedData() {
    sharedPreferences.remove(AppConstant.TOKEN);
    sharedPreferences.remove(AppConstant.PASSWORD);
    sharedPreferences.remove(AppConstant.NUMBER);
    apiClient.token = '';
    apiClient.updateHeaders('');
    return true;
  }
}
