// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:meditamos/src/presentation/widgets/category_card.dart';

//How to implement correctly a StaggeredGridView: https://www.youtube.com/watch?v=m-Tgvzsm26I
//This widget shows CategoryCard in two staggered columns. It needs a List<String> data wich is a list of image urls for each CategoryCard.
class StaggeredGridView extends StatelessWidget {
  const StaggeredGridView({
    Key? key,
    required this.imageUrlList,
    required this.titleList,
  }) : super(key: key);

  final List<String> imageUrlList;
  final List<String> titleList;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              "Categories",
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        SizedBox(height: 30),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(flex: 1, child: getStaggeredColumn(context)),
            const SizedBox(width: 30),
            Expanded(
              flex: 1,
              child: Column(
                children: [
                  SizedBox(height: 30),
                  getStaggeredColumn(context),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget getStaggeredColumn(BuildContext context) {
    return Column(
      children: [
        ...List.generate(
          imageUrlList.length,
          (index) => GestureDetector(
            onTap: () {
              //todo
            },
            child: CategoryCard(
              width: 30,
              height: 30,
              imageUrl: imageUrlList[index],
              title: titleList[index],
              onClickAction: ()=>{},
            ),
          ),
        ),
      ],
    );
  }
}
