import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_company_app_new_2025/features/change_nav_bar/data/models/model_movies.dart';
import 'package:task_company_app_new_2025/utils/constants/app_constants.dart';
import 'package:http/http.dart' as http;
part 'favorites_user_state.dart';

class FavoritesUserCubit extends Cubit<FavoritesUserState> {
  FavoritesUserCubit() : super(FavoritesUserInitial());

  List<int> favoriteIds = []; // List of favorite movie IDs.

  Future<void> loadFavorites() async {
    emit(FavoritesLoading());
    try {
      List<ModelMovies> favorites = [];
      for (var id in favoriteIds) {
        final movie = await fetchMovieById(id);
        favorites.add(movie);
      }
      emit(FavoritesLoaded(favorites));
    } catch (e) {
      emit(FavoritesError('Failed to load favorites: $e'));
    }
  }

  void addFavorite(int id) {
    if (!favoriteIds.contains(id)) {
      favoriteIds.add(id);
      loadFavorites();
    }
  }

  void removeFavorite(int id) {
    favoriteIds.remove(id);
    loadFavorites();
  }

  Future<ModelMovies> fetchMovieById(int id) async {
    final url = Uri.parse('${AppConstants.baseUrl}/movie/$id');
    final response = await http.get(
      url,
      headers: {
        "Authorization": "Bearer ${AppConstants.apiKeyAuthorization}",
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return ModelMovies.fromJson(data);
    } else {
      throw Exception('Failed to load movie');
    }
  }
}
