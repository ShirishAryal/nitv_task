import 'package:flutter/material.dart';

import '../models/article_model.dart';
import '../services/api_services.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Article>? articles;

  @override
  void initState() {
    super.initState();
    fetcharticles();
  }

  Future<void> fetcharticles() async {
    await ApiServices().fetchNews().then((value) {
      if (!mounted) return;
      setState(() {
        articles = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('home page'),
      ),
    );
  }
}
