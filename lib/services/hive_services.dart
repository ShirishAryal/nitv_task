import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../models/article_model.dart';

class HiveService {
  late final Box openBox;

  ///add data to the hive box
  addBoxes<Article>(String boxname, List<Article> items) async {
    openBox = Hive.box<Article>(boxname);
    log("adding boxes");
    await openBox.clear();
    for (var item in items) {
      openBox.add(item);
      log('$openBox.values');
    }
  }
}
