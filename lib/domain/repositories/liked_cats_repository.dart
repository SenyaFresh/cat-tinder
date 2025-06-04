import '../entities/cat.dart';

abstract class LikedCatsRepository {
  Future<void> saveLikedCat(Cat cat);

  Future<List<Cat>> getLikedCats();

  Future<void> removeLikedCat(Cat cat);
}
