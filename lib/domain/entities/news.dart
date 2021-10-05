import 'dart:convert';

import 'package:meditamos/domain/entities/course_component.dart';

class News {
  final String newsId;
  final String title;
  final String color;
  final String coverImageUrl;
  final String description;

  News({
    required this.newsId,
    required this.title,
    required this.color,
    required this.coverImageUrl,
    required this.description,
  });

  //JSON enconding
  Map<String, dynamic> toMap() {
    return {
      'newsId': newsId,
      'title': title,
      'color': color,
      'coverImageUrl': coverImageUrl,
      'description': description,
    };
  }
  String toJson() => json.encode(toMap());

  //JSON decoding
  factory News.fromMap(Map<String, dynamic> myMap) {
    print("News.fromMap::::::: $myMap");
    return News(
      newsId: myMap['newsId'],
      title: myMap['title'],
      color: myMap['color'],
      coverImageUrl: myMap['coverImageUrl'],
      description: myMap['description'], 
    );
  }

  factory News.fromJson(String source) => News.fromMap(json.decode(source));
}
