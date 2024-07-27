import 'package:flutter_application_test/data/data_source/data_source.dart';
import 'package:flutter_application_test/data/reposatory_imp/repository_imp.dart';
import 'package:flutter_application_test/domain/repository/product_repository.dart';
import 'package:flutter_application_test/domain/usecase/product_usecase.dart';
import 'package:flutter_application_test/presentation/cubit/home_cubit/home_cubit.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future<void> init() async {
// Usecases

  sl.registerLazySingleton<ProductUsecase>(
      () => ProductUsecase(repository: sl()));

// Repository

  sl.registerLazySingleton<Repository>(
      () => ProductRepositoryImpl(remoteDataSource: sl()));

// DataSource

  sl.registerLazySingleton<RemoteDataSource>(() => RemoteDataSource());

  // Cubit
  sl.registerLazySingleton<PostsCubit>(
    () => PostsCubit(ProductUsecase(repository: sl())),
  );
}
