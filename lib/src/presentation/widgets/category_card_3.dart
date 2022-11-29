import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:meditamos/src/presentation/utils/theme/meditamos_colors.dart';

class CategoryCard3 extends StatelessWidget {
  CategoryCard3({
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
    Color gradientColor = Colors.black;
    return GestureDetector(
      onTap: onClickAction,
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(width * 0.023),
            child: Container(
              color: Theme.of(context).colorScheme.onInverseSurface,
              child: Stack(
                //fit: StackFit.expand,
                //clipBehavior: Clip.hardEdge,
                children: [         
                  FadeInImage.assetNetwork(
                    placeholder: "assets/images/transparent.png",
                    image: imageUrl,
                    fadeInDuration: Duration(milliseconds: 500),
                    fadeOutDuration: Duration(milliseconds: 500),
                    placeholderErrorBuilder: (context, error, stackTrace) => const Text("Failed to load image"),
                    fit: BoxFit.cover,
                    height: height,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        //first option
                        // gradientColor.withOpacity(0.3),
                        // gradientColor.withOpacity(0.2),
                        // gradientColor.withOpacity(0.1),
                        // gradientColor.withOpacity(0.0),
                        // gradientColor.withOpacity(0.0),

                        //second option
                        gradientColor.withOpacity(0.55),
                        gradientColor.withOpacity(0.33),
                        gradientColor.withOpacity(0.19),
                        gradientColor.withOpacity(0.09),
                        gradientColor.withOpacity(0.02),
                        gradientColor.withOpacity(0.0),
                        gradientColor.withOpacity(0.0),
                      ],
                    )),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 20, left: 18),
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
          ),
        ],
      ),
    );
  }
}
