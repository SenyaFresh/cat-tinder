import '../entities/cat.dart';

abstract class LikedCatsRepository {
  void saveLikedCat(Cat cat);

  List<Cat> getLikedCats();
}
