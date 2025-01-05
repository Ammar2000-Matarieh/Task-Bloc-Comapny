// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

import 'package:task_company_app_new_2025/utils/constants/app_constants.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  String query;
  SearchCubit()
      : query = '',
        super(SearchInitial());

  Future<void> searchMovies(String query) async {
    emit(SearchLoading());
    final uri = Uri.parse("${AppConstants.baseUrl}search/movie").replace(
      queryParameters: {
        "query": query,
      },
    );

    try {
      final response = await http.get(
        uri,
        headers: {
          "Authorization": "Bearer ${AppConstants.apiKeyAuthorization}",
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final movies = data[
            'results']; // Assuming the API response has a 'results' key for movies
        emit(SearchLoaded(movies)); // Emit the loaded movies state
      } else {
        emit(SearchError('Failed to load search results'));
      }
    } catch (e) {
      emit(SearchError('An error occurred while fetching data'));
      log(e.toString());
    }
  }
}
