import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/entities/cat.dart';
import '../../domain/repositories/liked_cats_repository.dart';

class LikedCatsRepositoryImpl implements LikedCatsRepository {
  static const String _keyLikedCats = 'liked_cats';
  final SharedPreferences? _prefsForTest;

  LikedCatsRepositoryImpl({SharedPreferences? prefs}) : _prefsForTest = prefs;

  LikedCatsRepositoryImpl.forTest(SharedPreferences prefs)
      : _prefsForTest = prefs;

  Future<SharedPreferences> get _prefs async =>
      _prefsForTest ?? await SharedPreferences.getInstance();

  @override
  Future<void> saveLikedCat(Cat cat) async {
    final prefs = await _prefs;

    final List<String> currentList =
        prefs.getStringList(_keyLikedCats) ?? <String>[];

    final String encoded = jsonEncode(cat.toJson());

    final bool alreadyExists = currentList.any((item) {
      final Map<String, dynamic> map = jsonDecode(item);
      return (map['imageUrl'] as String) == cat.imageUrl;
    });

    if (!alreadyExists) {
      currentList.add(encoded);
      await prefs.setStringList(_keyLikedCats, currentList);
    }
  }

  @override
  Future<List<Cat>> getLikedCats() async {
    final prefs = await _prefs;
    final List<String>? encodedList = prefs.getStringList(_keyLikedCats);

    if (encodedList == null || encodedList.isEmpty) {
      return <Cat>[];
    }

    return encodedList.map((item) {
      final Map<String, dynamic> map = jsonDecode(item);
      return Cat.fromJson(map);
    }).toList();
  }

  @override
  Future<void> removeLikedCat(Cat cat) async {
    final prefs = await _prefs;
    final List<String>? encodedList = prefs.getStringList(_keyLikedCats);

    if (encodedList == null || encodedList.isEmpty) {
      return;
    }

    final List<String> updatedList =
        encodedList.where((item) {
          final Map<String, dynamic> map = jsonDecode(item);
          return (map['imageUrl'] as String) != cat.imageUrl;
        }).toList();

    await prefs.setStringList(_keyLikedCats, updatedList);
  }
}
