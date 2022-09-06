import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meditamos/src/presentation/screens/home/home_viewmodel.dart';
import 'package:meditamos/src/presentation/screens/home/library_page/library_page.dart';
import 'package:meditamos/src/presentation/screens/home/settings_page/settings_page.dart';
import 'package:meditamos/src/presentation/screens/home/welcome_page/welcome_page.dart';
import 'package:meditamos/src/presentation/utils/theme/meditamos_colors.dart';
import 'package:meditamos/src/presentation/widgets/carousel.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class HomeScreen extends ConsumerWidget {
  HomeScreen({Key? key}) : super(key: key);

  final pages = [
    const WelcomePage(),
    LibraryPage(),
    const SettingsPage(),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.width;

    // rebuild the widget when the todo list changes
    HomeState homeState = ref.watch(homeStateProvider);
    Widget selectedPage = homeState.page;
    int selectedIndex = homeState.selectedIndex;

    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
      ),
      body: selectedPage,
      bottomNavigationBar: BottomNavigationBar(
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(PhosphorIcons.houseSimple),
            label: "Principal",
          ),
          BottomNavigationBarItem(
            icon: Icon(PhosphorIcons.flowerLotus),
            label: "Librería",
          ),
          BottomNavigationBarItem(
            icon: Icon(PhosphorIcons.user),
            label: 'Perfil',
          ),
        ],
        showSelectedLabels: true,
        showUnselectedLabels: true,
        currentIndex: selectedIndex,
        onTap: (idx) => _onItemTap(idx, ref),
      ),
    );
  }

  void _onItemTap(int index, WidgetRef ref) {
    HomeViewModel homeViewModel = ref.read(homeStateProvider.notifier);
    homeViewModel.changePage(pages[index], index);
  }
}



//   body: ListView(
//     children: [
//       for (final f in families)
//         ListTile(
//           title: Text(f.name),
//           onTap: () => context.goNamed(AppRouter.courseDetailScreen, params: {'courseId': f.id}),
//         )
//     ],

