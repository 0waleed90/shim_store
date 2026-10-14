import 'package:dartz/dartz.dart';

import '../../../../../core/errors/failure.dart';
import '../../models/product_model/product_model.dart';

abstract class ProductRepo {
  Future<Either<Failures, List<ProductModel>>> fetchProducts();
  Future<Either<Failures, List<ProductModel>>> productSearch(String query);
  Future<Either<Failures, List<ProductModel>>> categoryFilterBar(int query);
  Future<Either<Failures, List<ProductModel>>> priceFilter(int query);

}
