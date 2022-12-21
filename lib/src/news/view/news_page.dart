import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nitv_task_repository/nitv_task_repository.dart';

import '../bloc/news_bloc.dart';

class NewsPage extends StatelessWidget {
  const NewsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AppBar(title: const Text('News')),
      ),
      body: BlocProvider(
        create: (context) => NewsBloc(context.read<NitvTaskRepository>())..add(LoadNewsEvent()),
        child: BlocBuilder<NewsBloc, NewsState>(builder: (context, state) {
          if (state is NewsLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is NewsLoadedState) {
            return RefreshIndicator(
                onRefresh: () async => BlocProvider.of<NewsBloc>(context)..add(RefreshNewsEvent()),
                child: ArticleScreen(state.articles));
          }
          if (state is NewsErrorState) {
            return Center(
                child: Column(mainAxisSize: MainAxisSize.min, children: [
              Text(state.error.toString()),
              TextButton(
                  onPressed: () => BlocProvider.of<NewsBloc>(context)..add(LoadNewsEvent()), child: const Text('Try Again'))
            ]));
          }
          return const SizedBox();
        }),
      ),
    );
  }
}

class ArticleScreen extends StatelessWidget {
  final List<News> articles;
  const ArticleScreen(this.articles, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: articles.length,
      itemBuilder: ((context, index) => Container(
            margin: const EdgeInsets.only(bottom: 10),
            child: InkWell(
              onTap: () => Navigator.pushNamed(context, '/detailnewspage', arguments: articles[index]),
              child: Column(
                children: [
                  AspectRatio(
                    aspectRatio: 16 / 9,
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        CustomNetworkImage(articles[index].url_to_image.toString()),
                        articles[index].author != null
                            ? Align(
                                alignment: Alignment.bottomRight,
                                child: Container(
                                  color: Colors.white.withOpacity(0.7),
                                  child: Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Text(
                                      'Author \n${articles[index].author}',
                                      maxLines: 2,
                                    ),
                                  ),
                                ),
                              )
                            : const SizedBox(),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Column(
                      children: [
                        Text('${articles[index].title}',
                            style: Theme.of(context).textTheme.titleMedium, textAlign: TextAlign.justify),
                        const SizedBox(height: 5.0),
                        Text('${articles[index].description}',
                            style: Theme.of(context).textTheme.bodySmall,
                            maxLines: 3,
                            textAlign: TextAlign.justify,
                            overflow: TextOverflow.ellipsis),
                      ],
                    ),
                  ),
                  const Divider(color: Colors.grey, indent: 5, endIndent: 5, thickness: 0.8),
                ],
              ),
            ),
          )),
    );
  }
}

class CustomNetworkImage extends StatelessWidget {
  final String url;
  const CustomNetworkImage(this.url, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image(
      image: NetworkImage(url),
      fit: BoxFit.cover,
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) return child;
        return Container(color: Colors.grey[300], child: const Center(child: Text('Loading...')));
      },
      errorBuilder: (context, error, stackTrace) => Container(
        color: Colors.grey[300],
        child: const Center(
          child: Text('Could not load image..'),
        ),
      ),
    );
  }
}
