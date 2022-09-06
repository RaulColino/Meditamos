// ignore_for_file: public_member_api_docs, sort_constructors_first
//Not used yet
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:meditamos/src/presentation/utils/routing/app_router.dart';

import 'package:meditamos/src/presentation/utils/theme/meditamos_colors.dart';
import 'package:meditamos/src/presentation/widgets/category_card.dart';
import 'package:meditamos/src/presentation/widgets/toggle_standard.dart';

Map<String, String> meditation_list = {
  "meditation1":
      "https://images.wallpapersden.com/image/download/purple-sunrise-4k-vaporwave_bGplZmiUmZqaraWkpJRmbmdlrWZlbWU.jpg",
  "meditation2": "https://wallpaperaccess.com/full/2637581.jpg",
  "meditation3":
      "https://uhdwallpapers.org/uploads/converted/20/01/14/the-mandalorian-5k-1920x1080_477555-mm-90.jpg",
  "meditation4": "https://wallpaperaccess.com/full/2637581.jpg",
  "meditation5":
      "https://images.wallpapersden.com/image/download/purple-sunrise-4k-vaporwave_bGplZmiUmZqaraWkpJRmbmdlrWZlbWU.jpg",
  "meditation6": "https://wallpaperaccess.com/full/2637581.jpg",
  "meditation7":
      "https://uhdwallpapers.org/uploads/converted/20/01/14/the-mandalorian-5k-1920x1080_477555-mm-90.jpg",
  "meditation8": "https://wallpaperaccess.com/full/2637581.jpg",
};

Map<String, String> music_list = {
  "music1": "https://wallpaperaccess.com/full/7648548.jpg",
  "music2": "https://wallpaperaccess.com/full/7803033.jpg",
  "music3":
      "https://uhdwallpapers.org/uploads/converted/20/01/14/the-mandalorian-5k-1920x1080_477555-mm-90.jpg",
  "music4": "https://wallpaperaccess.com/full/7803033.jpg",
  "music5": "https://wallpaperaccess.com/full/7648548.jpg",
  "music6": "https://wallpaperaccess.com/full/7803033.jpg",
  "music7":
      "https://uhdwallpapers.org/uploads/converted/20/01/14/the-mandalorian-5k-1920x1080_477555-mm-90.jpg",
  "music8": "https://wallpaperaccess.com/full/7803033.jpg",
};

class LibraryPage extends ConsumerStatefulWidget {
  LibraryPage({Key? key, bool startWithLeftToggleOption = true})
      : super(key: key) {
    // We must do this to avoid a LateInitializationError
    this.startWithLeftToggleOption = startWithLeftToggleOption;
  }

  late final bool startWithLeftToggleOption;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      // ignore: no_logic_in_create_state
      _LibraryPageState(isLeft: startWithLeftToggleOption);
}

class _LibraryPageState extends ConsumerState<LibraryPage> {
  late bool isLeft;

  _LibraryPageState({
    required this.isLeft,
  });

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: width * 0.05),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          //Title
          Row(
            children: [
              Text(
                "Librería",
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ],
          ),
          SizedBox(height: 15),
          //Subtitle
          Row(
            children: [
              Text(
                "Categorías",
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ],
          ),
          SizedBox(height: 15),
          //Toggle
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ToggleStandard(
                leftValue: "Meditaciones guiadas",
                rightValue: "Música",
                onToggleCallback: (value) async {
                  setState(() {
                    isLeft = !isLeft;
                  });
                },
                isLeft: isLeft,
              ),
            ],
          ),
          SizedBox(height: 15),
          //Grid
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: height * 0.6,
                width: width * 0.85,
                child: buildCategoriesGridView(context, isLeft),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildCategoriesGridView(BuildContext context, bool isLeft) {
    Map<String, String> data = isLeft ? meditation_list : music_list;

    return GridView.count(
      physics: BouncingScrollPhysics(),
      primary: false,
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      crossAxisCount: 2,
      children: <Widget>[
        ...data.entries
            .map(
              (e) => CategoryCard(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                imageUrl: e.value,
                title: e.key,
                onClickAction: () => context.pushNamed(AppRoutes.meditationScreen.name),
              ),
            )
            .toList(),
      ],
    );
  }
}
