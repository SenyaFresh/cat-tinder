import '../entities/cat.dart';
import '../repositories/liked_cats_repository.dart';

class GetLikedCats {
  final LikedCatsRepository repository;

  GetLikedCats(this.repository);

  List<Cat> call() {
    return repository.getLikedCats();
  }
}
