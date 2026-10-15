import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_store/feature/home/data/models/product_model/categories.dart';
import 'package:my_store/feature/home/presentation/manger/product_cubit/product_cubit.dart';
import 'package:my_store/feature/home/presentation/manger/product_cubit/product_state.dart';

class CategoryFilterBar extends StatefulWidget {
  const CategoryFilterBar({super.key});

  @override
  State<CategoryFilterBar> createState() => _CategoryFilterBarState();
}

class _CategoryFilterBarState extends State<CategoryFilterBar> {
  int? selectedCategoryId;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductCubit, ProductState>(
      builder: (context, state) {

        final allProducts = context.read<ProductCubit>().allProducts;

        // تجميع التصنيفات الفريدة لمنع التكرار
        final categoriesMap = <int, Categories>{};
        for (var product in allProducts) {
          if (product.category.id != 0 && product.category.name.isNotEmpty) {
            categoriesMap[product.category.id] = product.category;
          }
        }
        final categories = categoriesMap.values.toList();

        if (categories.isEmpty) {
          return const SizedBox.shrink();
        }

        return Container(
          color: Colors.white,
          height: 45,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                // زر "الكل" لإلغاء الفلترة
                GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedCategoryId = null;
                    });
                    context.read<ProductCubit>().fetchProducts();
                  },
                  child: AnimatedContainer(
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    duration: const Duration(milliseconds: 200),
                    decoration: BoxDecoration(
                      color: selectedCategoryId == null
                          ? const Color(0xff1e1e24)
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: selectedCategoryId == null
                            ? Colors.transparent
                            : Colors.black,
                        width: 1,
                      ),
                    ),
                    child: Text(
                      'All',
                      style: TextStyle(
                        color: selectedCategoryId == null
                            ? Colors.white
                            : Colors.black,
                        fontSize: 15,
                        fontWeight: selectedCategoryId == null
                            ? FontWeight.bold
                            : FontWeight.normal,
                      ),
                    ),
                  ),
                ),
                ...categories.map((category) {
                  final isSelected = selectedCategoryId == category.id;
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedCategoryId = category.id;
                      });
                      context
                          .read<ProductCubit>()
                          .categoryFilterBar(category.id);
                    },
                    child: AnimatedContainer(
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      duration: const Duration(milliseconds: 200),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? const Color(0xff1e1e24)
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: isSelected ? Colors.transparent : Colors.black,
                          width: 1,
                        ),
                      ),
                      child: Text(
                        category.name,
                        style: TextStyle(
                          color: isSelected ? Colors.white : Colors.black,
                          fontSize: 15,
                          fontWeight: isSelected
                              ? FontWeight.bold
                              : FontWeight.normal,
                        ),
                      ),
                    ),
                  );
                }),
              ],
            ),
          ),
        );
      },
    );
  }
}
