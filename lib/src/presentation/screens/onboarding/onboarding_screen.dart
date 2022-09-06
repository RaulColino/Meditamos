// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

//Onboarding Screen data
final List<OnboardingPageData> onboardingData = [
  OnboardingPageData(
    imagePath: "assets/images/plant1.svg",
    text: "Accede a cursos y meditaciones guiadas desde cualquier lugar",
    backgroundColor: const Color(0x00F3F3F3),
  ),
  OnboardingPageData(
    imagePath: "assets/images/plant1.svg",
    text: "Aprende y practica a traves de audios y videos",
    backgroundColor: const Color(0x00F3F3F3),
  ),
  OnboardingPageData(
    imagePath: "assets/images/plant1.svg",
    text: "Acceso ilimitado a todo el contenido. Sin coste alguno",
    backgroundColor: const Color(0x00F3F3F3),
  ),
];

//Data needed in each Page
class OnboardingPageData {
  late final String imagePath;
  late final String text;
  late final Color backgroundColor;

  OnboardingPageData(
      {required this.imagePath,
      required this.text,
      required this.backgroundColor});
}

//Onboarding screen
class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {
  late PageController _pageController;
  int _currentPage = 0;

  @override
  void initState() {
    _pageController = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            //Pages of PageView
            PageView.builder(
              itemCount: onboardingData.length,
              controller: _pageController,
              onPageChanged: (int page) {
                setState(() {
                  _currentPage = page;
                });
              },
              itemBuilder: (context, index) => OnboardingPage(
                imagePath: onboardingData[index].imagePath,
                text: onboardingData[index].text,
                backgroundColor: onboardingData[index].backgroundColor,
              ),
            ),
            //Page indicators row
            Positioned(
              bottom: 40,
              left: MediaQuery.of(context).size.width * .05,
              child: PageIndicatorsRow(
                pageController: _pageController,
                currentPage: _currentPage,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//Page of PageView
class OnboardingPage extends StatelessWidget {
  const OnboardingPage({
    Key? key,
    required this.imagePath,
    required this.text,
    required this.backgroundColor,
  }) : super(key: key);

  final String imagePath;
  final String text;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: backgroundColor),
      child: Center(
        child: Column(
          children: [
            const Spacer(),
            // for png,jpg,etc. images
            // Image.asset(
            //   imagePath,
            //   height: 250,
            // ),
            SvgPicture.asset(
              imagePath,
              height: 250,
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                text,
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall
                    ?.copyWith(fontWeight: FontWeight.w500),
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}

//PageIndicators row
class PageIndicatorsRow extends StatelessWidget {
  PageIndicatorsRow({
    Key? key,
    required this.pageController,
    required this.currentPage,
  }) : super(key: key);

  final PageController pageController;
  final int currentPage;

  final int lastPageIndex = onboardingData.length - 1;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          alignment: Alignment.center,
          width: MediaQuery.of(context).size.width * .9,
          child: Row(
            children: [
              Row(children: [
                for (int i = 0; i < onboardingData.length; i++)
                  i == currentPage
                      ? _buildPageIndicator(context, isCurrentPage: true)
                      : _buildPageIndicator(context, isCurrentPage: false)
              ]),
              const Spacer(),
              //if not last page
              (currentPage != lastPageIndex)
                  ? InkWell(
                      onTap: () {
                        pageController.animateToPage(
                          lastPageIndex,
                          duration: const Duration(milliseconds: 400),
                          curve: Curves.linear,
                        );
                      },
                      child: Container(
                        //height: Platform.isIOS ? 70 : 60,
                        alignment: Alignment.center,
                        child: const Text(
                          'Skip',
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 20),
                        ),
                      ),
                    )
                  :
                  //if last page
                  const InkWellFinalPage(),
            ],
          ),
        ),
      ],
    );
  }
}

//buildPageIndicator creates a page indicator with the form of a point
Widget _buildPageIndicator(
  BuildContext context, {
  required bool isCurrentPage,
}) {
  return AnimatedContainer(
    duration: const Duration(milliseconds: 350),
    margin: const EdgeInsets.symmetric(horizontal: 5.0),
    height: isCurrentPage ? 15.0 : 12.0,
    width: isCurrentPage ? 15.0 : 12.0,
    decoration: BoxDecoration(
      color: isCurrentPage
          ? Theme.of(context).textTheme.bodySmall?.color
          : Theme.of(context).textTheme.bodySmall?.color?.withOpacity(0.28),
      borderRadius: const BorderRadius.all(Radius.circular(12)),
    ),
  );
}

//InkwellFinalPage
class InkWellFinalPage extends ConsumerWidget {
  const InkWellFinalPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //final mainViewModel = useProvider(initialViewModelProvider.notifier);
    return InkWell(
      //onTap: () => mainViewModel.finishNewUserState(),
      onTap: () => {},
      child: Container(
        //height: ? 70 : 60,
        alignment: Alignment.center,
        child: const Text(
          'Start',
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
        ),
      ),
    );
  }
}
