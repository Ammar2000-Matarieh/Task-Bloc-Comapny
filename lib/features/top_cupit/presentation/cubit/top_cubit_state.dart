part of 'top_cubit_cubit.dart';

abstract class TopCubitState extends Equatable {
  const TopCubitState();

  @override
  List<Object> get props => [];
}

class TopCubitInitial extends TopCubitState {}

class TopRatedTVLoading extends TopCubitState {}

class TopRatedTVLoaded extends TopCubitState {
  final TopRatedModel tvShows;

  TopRatedTVLoaded(this.tvShows);
}

class TopRatedTVError extends TopCubitState {
  final String message;

  TopRatedTVError(this.message);
}
