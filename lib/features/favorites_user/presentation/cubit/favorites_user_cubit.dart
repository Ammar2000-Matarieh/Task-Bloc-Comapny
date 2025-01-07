import 'dart:convert';
import 'dart:developer';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_company_app_new_2025/features/change_nav_bar/data/models/model_movies.dart';
import 'package:task_company_app_new_2025/utils/constants/app_constants.dart';
import 'package:http/http.dart' as http;
part 'favorites_user_state.dart';

class FavoritesUserCubit extends Cubit<FavoritesUserState> {
  final int index;
  FavoritesUserCubit(this.index) : super(FavoritesUserInitial());

  String sessionId = '';

  String? accountId;
  List<int> favoriteIds = [];
  List<ModelMovies> favoriteMovies = [];

  Future<void> fetchAccountDetails() async {
    try {
      var url = Uri.parse('${AppConstants.baseUrl}/account');
      var response = await http.get(
        url,
        headers: {
          "Authorization": "Bearer ${AppConstants.apiKeyAuthorization}",
        },
      );

      log(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        var data = json.decode(response.body);
        accountId = data["id"].toString();
        log(accountId!);

        if (accountId!.isNotEmpty) {
          await loadFavorites();
        } else {
          emit(FavoritesError("Account ID is empty."));
        }
      } else {
        throw Exception('Failed to fetch account details');
      }
    } catch (e) {
      emit(FavoritesError('Error fetching account details: $e'));
    }
  }

  Future<void> loadFavorites() async {
    if (accountId!.isEmpty) {
      emit(FavoritesError('Account ID is empty. Cannot load favorites.'));
      return;
    }

    emit(FavoritesLoading());

    try {
      final url = Uri.parse(
          '${AppConstants.baseUrl}/account/$accountId/favorite/movies');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        if (data['results'] != null) {
          final List<ModelMovies> favoriteMoviesList = (data['results'] as List)
              .map((movie) => ModelMovies.fromJson(movie))
              .toList();

          favoriteMovies = favoriteMoviesList;

          final List<int> favoriteMovieIds = favoriteMoviesList
              .map((movie) => movie.results![index].id!)
              .toList();

          favoriteIds = favoriteMovieIds;

          emit(FavoritesLoaded(favoriteIds, favoriteMovies));
        } else {
          throw Exception('No favorites found');
        }
      } else {
        throw Exception('Failed to load favorites');
      }
    } catch (e) {
      emit(FavoritesError('Error loading favorites: $e'));
    }
  }

  Future<void> toggleFavorite(int movieId, bool isFavorite) async {
    if (accountId!.isEmpty) {
      emit(FavoritesError('Account ID is empty. Cannot toggle favorite.'));
      return;
    }

    try {
      var url =
          Uri.parse('${AppConstants.baseUrl}/account/${accountId!}/favorite');
      var response = await http.post(
        url,
        headers: {
          "Authorization": "Bearer ${AppConstants.apiKeyAuthorization}",
          'Content-Type': 'application/json'
        },
        body: json.encode({
          "media_type": "movie",
          "media_id": movieId,
          "favorite": isFavorite,
        }),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        if (isFavorite) {
          favoriteIds.add(movieId);
        } else {
          favoriteIds.remove(movieId);
        }

        emit(FavoritesLoaded(favoriteIds, favoriteMovies));
      } else {
        final errorData = json.decode(response.body);
        throw Exception(
            'Failed to toggle favorite: ${errorData['status_message']}');
      }
    } catch (e) {
      emit(FavoritesError('Error toggling favorite: $e'));
    }
  }
}
