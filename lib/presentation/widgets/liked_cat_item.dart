import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/cat.dart';
import '../../domain/events/cat_event.dart';
import '../blocs/cat_bloc.dart';

class LikedCatItem extends StatelessWidget {
  final Cat cat;

  const LikedCatItem({super.key, required this.cat});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black, width: 2),
            borderRadius: BorderRadius.circular(12),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(
              cat.imageUrl,
              fit: BoxFit.cover,
              errorBuilder:
                  (_, __, ___) => Container(
                    color: Colors.grey[300],
                    child: const Icon(Icons.error, color: Colors.red, size: 40),
                  ),
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Text(
            cat.breedName,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
        ),
        IconButton(
          icon: Icon(Icons.close, color: Colors.black),
          onPressed: () {
            context.read<CatBloc>().add(RemoveLikedCatEvent(cat));
          },
        ),
      ],
    );
  }
}
