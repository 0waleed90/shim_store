import 'package:my_store/feature/home/data/models/product_model/product_model.dart';


abstract class ProductState {}
class ProductInitial extends ProductState{}
class ProductSuccess extends ProductState{
  final List<ProductModel> products;
  final List<ProductModel> savedItems;
 final List<ProductModel> cartItems ;
final int cartItemCount;


  ProductSuccess({required this.products, required this.savedItems, required this.cartItems, required this.cartItemCount,});

}
class ProductLoading extends ProductState{}
class ProductFailure extends ProductState{
  final String errorMessage;

  ProductFailure({required this.errorMessage});

}
