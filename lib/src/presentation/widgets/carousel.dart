import 'package:flutter/material.dart';
import 'package:meditamos/src/presentation/utils/theme/meditamos_colors.dart';

final List<String> defaultImages = [
  "https://images.wallpapersden.com/image/download/purple-sunrise-4k-vaporwave_bGplZmiUmZqaraWkpJRmbmdlrWZlbWU.jpg",
  "https://wallpaperaccess.com/full/2637581.jpg",
  "https://uhdwallpapers.org/uploads/converted/20/01/14/the-mandalorian-5k-1920x1080_477555-mm-90.jpg"
];

class Carousel extends StatefulWidget {
  Carousel({
    Key? key,
    List<String>? images,
  }) : super(key: key);

  List<String> images = defaultImages;

  @override
  State<Carousel> createState() => _CarouselState(images);
}

class _CarouselState extends State<Carousel> {
  late PageController _pageController;

  _CarouselState(this.images);

  List<String> images;
  int activePage = 1;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 1);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.9,
          height: MediaQuery.of(context).size.width * 0.4,
          child: PageView.builder(
              physics: BouncingScrollPhysics(),
              itemCount: images.length,
              pageSnapping: true,
              controller: _pageController,
              onPageChanged: (int page) {
                setState(() {
                  activePage = page;
                });
              },
              itemBuilder: (context, pagePosition) {
                bool active = pagePosition == activePage;
                return getNewsCard(images, pagePosition, active);
              }),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: indicators(context, images.length, activePage),
        )
      ],
    );
  }
}

AnimatedContainer getNewsCard(images, pagePosition, active) {
  double margin = active ? 10 : 20;

  return AnimatedContainer(
    width: double.infinity,
    duration: const Duration(milliseconds: 500),
    curve: Curves.easeInOutCubic,
    margin: EdgeInsets.all(margin),
    decoration: BoxDecoration(
      color: MeditamosColors.gray,
      borderRadius: BorderRadius.circular(18),
      image: DecorationImage(
          image: NetworkImage(images[pagePosition]), fit: BoxFit.fill),
    ),
  );
}

imageAnimation(PageController animation, images, pagePosition) {
  return AnimatedBuilder(
    animation: animation,
    builder: (context, widget) {
      print(pagePosition);

      return SizedBox(
        width: 200,
        height: 200,
        child: widget,
      );
    },
    child: Container(
      margin: EdgeInsets.all(10),
      child: Image.network(images[pagePosition]),
    ),
  );
}

List<Widget> indicators(
    BuildContext context, int imagesLength, int currentIndex) {
  return List<Widget>.generate(imagesLength, (index) {
    return Container(
      margin: EdgeInsets.all(3),
      width: 10,
      height: 10,
      decoration: BoxDecoration(
          color: currentIndex == index
              ? Theme.of(context).colorScheme.onSurface
              : Theme.of(context).colorScheme.onSurface.withOpacity(0.3),
          shape: BoxShape.circle),
    );
  });
}
