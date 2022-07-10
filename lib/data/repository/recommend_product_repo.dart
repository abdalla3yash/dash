import 'package:dash/data/api/api_client.dart';
import 'package:dash/utils/app_constant.dart';
import 'package:get/get.dart';

class RecommendProductRepo extends GetxService {
  final ApiClient apiClient;

  RecommendProductRepo({required this.apiClient});

  Future<Response> getRecommendProductList() async {
    return await apiClient.getData(AppConstant.RECOMMENDED_PRODUCT_URL);
  }
}
