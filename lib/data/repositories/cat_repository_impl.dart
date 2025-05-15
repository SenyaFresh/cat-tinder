import '../../domain/entities/cat.dart';
import '../../domain/repositories/cat_repository.dart';
import '../sources/cat_remote_data_source.dart';

class CatRepositoryImpl implements CatRepository {
  final CatRemoteDataSource remoteDataSource;

  CatRepositoryImpl(this.remoteDataSource);

  @override
  Future<Cat> fetchRandomCat() {
    return remoteDataSource.fetchRandomCat();
  }
}
