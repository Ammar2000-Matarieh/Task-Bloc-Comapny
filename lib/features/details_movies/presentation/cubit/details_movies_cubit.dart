import 'dart:convert';
import 'dart:developer';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_company_app_new_2025/features/details_movies/data/models/model_details_movies.dart';
import 'package:task_company_app_new_2025/features/details_movies/data/models/model_tv_details.dart';
import 'package:task_company_app_new_2025/utils/constants/app_constants.dart';
import 'package:http/http.dart' as http;
part 'details_movies_state.dart';

class DetailsMoviesCubit extends Cubit<DetailsMoviesState> {
  DetailsMoviesCubit() : super(DetailsMoviesInitial());

  Future<void> getDetailsData(
    int movieId,
  ) async {
    emit(DetailsMoviesInitial());
    final url = Uri.parse("${AppConstants.baseUrl}movie/$movieId");

    try {
      var res = await http.get(
        url,
        headers: {
          "Authorization": "Bearer ${AppConstants.apiKeyAuthorization}",
        },
      );

      if (res.statusCode == 200 || res.statusCode == 201) {
        final data = json.decode(res.body);
        log("Response Data: $data");
        final movieDetails = MoviesDetails.fromJson(data);
        emit(LoadedStateApiDetails(movieDetails));
      } else {
        log("Error: ${res.statusCode}");
        emit(ErrorStateApiDetails(mess: "Error Fetching Movie Details"));
      }
    } catch (e) {
      log("Exception: $e");
      emit(ErrorStateApiDetails(mess: "Error Fetching Movie Details"));
    }
  }

  Future<void> fetchSeasonDetails(
    int seriesId,
  ) async {
    final url = Uri.parse('${AppConstants.baseUrl}tv/$seriesId');

    try {
      final response = await http.get(
        url,
        headers: {
          "Authorization": "Bearer ${AppConstants.apiKeyAuthorization}",
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = json.decode(response.body);

        final tvDetailsData = TVModelsDetails.fromJson(data);

        emit(LoadedStateApiDetailsTV(tvDetailsData));
      } else {
        emit(ErrorStateApiDetails(mess: "Error Fetching Movie Details"));

        // If the server does not return a 200 response, throw an exception
        throw Exception('Failed to load season details');
      }
    } catch (error) {
      emit(ErrorStateApiDetails(mess: "Error Fetching Movie Details"));

      throw Exception('Error fetching data: $error');
    }
  }
}
