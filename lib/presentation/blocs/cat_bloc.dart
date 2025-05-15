import 'package:bloc/bloc.dart';
import 'package:project/domain/usecases/remove_liked_cat.dart';
import 'package:project/domain/usecases/save_liked_cat.dart';

import '../../domain/events/cat_event.dart';
import '../../domain/states/cat_state.dart';
import '../../domain/usecases/fetch_random_cat.dart';

class CatBloc extends Bloc<CatEvent, CatState> {
  final FetchRandomCat fetchRandomCat;
  final SaveLikedCat saveLikedCat;
  final RemoveLikedCat removeLikedCat;
  int _likeCount = 0;

  Future<void> _onLoadCat(LoadCatEvent event, Emitter<CatState> emit) async {
    emit(CatLoading());
    try {
      final cat = await fetchRandomCat();
      emit(CatLoaded(cat: cat, likeCount: _likeCount));
    } catch (_) {
      emit(CatError('Ошибка загрузки кота'));
    }
  }

  void _onLikeCat(LikeCatEvent event, Emitter<CatState> emit) {
    final current = state;
    if (current is CatLoaded) {
      saveLikedCat(current.cat);
    }
    _likeCount++;
    add(LoadCatEvent());
  }

  void _onDislikeCat(DislikeCatEvent event, Emitter<CatState> emit) {
    add(LoadCatEvent());
  }

  void _onRemoveLikedCat(RemoveLikedCatEvent event, Emitter<CatState> emit) {
    removeLikedCat(event.cat);
    _likeCount--;
    final current = state;
    if (current is CatLoaded) {
      emit(CatLoaded(cat: current.cat, likeCount: _likeCount));
    }
  }

  CatBloc(this.fetchRandomCat, this.saveLikedCat, this.removeLikedCat) : super(CatInitial()) {
    on<LoadCatEvent>(_onLoadCat);
    on<LikeCatEvent>(_onLikeCat);
    on<DislikeCatEvent>(_onDislikeCat);
    on<RemoveLikedCatEvent>(_onRemoveLikedCat);
  }
}
