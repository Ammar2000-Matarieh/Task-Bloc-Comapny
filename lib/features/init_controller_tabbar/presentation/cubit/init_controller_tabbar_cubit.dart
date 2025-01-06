import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'init_controller_tabbar_state.dart';

class InitControllerTabbarCubit extends Cubit<InitControllerTabbarState> {
  InitControllerTabbarCubit() : super(InitControllerTabbarInitial());

  int _selectedIndex = 0;

  // Get the current tab index
  int get selectedIndex => _selectedIndex;

  // Change the selected tab
  void switchTab(int index) {
    _selectedIndex = index;
    emit(DiscoverTabChanged(_selectedIndex));
  }
}


// class DiscoverCubit extends Cubit<int> {
//   DiscoverCubit() : super(0); // Default tab index is 0 (Movies)

//   void switchTab(int index) {
//     emit(index);
//   }
// }