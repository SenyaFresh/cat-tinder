import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/events/cat_event.dart';
import '../../domain/states/cat_state.dart';
import '../blocs/cat_bloc.dart';
import '../widgets/cat_image.dart';
import '../widgets/like_dislike_button.dart';
import 'cat_detail_screen.dart';
import 'liked_cats_screen.dart';

class CatScreen extends StatefulWidget {
  const CatScreen({super.key});

  @override
  State<CatScreen> createState() => _CatScreenState();
}

class _CatScreenState extends State<CatScreen> {
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;
  final Connectivity _connectivity = Connectivity();
  bool _isOffline = false;

  @override
  void initState() {
    super.initState();

    _connectivitySubscription = _connectivity.onConnectivityChanged.listen((
      result,
    ) {
      if (result == ConnectivityResult.none) {
        if (!_isOffline) {
          _isOffline = true;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Нет подключения к интернету'),
              backgroundColor: Colors.red,
              duration: Duration(seconds: 5),
            ),
          );
        }
      } else {
        if (_isOffline) {
          _isOffline = false;
          ScaffoldMessenger.of(context).hideCurrentSnackBar();

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Соединение восстановлено'),
              backgroundColor: Colors.green,
              duration: Duration(seconds: 3),
            ),
          );
        }
      }
    });
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cat Tinder'),
        actions: [
          IconButton(
            icon: const Icon(Icons.list),
            onPressed: () {
              final catBloc = context.read<CatBloc>();
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder:
                      (context) => BlocProvider.value(
                        value: catBloc,
                        child: const LikedCatsScreen(),
                      ),
                ),
              );
            },
          ),
        ],
      ),
      body: BlocConsumer<CatBloc, CatState>(
        listener: (context, state) {
          if (state is CatError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Не удалось загрузить котика('),
                action: SnackBarAction(
                  label: 'Перезагрузить',
                  onPressed: () {
                    context.read<CatBloc>().add(LoadCatEvent());
                  },
                ),
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is CatLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is CatLoaded) {
            final cat = state.cat;
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap:
                      () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => CatDetailScreen(cat: cat),
                        ),
                      ),
                  onHorizontalDragEnd: (details) {
                    if (details.primaryVelocity! > 0) {
                      context.read<CatBloc>().add(DislikeCatEvent());
                    } else {
                      context.read<CatBloc>().add(LikeCatEvent());
                    }
                  },
                  child: CatImageWidget(imageUrl: cat.imageUrl),
                ),
                SizedBox(height: 20),
                Text(
                  cat.breedName,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                Text(
                  'Likes: ${state.likeCount}',
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    LikeDislikeButton(
                      icon: Icons.close_rounded,
                      onPressed:
                          () => context.read<CatBloc>().add(DislikeCatEvent()),
                      color: Colors.red,
                    ),
                    SizedBox(width: 20),
                    LikeDislikeButton(
                      icon: Icons.favorite,
                      onPressed:
                          () => context.read<CatBloc>().add(LikeCatEvent()),
                      color: Colors.pinkAccent,
                    ),
                  ],
                ),
              ],
            );
          } else if (state is CatError) {
            return Center(child: Text('Ошибка при загрузке котика'));
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}
