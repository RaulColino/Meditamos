import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:meditamos/src/presentation/utils/theme/meditamos_colors.dart';

class CategoryCard extends StatelessWidget {
  CategoryCard({
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
            borderRadius: BorderRadius.circular(width*0.023),
            child: Container(
              height: height,
              width: width,
              color: MeditamosColors.gray,
              child: Image.network(
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
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20, left: 18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "title",
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: MeditamosColors.white,
                    shadows: [
                      BoxShadow(
                        offset: Offset(0, 1),
                        blurRadius: 19,
                        color: Theme.of(context).shadowColor.withOpacity(0.8),
                      ),
                    ],
                  ),
                ),
                // SizedBox(height: 8),
                // Text(
                //   "12 courses",
                //   overflow: TextOverflow.ellipsis,
                //   style: TextStyle(
                //     fontSize: 15,
                //     color: MeditamosColors.white.withOpacity(0.8),
                //   ),
                // )
              ],
            ),
          )
        ],
      ),
    );
  }
}
