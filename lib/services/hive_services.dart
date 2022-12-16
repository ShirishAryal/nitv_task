import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:nitv_task/shared/widgets/widgets.dart';

import '../models/article_model.dart';

class HiveService {
  late final Box _openBox;

  ///add data to the hive box
  addBoxes<Article>(String boxname, List<Article> items) async {
    _openBox = Hive.box<Article>(boxname);
    log("adding boxes");
    await _openBox.clear();
    for (var item in items) {
      _openBox.add(item);
      log('$_openBox.values');
    }
  }

  Future<List<Article>> get getSavedData => _fetchHiveData('article_box');

  ///retrieve data from hive if box exists
  Future<List<Article>> _fetchHiveData(String boxname) async {
    _openBox = Hive.box<Article>(boxname);
    bool exists = await _isExists();
    log('exists: $exists');
    List<Article> articles;
    if (exists) {
      debugPrint("Getting data from Hive");
      articles = await _getBoxes();
      ToastMessage.info('Data from hive database');
      return articles;
    } else {
      log('return empty');
      return [];
    }
  }

  _isExists() async {
    int length = _openBox.length;
    log('${_openBox.length}');
    return length != 0;
  }

  Future<List<Article>> _getBoxes<Article>() async {
    List<Article> boxList = <Article>[];
    for (int i = 0; i < _openBox.length; i++) {
      Article article = _openBox.getAt(i) as Article;
      log('$article');
      boxList.add(article);
    }
    return boxList;
  }
}
