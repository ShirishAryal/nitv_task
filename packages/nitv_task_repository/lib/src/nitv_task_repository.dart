import 'package:nitv_task_api/nitv_task_api.dart';

import 'models/models.dart';

class NewsRepository {
  final NewsApiClient _newsApiClient;

  NewsRepository({NewsApiClient? newsApiClient}) : _newsApiClient = newsApiClient ?? NewsApiClient();

  static const _content =
      "Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupi datat non proident,sunt in culpa qui officia deserunt mollit anim id est laborum.";

  Future<List<News>> getNews() async {
    final articles = await _newsApiClient.getArticles();

    List<News> news = [];

    for (var element in articles) {
      final content = element.content != null ? {"${element.content!}\n$_content"} : _content;

      news.add(
        News(
          author: element.author,
          title: element.title,
          description: element.description,
          url: element.url,
          url_to_image: element.urlToImage,
          published_at: element.publishedAt,
          content: content.toString(),
        ),
      );
    }
    return news;
  }
}
