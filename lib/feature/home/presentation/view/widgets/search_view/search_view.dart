import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_store/core/util/widgets/custom_text_field.dart';
import 'package:my_store/feature/home/presentation/manger/search_cubit/search_cubit.dart';
import 'package:my_store/feature/home/presentation/manger/search_cubit/search_state.dart';
import 'package:my_store/feature/home/presentation/view/widgets/search_view/empty_search.dart';

import '../../../../../../core/util/styles.dart';
import '../discover_view/grid_view_item.dart';

class SearchView extends StatelessWidget {
  const SearchView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Search', style: Styles.textStyle32)),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: CustomTextField(
              readOnly: false,
              hintText: 'Search for clothes...',
              prefixIcon: const Icon(Icons.search),
              suffixIcon: const Icon(Icons.mic),
              onChanged: (value) {
                context.read<SearchCubit>().productSearch(value);
              },
            ),
          ),
          Expanded(
            child: BlocBuilder<SearchCubit, SearchState>(
              builder: (context, state) {
                if (state is SearchLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is SearchSuccess) {
                  if (state.products.isEmpty) {
                    return const EmptySearch();
                  }
                  return GridView.builder(
                    itemCount: state.products.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          childAspectRatio: 0.65,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          crossAxisCount: 2,
                        ),
                    itemBuilder: (context, index) {
                      return GridViewItem(
                        product: state.products[index],
                      );
                    },
                  );
                } else if (state is SearchFailure) {
                  return Center(child: Text(state.errorMessage));
                } else {
                  return const EmptySearch();
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
