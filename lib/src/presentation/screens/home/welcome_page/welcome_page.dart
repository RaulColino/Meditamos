import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meditamos/src/presentation/screens/home/home_viewmodel.dart';
import 'package:meditamos/src/presentation/screens/home/library_page/library_page.dart';
import 'package:meditamos/src/presentation/utils/theme/meditamos_colors.dart';
import 'package:meditamos/src/presentation/widgets/carousel.dart';

const List<String> images = [
  "https://images.wallpapersden.com/image/download/purple-sunrise-4k-vaporwave_bGplZmiUmZqaraWkpJRmbmdlrWZlbWU.jpg",
  "https://wallpaperaccess.com/full/2637581.jpg",
  "https://uhdwallpapers.org/uploads/converted/20/01/14/the-mandalorian-5k-1920x1080_477555-mm-90.jpg"
];

class WelcomePage extends ConsumerWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.only(
        left: width * 0.05,
        right: width * 0.05,
      ),
      child: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          Text(
            "¡Bienvenido!",
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const Padding(
            padding: EdgeInsets.only(top: 30),
            child: NewsSection(),
          ),
          const Padding(
            padding: EdgeInsets.only(top: 30),
            child: MeditationsSection(),
          )
        ],
      ),
    );
  }
}

class NewsSection extends StatelessWidget {
  const NewsSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 20.5),
          child: Row(
            children: [
              Text(
                "Noticias",
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ],
          ),
        ),
        Row(
          children: [
            Carousel(images: images),
          ],
        ),
      ],
    );
  }
}

class MeditationsSection extends ConsumerWidget {
  const MeditationsSection({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    HomeViewModel homeViewModel = ref.read(homeStateProvider.notifier);

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 20.5),
          child: Row(
            children: [
              Text(
                "Elige tu meditación",
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ContentTypeCard(
              onTapCallback: () {
                homeViewModel.changePage(
                  //buggy dont do this because you can go to another page not defined in HomeScreen pages property
                  LibraryPage(startWithLeftToggleOption: true), 
                  1,
                );
              },
              text: "Meditaciones guiadas",
            ),
            ContentTypeCard(
              onTapCallback: () {
                homeViewModel.changePage(
                  //HomeScreen.pages[1].withStartLeftOption(false),

                  //buggy dont do this because you can go to another page not defined in HomeScreen pages property
                  LibraryPage(startWithLeftToggleOption: false),
                  1,
                );
              },
              text: "Música",
            )
          ],
        ),
      ],
    );
  }
}

class ContentTypeCard extends StatelessWidget {
  const ContentTypeCard(
      {Key? key, required this.onTapCallback, required this.text})
      : super(key: key);

  final Function()? onTapCallback;
  final String text;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTapCallback,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.45 * 0.95,
        height: MediaQuery.of(context).size.width * 0.45,
        decoration: BoxDecoration(
          color: MeditamosColors.gray,
          borderRadius: BorderRadius.circular(18),
        ),
        child: Center(
          child: Text(
            text,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
