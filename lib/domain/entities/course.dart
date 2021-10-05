import 'dart:convert';

import 'package:meditamos/domain/entities/course_component.dart';

class Course {
  final String courseId;
  final String title;
  final String coverImageUrl;
  final List<CourseComponent> contents;

  Course({required this.courseId, required this.title, required this.coverImageUrl, required this.contents});

  //JSON enconding
  Map<String, dynamic> toMap() {
    return {
      'courseId': courseId,
      'title': title,
      'coverImageUrl': coverImageUrl,
      'contents': contents.map((component) => component.toMap()).toList(),
    };
/*  return {
      'courseId': courseId,
      'title': title,
      'coverImageUrl': coverImageUrl,
      'contents': [
        {
            "_type": "audio",
            "name": "audiotrack 1" ,
            "imageUrl": "audio1",
        },
        {
             "_type": "audio",
            "name": "audiotrack 2" ,
            "imageUrl": "audio2",
        },
      ],
    }; */
  }
  String toJson() => json.encode(toMap());

  //JSON decoding
  factory Course.fromMap(Map<String, dynamic> myMap) {
    print("Course.fromMap::::::: $myMap");
    return Course(
      courseId: myMap['courseId'],
      title: myMap['title'],
      coverImageUrl: myMap['coverImageUrl'],
      contents: getContentsFromMap(myMap['contents']), 
    );
  }

  static List<CourseComponent>getContentsFromMap(List<dynamic> contents){

    List<CourseComponent> componentList = [];
    try{
      componentList = List<CourseComponent>.from(contents.map((e) {
        print("Course.getContentsFromMap: contents mapped component:  $e");
        if (e["_type"]=="audio")
          return CourseAudioComponent.fromMap(e); //print (CourseAudioComponent.fromMap(e).audioUrl);
        else
          return CourseVideoComponent.fromMap(e);  //print(CourseVideoComponent.fromMap(e).videoId);
      }).toList());
    } catch (e) {
      print("Course: PARSING error: $e");
    }
    print("Course.getContentsFromMap::: Created component list: $componentList");
    return componentList;
  }

  factory Course.fromJson(String source) => Course.fromMap(json.decode(source));
}


/* DECODE JSON AND GET AS LIST<OBJECT>
Future readJsonnFile() async {
    String myString = await DefaultAssetBundle.of(context)
        .loadString('assets/pizzalist.json');
List myMap = jsonDecode(myString);

List<Pizza> myPizzas = [];
myMap.forEach((dynamic pizza) {
  Pizza myPizza = Pizza.fromJson(pizza);
  myPizzas.add(myPizza);
});
 */