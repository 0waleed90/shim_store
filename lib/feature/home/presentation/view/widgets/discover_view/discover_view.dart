import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_store/core/util/app_router.dart';
import 'package:my_store/core/util/widgets/custom_text_field.dart';
import 'package:my_store/feature/home/presentation/view/widgets/discover_view/custom_discover_grid_view.dart';
import 'package:my_store/feature/home/presentation/view/widgets/discover_view/filter_bottom_sheet.dart';

import '../../../../../../core/util/styles.dart';
import 'category_filter_bar.dart';

class DiscoverView extends StatelessWidget {
  const DiscoverView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Discover', style: Styles.textStyle32)),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14),
        child:Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 281,
                  child: CustomTextField(
                    onTap: () {GoRouter.of(context).push(AppRouter.kSearchView);},
                    hintText: 'Search for clothes...',
                    prefixIcon: const Icon(Icons.search),
                    suffixIcon: const Icon(Icons.mic),
                    readOnly: true,
                  ),
                ),

                const SizedBox(width: 10),
                SizedBox(
                  height: 52,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      shape: WidgetStateProperty.all(
                        ContinuousRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),

                      backgroundColor: WidgetStateProperty.all(Colors.black),
                    ),

                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled:
                            true, // للسماح لها بأخذ مساحة أكبر إذا لزم الأمر
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(20),
                          ),
                        ),
                        builder: (context) => const FilterBottomSheet(),
                      );
                    },
                    child: const Icon(color: Colors.white, Icons.filter_alt),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            const CategoryFilterBar(),
            const SizedBox(height: 10),
            const Expanded(
              child: CustomDiscoverGridView(),
            ),
          ],
        ),
      ),
    );
  }
}
