import 'package:dash/data/api/api_client.dart';
import 'package:dash/utils/app_constant.dart';
import 'package:get/get.dart';

class UserRepo {
  final ApiClient apiClient;
  UserRepo({required this.apiClient});
  Future<Response> getUserInfo() async {
    return await apiClient.getData(AppConstant.USER_INFO_URL);
  }
}
