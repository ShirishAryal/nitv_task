import 'dart:developer';
import 'package:hive/hive.dart';

class HiveCacheApi {
  final Box<String> _hiveBox = Hive.box('news');

  void cacheJson({required String keyValue, required String encodedJson}) {
    _hiveBox.put(keyValue, encodedJson);
    log('$keyValue added to cache');
  }

  String? retrieveJson({required String keyValue}) {
    if (!_hiveBox.containsKey(keyValue)) throw '$keyValue not found';
    return _hiveBox.get(keyValue);
  }
}
