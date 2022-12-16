import 'package:flutter/material.dart';

import '../models/article_model.dart';
import '../services/api_services.dart';
import '../shared/widgets/widgets.dart';

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
      appBar: AppBar(
        title: const Text('Nitv Task'),
      ),
      body: RefreshIndicator(
          onRefresh: () async {
            await fetcharticles();
          },
          child: SafeArea(
              child: Center(
                  child: articles == null
                      ? const Center(child: CircularProgressIndicator())
                      : articles!.isEmpty
                          ? Center(
                              child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                  const Text('Opps no news available!!'),
                                  TextButton(
                                      onPressed: () => fetcharticles(),
                                      child: const Text('Try Again'))
                                ]))
                          : ArticleScreen(articles!)))),
    );
  }
}

class ArticleScreen extends StatelessWidget {
  final List<Article> articles;
  const ArticleScreen(this.articles, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: articles.length,
      itemBuilder: ((context, index) => Container(
            margin: const EdgeInsets.only(bottom: 10),
            child: InkWell(
              onTap: () => Navigator.pushNamed(context, '/detailnewspage',
                  arguments: articles[index]),
              child: Column(
                children: [
                  AspectRatio(
                    aspectRatio: 16 / 9,
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        CustomNetworkImage(
                            articles[index].urlToImage.toString()),
                        articles[index].author != null
                            ? Align(
                                alignment: Alignment.bottomRight,
                                child: Container(
                                  color: Colors.white.withOpacity(0.7),
                                  child: Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Text(
                                      'Author \n${articles[index].author}',
                                      maxLines: 2,
                                    ),
                                  ),
                                ),
                              )
                            : const SizedBox(),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Column(
                      children: [
                        Text('${articles[index].title}',
                            style: Theme.of(context).textTheme.titleMedium,
                            textAlign: TextAlign.justify),
                        const SizedBox(height: 5.0),
                        Text('${articles[index].description}',
                            style: Theme.of(context).textTheme.bodySmall,
                            maxLines: 3,
                            textAlign: TextAlign.justify,
                            overflow: TextOverflow.ellipsis),
                      ],
                    ),
                  ),
                  const Divider(
                      color: Colors.grey,
                      indent: 5,
                      endIndent: 5,
                      thickness: 0.8),
                ],
              ),
            ),
          )),
    );
  }
}
