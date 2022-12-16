import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;

import '../models/article_model.dart';
import '../shared/widgets/widgets.dart';
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
        ToastMessage.success('success');
        return _articles;
      }
    } on SocketException catch (e) {
      ToastMessage.error('No internet connection!!');
      _articles = await HiveService().getSavedData;
      log('$e');
      return _articles;
    } on Error catch (e) {
      ToastMessage.error('$e');
      _articles = await HiveService().getSavedData;
      log('$e');
      return _articles;
    }
  }
}
