import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CatImageWidget extends StatelessWidget {
  final String imageUrl;

  const CatImageWidget({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: 400,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black, width: 3),
        borderRadius: BorderRadius.circular(20),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(17),
        child:
            imageUrl.isNotEmpty
                ? CachedNetworkImage(
                  imageUrl: imageUrl,
                  fit: BoxFit.cover,
                  errorWidget:
                      (context, url, error) => Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                        ),
                        child: Icon(Icons.error, size: 50, color: Colors.red),
                      ),
                )
                : Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                  ),
                  child: CircularProgressIndicator(),
                ),
      ),
    );
  }
}
