import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import '../models/article_model.dart';
import 'package:http/http.dart' as http;

class ApiServices {
  static const _url =
      "https://newsapi.org/v2/everything?q=apple&from=2022-12-14&to=2022-12-14&sortBy=popularity&apiKey=a2059254c7b94144adb9c27f4a2a5b32";
  List<Article> _articles = [];
  fetchNews() async {
    try {
      final _response = await http.get(Uri.parse(_url));
      if (_response.statusCode == 200) {
        final _data = jsonDecode(_response.body);
        _articles = await _data['articles']!
            .map<Article>((e) => Article.fromJson(e))
            .toList();
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
