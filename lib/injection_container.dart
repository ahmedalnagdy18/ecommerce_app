import 'package:flutter_application_test/features/home/data/data_source/data_source.dart';
import 'package:flutter_application_test/features/home/data/reposatory_imp/repository_imp.dart';
import 'package:flutter_application_test/features/home/data/reposatory_imp/search_repo_imp.dart';
import 'package:flutter_application_test/features/home/domain/repository/product_repository.dart';
import 'package:flutter_application_test/features/home/domain/repository/search_repository.dart';
import 'package:flutter_application_test/features/home/domain/usecase/product_usecase.dart';
import 'package:flutter_application_test/features/home/domain/usecase/search_usecase.dart';
import 'package:flutter_application_test/features/home/presentation/cubit/home_cubit/home_cubit.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future<void> init() async {
// Usecases

  sl.registerLazySingleton<ProductUsecase>(
      () => ProductUsecase(repository: sl()));

  sl.registerLazySingleton<SearchProductsUsecase>(
      () => SearchProductsUsecase(repository: sl()));

// Repository

  sl.registerLazySingleton<Repository>(
      () => ProductRepositoryImpl(remoteDataSource: sl()));

  sl.registerLazySingleton<SearchProductRepository>(
      () => SearchProductRepositoryImpl(remoteDataSource: sl()));

// DataSource

  sl.registerLazySingleton<RemoteDataSource>(() => RemoteDataSource());

  // Cubit
  sl.registerLazySingleton<PostsCubit>(
    () => PostsCubit(ProductUsecase(repository: sl()),
        SearchProductsUsecase(repository: sl())),
  );
}
