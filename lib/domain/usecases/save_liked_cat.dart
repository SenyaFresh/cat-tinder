import '../entities/cat.dart';
import '../repositories/liked_cats_repository.dart';

class SaveLikedCat {
  final LikedCatsRepository repository;

  SaveLikedCat(this.repository);

  void call(Cat cat) {
    repository.saveLikedCat(cat);
  }
}
