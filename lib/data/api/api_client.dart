import 'package:dash/utils/app_constant.dart';
import 'package:get/get.dart';

class ApiClient extends GetConnect implements GetxService {
  late String token;
  final String appBaseURL;
  late Map<String, String> _mainHeaders;
  ApiClient({required this.appBaseURL}) {
    baseUrl = appBaseURL;
    timeout = const Duration(seconds: 30);
    token = AppConstant.TOKEN;
    _mainHeaders = {
      'Content-type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token',
    };
  }

  Future<Response> getData(String uri) async {
    try {
      Response response = await get(uri);
      return response;
    } catch (e) {
      return Response(statusCode: 1, statusText: e.toString());
    }
  }
}
