import 'dart:convert';

//course component interface
abstract class CourseComponent {
  final String type;

  CourseComponent(this.type);

  Map<String, dynamic> toMap();
  String toJson();
  CourseComponent fromJson(String source);

}


//audio
class CourseAudioComponent implements CourseComponent {
  @override
  String type;
  final String name;
  final String imageUrl;
  final String audioUrl;

  CourseAudioComponent({
    required this.type,
    required this.name,
    required this.imageUrl,
    required this.audioUrl,
  });

  //json serialization
  @override
  Map<String, dynamic> toMap() {
    return {
      '_type': type,
      'name': name,
      'imageUrl': imageUrl,
      'audioUrl': audioUrl,
    };
  }
  factory CourseAudioComponent.fromMap(Map<String, dynamic> map) {
    return CourseAudioComponent(
      type: map['_type'],
      name: map['name'],
      imageUrl: map['imageUrl'],
      audioUrl: map['audioUrl'],
    );
  }
  @override
  String toJson() => json.encode(toMap());
  @override
  CourseComponent fromJson(String source) => CourseAudioComponent.fromMap(json.decode(source));
}


//video
class CourseVideoComponent implements CourseComponent {
  @override
  String type;
  final String title;
  final String videoId;

  CourseVideoComponent({
    required this.type,
    required this.title,
    required this.videoId,
  });


  //json serialization
  @override
  Map<String, dynamic> toMap() {
    return {
      '_type': type,
      'title': title,
      'videoId': videoId,
    };
  }
  factory CourseVideoComponent.fromMap(Map<String, dynamic> map) {
    return CourseVideoComponent(
      type: map['_type'],
      title: map['title'],
      videoId: map['videoId'],
    );
  }
  @override
  String toJson() => json.encode(toMap());
  @override
  CourseComponent fromJson(String source) => CourseVideoComponent.fromMap(json.decode(source));

}
