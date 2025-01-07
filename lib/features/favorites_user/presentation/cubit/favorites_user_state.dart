part of 'favorites_user_cubit.dart';

abstract class FavoritesUserState extends Equatable {
  const FavoritesUserState();

  @override
  List<Object> get props => [];
}

class FavoritesUserInitial extends FavoritesUserState {}

class FavoritesLoading extends FavoritesUserState {}

class FavoritesLoaded extends FavoritesUserState {
  final List<int> favoriteIds;
  final List<ModelMovies> favoriteMovies;

  const FavoritesLoaded(
    this.favoriteIds,
    this.favoriteMovies,
  );

  @override
  List<Object> get props => [favoriteIds, favoriteMovies];
}

class FavoritesError extends FavoritesUserState {
  final String message;

  const FavoritesError(this.message);

  @override
  List<Object> get props => [message];
}
