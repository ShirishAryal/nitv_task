import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import '../models/article_model.dart';
import 'package:http/http.dart' as http;

import 'hive_services.dart';

class ApiServices {
  static const _url =
      "https://newsapi.org/v2/everything?q=apple&from=2022-12-14&to=2022-12-14&sortBy=popularity&apiKey=a2059254c7b94144adb9c27f4a2a5b32";
  List<Article> _articles = [];
  fetchNews() async {
    try {
      final response = await http.get(Uri.parse(_url));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        _articles = await data['articles']!
            .map<Article>((e) => Article.fromJson(e))
            .toList();
        await HiveService().addBoxes('article_box', _articles);

        log('$_articles');
        return _articles;
      }
    } on SocketException catch (e) {
      log('$e');
      return _articles;
    } on Error catch (e) {
      log('$e');
      return _articles;
    }
  }
}
