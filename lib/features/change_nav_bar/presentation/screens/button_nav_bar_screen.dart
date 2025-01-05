import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_company_app_new_2025/features/change_nav_bar/presentation/cubit/change_nav_bar_cubit.dart';
import 'package:task_company_app_new_2025/features/change_nav_bar/presentation/cubit/change_nav_bar_state.dart';

class ButtonNavBarScreen extends StatelessWidget {
  const ButtonNavBarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChangeNavBarCubit, ChangeNavBarState>(
      builder: (context, state) {
        final cubit = context.read<ChangeNavBarCubit>();
        return Scaffold(
          body: cubit.screens[
              cubit.currentScreen], // Display the screen based on current index
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.currentScreen,
            onTap: (index) {
              cubit.changeNavBar(index); // Change the screen when tapped
            },
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.tv),
                label: 'Discover',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.favorite),
                label: 'Favorites',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.star),
                label: 'Top Rated',
              ),
            ],
          ),
        );
      },
    );
  }
}
