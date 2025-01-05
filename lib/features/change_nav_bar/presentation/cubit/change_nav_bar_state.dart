import 'package:equatable/equatable.dart';

abstract class ChangeNavBarState extends Equatable {
  const ChangeNavBarState();

  @override
  List<Object> get props => [];
}

class ChangeNavBarInitial extends ChangeNavBarState {}

class ChangeNavBarUpdated extends ChangeNavBarState {
  final int currentScreen;

  const ChangeNavBarUpdated(
    this.currentScreen,
  );

  @override
  List<Object> get props => [currentScreen];
}
