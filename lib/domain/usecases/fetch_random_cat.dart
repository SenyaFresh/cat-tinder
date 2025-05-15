import '../entities/cat.dart';
import '../repositories/cat_repository.dart';

class FetchRandomCat {
  final CatRepository repository;

  FetchRandomCat(this.repository);

  Future<Cat> call() async {
    return await repository.fetchRandomCat();
  }
}
