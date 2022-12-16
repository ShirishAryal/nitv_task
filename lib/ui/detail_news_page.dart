import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/article_model.dart';
import '../shared/widgets/widgets.dart';

class DetailNewsPage extends StatelessWidget {
  final Article article;
  const DetailNewsPage(this.article, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Text('${article.title}',
                      style: Theme.of(context).textTheme.titleLarge,
                      textAlign: TextAlign.justify),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                          DateFormat("MMM, d, y").format(
                              DateTime.parse(article.publishedAt.toString())),
                          style: Theme.of(context).textTheme.bodySmall),
                      ConstrainedBox(
                        constraints: BoxConstraints(
                            maxWidth: MediaQuery.of(context).size.width / 2),
                        child: Text('-By ${article.author}',
                            style: Theme.of(context).textTheme.bodySmall,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis),
                      ),
                    ],
                  )
                ],
              ),
            ),
            AspectRatio(
                aspectRatio: 16 / 9,
                child: CustomNetworkImage(article.urlToImage.toString())),
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('${article.content}',
                    style: Theme.of(context).textTheme.bodyMedium,
                    textAlign: TextAlign.justify))
          ],
        ),
      )),
    );
  }
}
