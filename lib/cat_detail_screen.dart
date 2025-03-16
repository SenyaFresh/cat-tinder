import 'package:flutter/material.dart';
import 'package:project/cat_image.dart';

class CatDetailScreen extends StatelessWidget {
  final String imageUrl;
  final String breedName;
  final String breedDescription;

  const CatDetailScreen({
    super.key,
    required this.imageUrl,
    required this.breedName,
    required this.breedDescription,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(breedName)),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CatImageWidget(imageUrl: imageUrl),
          SizedBox(height: 20),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(breedDescription, style: TextStyle(fontSize: 16)),
          ),
        ],
      ),
    );
  }
}
