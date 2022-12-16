import 'package:flutter/material.dart';

import '../models/article_model.dart';
import '../ui/detail_news_page.dart';
import '../ui/home_page.dart';

class NewsAppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const HomePage());
      case '/detailnewspage':
        final Article article = settings.arguments as Article;
        return MaterialPageRoute(builder: (_) => DetailNewsPage(article));
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }
}
