import '../entities/cat.dart';

abstract class CatState {}

class CatInitial extends CatState {}

class CatLoading extends CatState {}

class CatLoaded extends CatState {
  final Cat cat;
  final int likeCount;

  CatLoaded({required this.cat, required this.likeCount});
}

class CatError extends CatState {
  final String message;

  CatError(this.message);
}
