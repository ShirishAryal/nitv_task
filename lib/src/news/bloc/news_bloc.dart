import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:nitv_task_repository/nitv_task_repository.dart';

part 'news_event.dart';
part 'news_state.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  final NitvTaskRepository _nitvTaskRepository;

  NewsBloc(this._nitvTaskRepository) : super(NewsLoadingState()) {
    on<LoadNewsEvent>((event, emit) async {
      log('Entering news loading state');
      emit(NewsLoadingState());
      try {
        final articles = await _nitvTaskRepository.getNews();
        log('Entering data loaded state');
        emit(NewsLoadedState(articles));
      } catch (e) {
        emit(NewsErrorState(e.toString()));
      }
    });

    on<RefreshNewsEvent>((event, emit) async {
      log('Entering news loading state');
      // emit(NewsLoadingState());
      try {
        final articles = await _nitvTaskRepository.getNews();
        log('Entering data loaded state');
        emit(NewsLoadedState(articles));
      } catch (e) {
        emit(NewsErrorState(e.toString()));
      }
    });
  }
}
