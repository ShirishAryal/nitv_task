import 'package:flutter/material.dart';
import 'package:nitv_task/src/news/view/news_page.dart';
import 'package:nitv_task_repository/nitv_task_repository.dart';

import '../news/view/detail_news_page.dart';

class NitvTaskRouter {
  Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const NewsPage());
      case '/detailnewspage':
        final News article = settings.arguments as News;
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
