import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/cat.dart';
import '../../domain/states/cat_state.dart';
import '../../domain/usecases/get_liked_cats.dart';
import '../../service_locator.dart';
import '../blocs/cat_bloc.dart';
import '../widgets/liked_cat_item.dart';

class LikedCatsScreen extends StatelessWidget {
  const LikedCatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Liked Cats')),
      body: BlocBuilder<CatBloc, CatState>(
        builder: (context, state) {
          final List<Cat> likedCats = sl<GetLikedCats>()();
          return likedCats.isEmpty
              ? const Center(child: Text('Пока нет лайкнутых котиков('))
              : ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: likedCats.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: LikedCatItem(cat: likedCats[index]),
                  );
                },
              );
        },
      ),
    );
  }
}
