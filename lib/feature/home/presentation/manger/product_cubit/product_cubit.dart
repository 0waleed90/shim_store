import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:my_store/core/util/hive_boxes.dart';
import 'package:my_store/feature/home/data/models/product_model/product_model.dart';
import 'package:my_store/feature/home/presentation/manger/product_cubit/product_state.dart';

import '../../../data/models/product_model/categories.dart';
import '../../../data/repo/product_repo/product_repo.dart';

class ProductCubit extends Cubit<ProductState> {
  final ProductRepo productRepo;
  List<ProductModel> allProducts = [];
  List<ProductModel> savedItems = [];
  List<ProductModel> cartItems = [];
  int cartItemCount = 0;
  ProductCubit({required this.productRepo}) : super(ProductInitial());

  Future<void> fetchProducts() async {
    emit(ProductLoading());

    final result = await productRepo.fetchProducts();
    result.fold(
      (failure) {
        emit(ProductFailure(errorMessage: failure.errorMessage));
      },
      (fetchedProducts) {
        allProducts = fetchedProducts;
        emit(
          ProductSuccess(
            products: fetchedProducts,
            savedItems: savedItems,
            cartItems: cartItems,
            cartItemCount: cartItemCount,
          ),
        );
      },
    );
  }

  Future<void> categoryFilterBar(int categoryId) async {
    emit(ProductLoading());

    if (allProducts.isNotEmpty) {
      final filtered = allProducts
          .where((p) => p.category.id == categoryId)
          .toList();
      emit(
        ProductSuccess(
          products: filtered,
          savedItems: savedItems,
          cartItems: cartItems,
          cartItemCount: cartItemCount,
        ),
      );
      return;
    }

    final data = await productRepo.categoryFilterBar(categoryId);
    data.fold(
      (failure) {
        emit(ProductFailure(errorMessage: failure.errorMessage));
      },
      (filteredProducts) {
        emit(
          ProductSuccess(
            products: filteredProducts,
            savedItems: savedItems,
            cartItems: cartItems,
            cartItemCount: cartItemCount,
          ),
        );
      },
    );
  }

  Future<void> priceFilter(int maxPrice) async {
    emit(ProductLoading());

    if (allProducts.isNotEmpty) {
      final filtered = allProducts.where((p) => p.price <= maxPrice).toList();
      emit(
        ProductSuccess(
          products: filtered,
          savedItems: savedItems,
          cartItems: cartItems,
          cartItemCount: cartItemCount,
        ),
      );
      return;
    }

    final data = await productRepo.priceFilter(maxPrice);
    data.fold(
      (failure) {
        emit(ProductFailure(errorMessage: failure.errorMessage));
      },
      (filteredProducts) {
        emit(
          ProductSuccess(
            products: filteredProducts,
            savedItems: savedItems,
            cartItems: cartItems,
            cartItemCount: cartItemCount,
          ),
        );
      },
    );
  }

  void addToSaved(
    int id,
    String title,
    int price,
    String description,
    Categories category,
    List<String> images,
  ) {
    savedItems.add(
      ProductModel(
        title: title,
        description: description,
        price: price,
        id: id,
        category: category,
        images: images,
      ),
    );

    Hive.box(HiveBoxes.basicBox).put(
      HiveBoxes.kSavedProductBox,
      savedItems.map((e) => e.toJson()).toList(),
    );
    emit(
      ProductSuccess(
        products: allProducts,
        savedItems: savedItems,
        cartItems: cartItems,
        cartItemCount: cartItemCount,
      ),
    );
  }

  void removeFromSaved(
    int id,
    String title,
    int price,
    String description,
    Categories category,
    List<String> images,
  ) {
    savedItems.removeWhere(
      (element) =>
          element.id == id &&
          element.title == title &&
          element.price == price &&
          element.category == category &&
          element.description == description &&
          element.images == images,
    );
    Hive.box(HiveBoxes.basicBox).put(
      HiveBoxes.kSavedProductBox,
      savedItems.map((e) => e.toJson()).toList(),
    );
    emit(
      ProductSuccess(
        products: allProducts,
        savedItems: savedItems,
        cartItems: cartItems,
        cartItemCount: cartItemCount,
      ),
    );
  }

  void getSavedItems() {
    try {
      var rawData =
          Hive.box(
                HiveBoxes.basicBox,
              ).get(HiveBoxes.kSavedProductBox, defaultValue: [])
              as List;
      savedItems = rawData
          .map((e) => ProductModel.fromJson(Map<String, dynamic>.from(e)))
          .toList();
    } catch (e) {
      savedItems = [];
      Hive.box(HiveBoxes.basicBox).delete(HiveBoxes.kSavedProductBox);
    }
    emit(
      ProductSuccess(
        products: allProducts,
        savedItems: savedItems,
        cartItems: cartItems,
        cartItemCount: cartItemCount,
      ),
    );
  }

  void addToCart(
    int id,
    String title,
    int price,
    String description,
    Categories category,

    List<String> images,
    String size,
  ) {
    int existingIndex = cartItems.indexWhere((element) => element.id == id);
    if (existingIndex != -1) {
      cartItems[existingIndex].quantity++;
    } else {
      cartItems.add(
        ProductModel(
          title: title,
          description: description,
          price: price,
          id: id,
          category: category,
          images: images,
          quantity: 1,
        ),
      );
    }
    Hive.box(
      HiveBoxes.basicBox,
    ).put(HiveBoxes.kCartItemBox, cartItems.map((e) => e.toJson()).toList());
    emit(
      ProductSuccess(
        products: allProducts,
        savedItems: savedItems,
        cartItems: cartItems,
        cartItemCount: totalCartCount,
      ),
    );
  }

  void removeFromCart(
    int id,
    String title,
    int price,
    String description,
    Categories category,
    List<String> images,
  ) {
    cartItems.removeWhere((element) => element.id == id);
    Hive.box(
      HiveBoxes.basicBox,
    ).put(HiveBoxes.kCartItemBox, cartItems.map((e) => e.toJson()).toList());
    emit(
      ProductSuccess(
        products: allProducts,
        savedItems: savedItems,
        cartItems: cartItems,
        cartItemCount: totalCartCount,
      ),
    );
  }

  void clearCart() {
    cartItems = [];
    Hive.box(
      HiveBoxes.basicBox,
    ).put(HiveBoxes.kCartItemBox, cartItems.map((e) => e.toJson()).toList());
    emit(
      ProductSuccess(
        products: allProducts,
        savedItems: savedItems,
        cartItems: cartItems,
        cartItemCount: cartItemCount,
      ),
    );
  }

  void getCartItems() {
    try {
      var rawData =
          Hive.box(
                HiveBoxes.basicBox,
              ).get(HiveBoxes.kCartItemBox, defaultValue: [])
              as List;
      cartItems = rawData
          .map((e) => ProductModel.fromJson(Map<String, dynamic>.from(e)))
          .toList();
    } catch (e) {
      cartItems = [];
      Hive.box(HiveBoxes.basicBox).delete(HiveBoxes.kCartItemBox);
    }
    emit(
      ProductSuccess(
        products: allProducts,
        savedItems: savedItems,
        cartItems: cartItems,
        cartItemCount: totalCartCount,
      ),
    );
  }

  void increaseCartItemCount(int index) {
    if (index >= 0 && index < cartItems.length) {
      cartItems[index].quantity++;
      Hive.box(
        HiveBoxes.basicBox,
      ).put(HiveBoxes.kCartItemBox, cartItems.map((e) => e.toJson()).toList());
      emit(
        ProductSuccess(
          products: allProducts,
          savedItems: savedItems,
          cartItems: cartItems,
          cartItemCount: totalCartCount,
        ),
      );
    }
  }

  void decreaseCartItemCount(int index) {
    if (index >= 0 && index < cartItems.length) {
      if (cartItems[index].quantity > 1) {
        cartItems[index].quantity--;
        Hive.box(HiveBoxes.basicBox).put(
          HiveBoxes.kCartItemBox,
          cartItems.map((e) => e.toJson()).toList(),
        );
        emit(
          ProductSuccess(
            products: allProducts,
            savedItems: savedItems,
            cartItems: cartItems,
            cartItemCount: totalCartCount,
          ),
        );
      }
    }
  }

  int get totalCartCount {
    return cartItems.fold(0, (sum, item) => sum + item.quantity);
  }

  void getCartItemCount() {
    cartItemCount = totalCartCount;
  }

  int getTotalOfCartItem() {
    int total = 0;
    for (int i = 0; i < cartItems.length; i++) {
      total += cartItems[i].price * cartItems[i].quantity;
    }
    return total;
  }
}

//SavedModel.fromJson(Map<String, dynamic>.from(e))
