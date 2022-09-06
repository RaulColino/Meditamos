import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meditamos/src/presentation/screens/home/welcome_page/welcome_page.dart';

final homeStateProvider = StateNotifierProvider<HomeViewModel, HomeState>((ref) => HomeViewModel());

class HomeViewModel extends StateNotifier<HomeState> {
  HomeViewModel() : super(HomeState(WelcomePage(), 0));

  void changePage(Widget page, int selectedIndex) {
    state = HomeState(page, selectedIndex);
  }
}

class HomeState {
  Widget page;
  int selectedIndex;
  //Contructor
  HomeState(
    this.page,
    this.selectedIndex,
  );
}
