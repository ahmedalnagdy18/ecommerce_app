import 'package:flutter_application_test/data/data_source/data_source.dart';
import 'package:flutter_application_test/data/reposatory_imp/repository_imp.dart';
import 'package:flutter_application_test/domain/repository/repository.dart';
import 'package:flutter_application_test/domain/usecase/usecase.dart';
import 'package:flutter_application_test/presentation/cubit/home_cubit/home_cubit.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future<void> init() async {
// Usecases

  sl.registerLazySingleton<Usecase>(() => Usecase(repository: sl()));

// Repository

  sl.registerLazySingleton<Repository>(
      () => RepositoryImpl(remoteDataSource: sl()));

// DataSource

  sl.registerLazySingleton<RemoteDataSource>(() => RemoteDataSource());

  // Cubit
  sl.registerLazySingleton<PostsCubit>(
    () => PostsCubit(Usecase(repository: sl())),
  );
}
