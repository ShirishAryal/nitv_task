import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:hive_cache_api/hive_cache_api.dart';
import 'package:http/http.dart';

import 'models/model.dart';

/// Exception thrown when locationSearch fails.
class NewsRequestFailure implements Exception {
  NewsRequestFailure(String errorMessage) {
    throw errorMessage;
  }
}

/// Exception thrown when news is not found.
class NewsNotFoundFailure implements Exception {
  NewsNotFoundFailure(String errorMessage) {
    throw errorMessage;
  }
}

class NitvTaskApiClient {
  final HiveCacheApi _hiveCacheApi = HiveCacheApi();
  static const _endpoint =
      "https://newsapi.org/v2/top-headlines?country=us&category=science&apiKey=a2059254c7b94144adb9c27f4a2a5b32";

  Future<List<Article>> getArticles() async {
    try {
      final newsResponse = await get(Uri.parse(_endpoint));

      if (newsResponse.statusCode != 200) throw NewsRequestFailure(newsResponse.reasonPhrase.toString());

      final newsJson = jsonDecode(newsResponse.body) as Map;

      if (!newsJson.containsKey('articles')) throw NewsNotFoundFailure('Key not found in json');

      final results = newsJson['articles'] as List;

      if (results.isEmpty) throw NewsNotFoundFailure('No Data Found');

      _hiveCacheApi.cacheJson(keyValue: 'articles', encodedJson: jsonEncode(results));

      List<Article> articles = results.map<Article>((e) => Article.fromJson(e)).toList();

      return articles;
    } on SocketException {
      var data = _hiveCacheApi.retrieveJson(keyValue: 'articles');
      if (data != null) {
        List<Article> articles = jsonDecode(data).map<Article>((e) => Article.fromJson(e)).toList();
        return articles;
      } else {
        throw 'Check Your Internet Connection';
      }
    } on Error catch (e) {
      log(e.toString());
      throw 'Something went wrong';
    }
  }
}
