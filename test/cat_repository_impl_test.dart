import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:project/data/models/cat_model.dart';
import 'package:project/data/repositories/cat_repository_impl.dart';

import 'mocks/cat_remote_data_source_mock.mocks.dart';

Future<void> main() async {
  late MockCatRemoteDataSource mockRemote;
  late CatRepositoryImpl repository;

  Future<CatModel> testCat = Future.value(
    CatModel(
      imageUrl: 'url',
      breedName: 'Dvornyaga',
      breedDescription: 'Just cute',
    ),
  );

  setUp(() {
    mockRemote = MockCatRemoteDataSource();
    repository = CatRepositoryImpl(mockRemote);
  });

  test('fetchRandomCat returns cat when success', () async {
    when(mockRemote.fetchRandomCat()).thenAnswer((_) async => testCat);

    final result = await repository.fetchRandomCat();

    expect(result.imageUrl, equals('url'));
    verify(mockRemote.fetchRandomCat()).called(1);
  });

  test('fetchRandomCat throws exception when remoteDataSource does', () {
    when(mockRemote.fetchRandomCat()).thenThrow(Exception('Network error'));

    expect(() => repository.fetchRandomCat(), throwsA(isA<Exception>()));
    verify(mockRemote.fetchRandomCat()).called(1);
  });
}
