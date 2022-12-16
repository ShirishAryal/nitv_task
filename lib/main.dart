import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'models/article_model.dart';
import 'router/router.dart';
import 'ui/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter<Article>(ArticleAdapter());
  await Hive.openBox<Article>('article_box');
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter News App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.purple,
        scaffoldBackgroundColor: const Color(0xFFf2f0f0),
        textTheme: const TextTheme(
          titleLarge: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              height: 1.1,
              color: Colors.black),
          titleMedium: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              height: 1.1,
              color: Colors.black),
          bodyMedium: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w500,
              color: Colors.black,
              height: 1.3),
          bodySmall: TextStyle(
              fontSize: 12, fontWeight: FontWeight.w500, color: Colors.black),
        ),
      ),
      onGenerateRoute: NewsAppRouter.generateRoute,
      home: const HomePage(),
    );
  }
}
