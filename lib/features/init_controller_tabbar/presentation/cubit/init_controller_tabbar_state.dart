part of 'init_controller_tabbar_cubit.dart';

abstract class InitControllerTabbarState extends Equatable {
  const InitControllerTabbarState();

  @override
  List<Object> get props => [];
}

class InitControllerTabbarInitial extends InitControllerTabbarState {}

class DiscoverTabChanged extends InitControllerTabbarState {
  final int selectedIndex;

  const DiscoverTabChanged(
    this.selectedIndex,
  );

  @override
  List<Object> get props => [selectedIndex];
}
