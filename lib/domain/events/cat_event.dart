import '../entities/cat.dart';

abstract class CatEvent {}

class LoadCatEvent extends CatEvent {}

class LikeCatEvent extends CatEvent {}

class DislikeCatEvent extends CatEvent {}

class RemoveLikedCatEvent extends CatEvent {
  final Cat cat;

  RemoveLikedCatEvent(this.cat);
}
