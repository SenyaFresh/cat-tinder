import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import 'data/repositories/cat_repository_impl.dart';
import 'data/repositories/liked_cats_repository_impl.dart';
import 'data/sources/cat_remote_data_source_impl.dart';
import 'domain/events/cat_event.dart';
import 'domain/repositories/liked_cats_repository.dart';
import 'domain/usecases/fetch_random_cat.dart';
import 'domain/usecases/get_liked_cats.dart';
import 'domain/usecases/save_liked_cat.dart';
import 'presentation/blocs/cat_bloc.dart';

final sl = GetIt.instance;

void setupServiceLocator() {
  sl.registerLazySingleton<Dio>(() => Dio());

  sl.registerLazySingleton<CatRemoteDataSourceImpl>(
    () => CatRemoteDataSourceImpl(sl<Dio>()),
  );

  sl.registerLazySingleton<CatRepositoryImpl>(
    () => CatRepositoryImpl(sl<CatRemoteDataSourceImpl>()),
  );

  sl.registerLazySingleton<FetchRandomCat>(
    () => FetchRandomCat(sl<CatRepositoryImpl>()),
  );

  sl.registerLazySingleton<LikedCatsRepository>(
    () => LikedCatsRepositoryImpl(),
  );

  sl.registerLazySingleton<SaveLikedCat>(
    () => SaveLikedCat(sl<LikedCatsRepository>()),
  );
  sl.registerLazySingleton<GetLikedCats>(
    () => GetLikedCats(sl<LikedCatsRepository>()),
  );

  sl.registerFactory<CatBloc>(
    () =>
        CatBloc(sl<FetchRandomCat>(), sl<SaveLikedCat>())..add(LoadCatEvent()),
  );
}
