import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'init_controller_tabbar_state.dart';

class InitControllerTabbarCubit extends Cubit<InitControllerTabbarState> {
  InitControllerTabbarCubit() : super(InitControllerTabbarInitial());

  int _selectedIndex = 0;

  int get selectedIndex => _selectedIndex;

  void switchTab(int index) {
    _selectedIndex = index;
    emit(
      DiscoverTabChanged(
        _selectedIndex,
      ),
    );
  }
}
