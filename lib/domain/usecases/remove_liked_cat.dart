import '../entities/cat.dart';
import '../repositories/liked_cats_repository.dart';

class RemoveLikedCat {
  final LikedCatsRepository repository;

  RemoveLikedCat(this.repository);

  void call(Cat cat) {
    repository.removeLikedCat(cat);
  }
}
