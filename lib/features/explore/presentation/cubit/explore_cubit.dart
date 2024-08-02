import 'package:flutter_application_test/features/explore/presentation/cubit/explore_state.dart';
import 'package:flutter_application_test/features/home/domain/usecase/product_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExploreCubit extends Cubit<ExploreState> {
  final ProductUsecase _usecase;

  ExploreCubit(this._usecase) : super(ExplorePostsInitial());

// get the posts
  Future<void> getExploreData() async {
    try {
      final response = await _usecase.call();

      if (response.isNotEmpty) {
        emit(ExplorePostsLoaded(response));
      }
    } catch (e) {
      emit(const ExplorePostsError('no data found'));
    }
  }
}
