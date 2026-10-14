import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_store/feature/home/data/repo/product_repo/product_repo.dart';
import 'package:my_store/feature/home/presentation/manger/search_cubit/search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  final ProductRepo productRepo;

  SearchCubit({required this.productRepo}) : super(SearchInitial());

  Future<void> productSearch(String query) async {
    if (query.trim().isEmpty) {
      emit(SearchInitial());
      return;
    }

    emit(SearchLoading());

    String normalize(String text) {
      return text
          .replaceAll(RegExp(r'[\u064B-\u0652]'), '')
          .replaceAll('أ', 'ا')
          .replaceAll('إ', 'ا')
          .replaceAll('آ', 'ا')
          .replaceAll('ة', 'ه')
          .replaceAll("ي", "ى");
    }

    final normalizedQuery = normalize(query);

    final result = await productRepo.productSearch(normalizedQuery);
    result.fold(
      (failure) {
        emit(SearchFailure(errorMessage: failure.errorMessage));
      },
      (searchResult) {
        emit(SearchSuccess(products: searchResult));
      },
    );
  }
}
