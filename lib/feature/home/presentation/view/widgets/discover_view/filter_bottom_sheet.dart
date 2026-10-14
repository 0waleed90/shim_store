import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_store/core/util/styles.dart';
import 'package:my_store/core/util/widgets/custom_button.dart';
import 'package:my_store/feature/home/presentation/view/widgets/discover_view/category_filter_bar.dart';

import '../../../manger/product_cubit/product_cubit.dart';

class FilterBottomSheet extends StatefulWidget {
  const FilterBottomSheet({super.key});

  @override
  State<FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  double _selectedMaxPrice = 100;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: SizedBox(
        height: 405,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Filter', style: Styles.textStyle24),
                IconButton(
                  onPressed: () {
                    Navigator.of(context, rootNavigator: true).pop();
                  },
                  icon: const Icon(Icons.close),
                ),
              ],
            ),
            const SizedBox(height: 10, child: Divider()),
            const Text('Sorted by', style: Styles.textStyle16),
            const SizedBox(height: 10),
            const CategoryFilterBar(),
            const SizedBox(height: 10, child: Divider()),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Max Price', style: Styles.textStyle16),
                Text(
                  '\$${_selectedMaxPrice.round()}',
                  style: Styles.textStyle16.copyWith(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Slider(
              value: _selectedMaxPrice,
              min: 0,
              max: 100,
              divisions: 50,
              activeColor: Colors.black,
              label: '\$${_selectedMaxPrice.round()}',
              onChanged: (double value) {
                setState(() {
                  _selectedMaxPrice = value;
                });
              },
            ),
            const SizedBox(height: 20, child: Divider()),
           Spacer(),
            CustomButton(
              text: 'Apply Filters',
              color: Colors.black,
              textColor: Colors.white,
              width: double.infinity,
              onTap: () {
                context
                    .read<ProductCubit>()
                    .priceFilter(_selectedMaxPrice.round());
                Navigator.of(context, rootNavigator: true).pop();
              },
            ),
          ],
        ),
      ),
    );
  }
}
