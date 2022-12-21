import 'package:flutter/material.dart';
import 'package:nitv_task_repository/nitv_task_repository.dart';

import 'src/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Hive.initFlutter();
  // Hive.registerAdapter<Article>(ArticleAdapter());
  // await Hive.openBox<Article>('article_box');
  // runApp(const App());
  runApp(NewsApp(nitvTaskRepository: NitvTaskRepository()));
}
