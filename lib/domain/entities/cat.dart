class Cat {
  final String imageUrl;
  final String breedName;
  final String breedDescription;

  Cat({
    required this.imageUrl,
    required this.breedName,
    required this.breedDescription,
  });

  Map<String, dynamic> toJson() {
    return {
      'imageUrl': imageUrl,
      'breedName': breedName,
      'breedDescription': breedDescription,
    };
  }

  factory Cat.fromJson(Map<String, dynamic> json) {
    return Cat(
      imageUrl: json['imageUrl'] as String,
      breedName: json['breedName'] as String,
      breedDescription: json['breedDescription'] as String,
    );
  }
}
