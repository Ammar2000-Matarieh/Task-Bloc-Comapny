import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_company_app_new_2025/features/tv_views/presentation/screens/view_screen.dart';
import 'package:task_company_app_new_2025/features/discover/presentation/screens/view_tv_screen.dart';
import 'package:task_company_app_new_2025/features/discover/presentation/widgets/custom_bottom_appbar.dart';
import 'package:task_company_app_new_2025/features/init_controller_tabbar/presentation/cubit/init_controller_tabbar_cubit.dart';

class DiscoverScreen extends StatelessWidget {
  const DiscoverScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: DiscoverAppBar(),
        body: BlocBuilder<InitControllerTabbarCubit, InitControllerTabbarState>(
          builder: (context, state) {
            final selectedIndex =
                state is DiscoverTabChanged ? state.selectedIndex : 0;

            return IndexedStack(
              index: selectedIndex,
              children: [
                ViewTvScreen(),
                TVShowsList(),
              ],
            );
          },
        ),
      ),
    );
  }
}
