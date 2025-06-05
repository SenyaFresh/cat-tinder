import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:project/data/repositories/liked_cats_repository_impl.dart';
import 'package:project/domain/entities/cat.dart';

import 'mocks/shared_preferences_mock.mocks.dart';

void main() {
  late MockSharedPreferences mockPrefs;
  late LikedCatsRepositoryImpl repository;

  Cat testCat = Cat(
    imageUrl: 'url',
    breedName: 'Dvornyaga',
    breedDescription: 'Just cute',
  );

  setUp(() {
    mockPrefs = MockSharedPreferences();
    repository = LikedCatsRepositoryImpl.forTest(mockPrefs);
  });

  group('LikedCatsRepositoryImpl', () {
    test('saveLikedCat adds new cat', () async {
      when(mockPrefs.getStringList(any)).thenReturn([]);
      when(mockPrefs.setStringList(any, any)).thenAnswer((_) async => true);

      await repository.saveLikedCat(testCat);

      final expected = jsonEncode(testCat.toJson());
      verify(
        mockPrefs.setStringList('liked_cats', argThat(contains(expected))),
      ).called(1);
    });

    test('saveLikedCat does not add duplicate', () async {
      final encoded = jsonEncode(testCat.toJson());
      when(mockPrefs.getStringList(any)).thenReturn([encoded]);

      await repository.saveLikedCat(testCat);

      verifyNever(mockPrefs.setStringList(any, any));
    });

    test('getLikedCats returns empty list if no data', () async {
      when(mockPrefs.getStringList(any)).thenReturn(null);

      final result = await repository.getLikedCats();

      expect(result, isEmpty);
    });

    test('getLikedCats returns all saved cats', () async {
      final encoded = jsonEncode(testCat.toJson());
      when(mockPrefs.getStringList(any)).thenReturn([encoded]);

      final result = await repository.getLikedCats();

      expect(result.length, 1);
      expect(result.first.imageUrl, testCat.imageUrl);
    });

    test('removeLikedCat removes cat by imageUrl', () async {
      final encoded = jsonEncode(testCat.toJson());
      when(mockPrefs.getStringList(any)).thenReturn([encoded]);
      when(mockPrefs.setStringList(any, any)).thenAnswer((_) async => true);

      await repository.removeLikedCat(testCat);

      verify(mockPrefs.setStringList('liked_cats', [])).called(1);
    });
  });
}
