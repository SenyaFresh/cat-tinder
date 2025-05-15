import '../../domain/entities/cat.dart';
import '../../domain/repositories/liked_cats_repository.dart';

class LikedCatsRepositoryImpl implements LikedCatsRepository {
  final List<Cat> _liked = [];

  @override
  void saveLikedCat(Cat cat) {
    _liked.add(cat);
  }

  @override
  List<Cat> getLikedCats() => List.unmodifiable(_liked);
}
