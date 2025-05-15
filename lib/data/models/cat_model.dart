import '../../domain/entities/cat.dart';

class CatModel extends Cat {
  CatModel({
    required super.imageUrl,
    required super.breedName,
    required super.breedDescription,
  });

  factory CatModel.fromJson(Map<String, dynamic> json) {
    final breed = (json['breeds'] as List).first;
    return CatModel(
      imageUrl: json['url'] as String,
      breedName: breed['name'] as String,
      breedDescription: breed['description'] as String,
    );
  }
}
