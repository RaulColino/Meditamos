import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:meditamos/src/presentation/utils/theme/meditamos_colors.dart';

class CategoryCard1 extends StatelessWidget {
  CategoryCard1({
    Key? key,
    required this.width,
    required this.height,
    required this.imageUrl,
    required this.title,
    required this.onClickAction,
  }) : super(key: key);

  double width;
  double height;
  String imageUrl;
  String title;
  void Function() onClickAction;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClickAction,
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(width * 0.023),
            child: Container(
              height: height,
              width: width,
              color: MeditamosColors.gray,
              child: Stack(
                children: [
                  Image.network(
                    imageUrl,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) {
                        return child;
                      }
                      return Center(
                        child: CircularProgressIndicator(
                          color: MeditamosColors.grayDarker,
                        ),
                      );
                    },
                    fit: BoxFit.cover,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20, left: 18),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          //padding: EdgeInsets.symmetric(horizontal: 10),
                          //height: 25.0,
                          decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.circular(95),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.12397),
                                offset: const Offset(0.0, 0.0),
                                blurRadius: 80.0,
                                spreadRadius: 90.0,
                              ),
                            ],
                          ),
                          child: Text(
                            "title",
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: MeditamosColors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
