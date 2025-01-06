import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_company_app_new_2025/features/change_nav_bar/presentation/cubit/change_nav_bar_state.dart';
import 'package:task_company_app_new_2025/features/discover/presentation/screens/favorites_screen.dart';
import 'package:task_company_app_new_2025/features/discover/presentation/screens/main_screen.dart';
import 'package:task_company_app_new_2025/features/discover/presentation/screens/top_rating_screen.dart';

class ChangeNavBarCubit extends Cubit<ChangeNavBarState> {
  int currentScreen = 0;
  List<Widget> screens = [
    DiscoverScreen(),
    FavoritesScreen(),
    TopRatingScreen(),
  ];

  ChangeNavBarCubit() : super(ChangeNavBarInitial());

  // Change Button Nav Bar:
  void changeNavBar(int index) {
    currentScreen = index;
    emit(ChangeNavBarUpdated(currentScreen));
  }
}
