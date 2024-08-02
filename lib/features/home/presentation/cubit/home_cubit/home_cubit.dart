import 'package:flutter_application_test/features/home/domain/usecase/product_usecase.dart';
import 'package:flutter_application_test/features/home/domain/usecase/search_usecase.dart';
import 'package:flutter_application_test/features/home/presentation/cubit/home_cubit/home_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostsCubit extends Cubit<HomeState> {
  final ProductUsecase _usecase;
  final SearchProductsUsecase _searchProductsUsecase;

  PostsCubit(this._usecase, this._searchProductsUsecase)
      : super(PostsInitial());

// get the posts
  Future<void> fetchData() async {
    try {
      final response = await _usecase.call();

      if (response.isNotEmpty) {
        emit(PostsLoaded(response));
      }
    } catch (e) {
      emit(const PostsError('no data found'));
    }
  }

  // search
  void searchFuc({required String query}) async {
    emit(SearchLoading());
    try {
      final result = await _searchProductsUsecase.execute(query);
      emit(SearchLoaded(result));
    } catch (e) {
      emit(SearchError('Error occurred ${e.toString()}'));
    }
  }
}
