import 'package:flutter_application_test/domain/usecase/product_usecase.dart';
import 'package:flutter_application_test/presentation/cubit/home_cubit/home_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostsCubit extends Cubit<HomeState> {
  final ProductUsecase _usecase;

  PostsCubit(this._usecase) : super(PostsInitial());

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
}
