part of 'news_bloc.dart';

@immutable
class NewsState extends Equatable {
  const NewsState();

  @override
  List<Object> get props => [];
}

///data loading state
class NewsLoadingState extends NewsState {
  @override
  List<Object> get props => [];
}

///data loaded state
class NewsLoadedState extends NewsState {
  final List<News> articles;
  const NewsLoadedState(this.articles);
  @override
  List<Object> get props => [articles];
}

//error state
class NewsErrorState extends NewsState {
  final String error;
  const NewsErrorState(this.error);

  @override
  List<Object> get props => [error];
}
