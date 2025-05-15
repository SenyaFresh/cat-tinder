import '../models/cat_model.dart';

abstract class CatRemoteDataSource {
  Future<CatModel> fetchRandomCat();
}
