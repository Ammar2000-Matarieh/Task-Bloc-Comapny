part of 'details_movies_cubit.dart';

abstract class DetailsMoviesState extends Equatable {
  const DetailsMoviesState();

  @override
  List<Object> get props => [];
}

class DetailsMoviesInitial extends DetailsMoviesState {}

class DetailsMoviesLoading extends DetailsMoviesState {}

class LoadedStateApiDetails extends DetailsMoviesState {
  final MoviesDetails movieDetails;
  const LoadedStateApiDetails(
    this.movieDetails,
  );
  @override
  List<Object> get props => [movieDetails];
}

class LoadedStateApiDetailsTV extends DetailsMoviesState {
  final TVModelsDetails modelTV;
  const LoadedStateApiDetailsTV(
    this.modelTV,
  );
  @override
  List<Object> get props => [modelTV];
}

class ErrorStateApiDetails extends DetailsMoviesState {
  final String mess;
  const ErrorStateApiDetails({
    required this.mess,
  });

  @override
  List<Object> get props => [mess];
}
