part of 'tv_views_cubit.dart';

abstract class TvViewsState extends Equatable {
  const TvViewsState();

  @override
  List<Object> get props => [];
}

class TvViewsInitial extends TvViewsState {}

class LoadingTVInitial extends TvViewsInitial {}

class LoadedTVStates extends TvViewsInitial {
  final TVModels tvModels; // Updated to TVModels
  LoadedTVStates(
    this.tvModels,
  );

  @override
  List<Object> get props => [tvModels];
}

class LoadedTVDetails extends TvViewsInitial {
  final TVModelsDetails tvDetails; // Updated to TVModels
  LoadedTVDetails(
    this.tvDetails,
  );

  @override
  List<Object> get props => [tvDetails];
}

class ErrorApiStatesTV extends TvViewsInitial {
  final String mess;

  ErrorApiStatesTV({
    required this.mess,
  });

  @override
  List<Object> get props => [mess];
}
