// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: implicit_dynamic_parameter

part of 'news.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

News _$NewsFromJson(Map<String, dynamic> json) => $checkedCreate(
      'News',
      json,
      ($checkedConvert) {
        final val = News(
          author: $checkedConvert('author', (v) => v as String?),
          title: $checkedConvert('title', (v) => v as String?),
          description: $checkedConvert('description', (v) => v as String?),
          url: $checkedConvert('url', (v) => v as String?),
          url_to_image: $checkedConvert('url_to_image', (v) => v as String?),
          published_at: $checkedConvert('published_at', (v) => v as String?),
          content: $checkedConvert('content', (v) => v as String?),
        );
        return val;
      },
    );
