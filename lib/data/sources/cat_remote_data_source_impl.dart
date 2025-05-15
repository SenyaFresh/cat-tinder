import 'package:dio/dio.dart';

import '../models/cat_model.dart';
import 'cat_remote_data_source.dart';

class CatRemoteDataSourceImpl implements CatRemoteDataSource {
  final Dio dio;

  CatRemoteDataSourceImpl(this.dio);

  @override
  Future<CatModel> fetchRandomCat() async {
    final response = await dio.get(
      'https://api.thecatapi.com/v1/images/search?has_breeds=1&api_key=live_el6M26XxT9scEzHcC7jXpdUcIe5mZ3zTv6ZuM9IieV0nkOrs07QfMeBlJgOoV7ka',
    );
    return CatModel.fromJson(response.data[0] as Map<String, dynamic>);
  }
}
