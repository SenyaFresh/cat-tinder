import 'package:flutter/material.dart';

import '../../domain/entities/cat.dart';
import '../widgets/cat_image.dart';

class CatDetailScreen extends StatelessWidget {
  final Cat cat;

  const CatDetailScreen({super.key, required this.cat});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(cat.breedName)),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CatImageWidget(imageUrl: cat.imageUrl),
          SizedBox(height: 20),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(cat.breedDescription, style: TextStyle(fontSize: 16)),
          ),
        ],
      ),
    );
  }
}
