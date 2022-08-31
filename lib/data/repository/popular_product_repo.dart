import 'package:dash/data/api/api_client.dart';
import 'package:dash/utils/app_constant.dart';
import 'package:get/get.dart';

class PopularProductRepo extends GetxService {
  final ApiClient apiClient;

  PopularProductRepo({required this.apiClient});

  Future<Response> getPopularProductList() async {
    return await apiClient.getData(AppConstant.POPULAR_PRODUCT_URL);
  }
}
