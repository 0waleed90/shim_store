import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:my_store/core/errors/failure.dart';
import 'package:my_store/core/util/api_service.dart';
import 'package:my_store/feature/home/data/models/product_model/product_model.dart';
import 'package:my_store/feature/home/data/repo/product_repo/product_repo.dart';

class ProductRepoImpl implements ProductRepo {
  final ApiService apiService;

  ProductRepoImpl({required this.apiService});
  @override
  Future<Either<Failures, List<ProductModel>>> fetchProducts() async {
    try {
      var data = await apiService.getResponse('products');

      final List<ProductModel> products = [];
      for (var item in data) {
        products.add(ProductModel.fromJson(item));
      }
      return right(products);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioError(e));
      } else {
        return left(ServerFailure(e.toString()));
      }
    }
  }

  @override
  Future<Either<Failures, List<ProductModel>>> productSearch(
    String query,
  ) async {
    try {
      var data = await apiService.getResponse('products?title=$query');
      final List<ProductModel> searchResult = [];
      for (var item in data) {
        searchResult.add(ProductModel.fromJson(item));
      }
      return right(searchResult);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioError(e));
      } else {
        return left(ServerFailure(e.toString()));
      }
    }
  }

  @override
  Future<Either<Failures, List<ProductModel>>> categoryFilterBar(
    int query,
  ) async {
    try {
      var data = await apiService.getResponse('categories/$query/products');
      final List<ProductModel> filterResult = [];
      for (var item in data) {
        filterResult.add(ProductModel.fromJson(item));
      }
      return right(filterResult);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioError(e));
      } else {
        return left(ServerFailure(e.toString()));
      }
    }
  }

  @override
  Future<Either<Failures, List<ProductModel>>> priceFilter(int query) async {
    try {
      var data = await apiService.getResponse(
        'products?price_min=0&price_max=$query',
      );
      final List<ProductModel> filterResult = [];
      for (var item in data) {
        filterResult.add(ProductModel.fromJson(item));
      }
      return right(filterResult);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioError(e));
      } else {
        return left(ServerFailure(e.toString()));
      }
    }
  }
}
