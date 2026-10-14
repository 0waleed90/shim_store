import 'package:dio/dio.dart';

class ApiService {
  final Dio _dio;
  final String baseUrl = 'https://api.escuelajs.co/api/v1/';

  ApiService(this._dio) {
    _dio.options.connectTimeout = const Duration(seconds: 15);
    _dio.options.receiveTimeout = const Duration(seconds: 15);
  }

  Future<dynamic> getResponse(String endPoint) async {
    var response = await _dio.get('$baseUrl$endPoint');
    return response.data;
  }
}
/*
* https://api.escuelajs.co/api/v1/categories      للاصناف
* https://api.escuelajs.co/api/v1/products       لمنتجات
* https://api.escuelajs.co/api/v1/categories/x/products    لجلب منتجال لصنف محدد
*https://api.escuelajs.co/api/v1/products?title=x    للبحث
* https://api.escuelajs.co/api/v1/products?categoryId=1  للتصفية حسب الصنف
* https://api.escuelajs.co/api/v1/products?price_min=10&price_max=100
*
* */