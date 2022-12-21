import 'package:json_annotation/json_annotation.dart';
part 'news.g.dart';

@JsonSerializable()
class News {
  String? author;
  String? title;
  String? description;
  String? url;
  String? url_to_image;
  String? published_at;
  String? content;

  News(
      {this.author,
      this.title,
      this.description,
      this.url,
      this.url_to_image,
      this.published_at,
      this.content,
      String? urlToImage});
  factory News.fromJson(Map<String, dynamic> json) => _$NewsFromJson(json);
}
