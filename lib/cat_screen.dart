import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:project/cat_image.dart';

import 'cat_detail_screen.dart';
import 'like_dislike_button.dart';

class CatScreen extends StatefulWidget {
  const CatScreen({super.key});

  @override
  CatScreenState createState() => CatScreenState();
}

class CatScreenState extends State<CatScreen> {
  String imageUrl = '';
  String breedName = '';
  String breedDescription = '';
  int likeCount = 0;
  final Dio dio = Dio();

  @override
  void initState() {
    super.initState();
    fetchRandomCat();
  }

  Future<void> fetchRandomCat() async {
    try {
      setState(() {
        imageUrl = '';
      });
      final response = await dio.get(
        'https://api.thecatapi.com/v1/images/search?has_breeds=1&api_key=live_el6M26XxT9scEzHcC7jXpdUcIe5mZ3zTv6ZuM9IieV0nkOrs07QfMeBlJgOoV7ka',
      );
      if (response.data.isNotEmpty) {
        setState(() {
          imageUrl = response.data[0]['url'];
          breedName = response.data[0]['breeds'][0]['name'] ?? 'Unknown';
          breedDescription =
              response.data[0]['breeds'][0]['description'] ??
              'No description available';
        });
      }
    } catch (e) {
      log('Error fetching cat: $e');
    }
  }

  void onLike() {
    setState(() {
      likeCount++;
    });
    fetchRandomCat();
  }

  void onDislike() {
    fetchRandomCat();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap:
                () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (context) => CatDetailScreen(
                          imageUrl: imageUrl,
                          breedName: breedName,
                          breedDescription: breedDescription,
                        ),
                  ),
                ),
            onHorizontalDragEnd: (details) {
              if (details.primaryVelocity! < 0) {
                onDislike();
              } else if (details.primaryVelocity! > 0) {
                onLike();
              }
            },
            child: CatImageWidget(imageUrl: imageUrl),
          ),
          SizedBox(height: 20),
          Text(
            breedName,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          Text(
            'Likes: $likeCount',
            style: TextStyle(fontSize: 18),
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              LikeDislikeButton(
                icon: Icons.close_rounded,
                onPressed: onDislike,
                color: Colors.red,
              ),
              SizedBox(width: 20),
              LikeDislikeButton(
                icon: Icons.favorite,
                onPressed: onLike,
                color: Colors.pinkAccent,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
