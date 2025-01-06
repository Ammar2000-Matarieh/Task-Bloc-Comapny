import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_company_app_new_2025/features/init_controller_tabbar/presentation/cubit/init_controller_tabbar_cubit.dart';

class DiscoverAppBar extends StatelessWidget implements PreferredSizeWidget {
  const DiscoverAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text("Discover"),
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(48.0), // Height of TabBar
        child:
            BlocBuilder<InitControllerTabbarCubit, InitControllerTabbarState>(
          builder: (context, state) {
            // final selectedIndex = state is DiscoverTabChanged
            //     ? state.selectedIndex
            //     : 0; // Default to 0 if state is initial

            return TabBar(
              controller: DefaultTabController.of(
                  context), // Use the default TabController
              onTap: (index) {
                context.read<InitControllerTabbarCubit>().switchTab(index);
              },
              tabs: const [
                Tab(
                  text: "Movies",
                ),
                Tab(text: "TV Shows"),
              ],
              indicatorColor: Colors.white,
              labelColor: Colors.black,
              unselectedLabelColor: Colors.grey,
            );
          },
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(100.0);
}
