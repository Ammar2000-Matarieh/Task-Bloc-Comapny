import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:task_company_app_new_2025/features/top_cupit/data/models/top_rated_model.dart';
import 'package:task_company_app_new_2025/utils/constants/app_constants.dart';
part 'top_cubit_state.dart';

class TopCubitCubit extends Cubit<TopCubitState> {
  TopCubitCubit() : super(TopCubitInitial());

  Future<void> fetchTopRatedTV() async {
    emit(TopRatedTVLoading());

    final url = Uri.parse('https://api.themoviedb.org/3/tv/top_rated');

    try {
      final response = await http.get(
        url,
        headers: {
          "Authorization": "Bearer ${AppConstants.apiKeyAuthorization}",
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final tvShows = TopRatedModel.fromJson(data);

        emit(TopRatedTVLoaded(tvShows));
      } else {
        emit(TopRatedTVError('Failed to fetch top-rated TV shows.'));
      }
    } catch (e) {
      emit(TopRatedTVError('Error: $e'));
    }
  }
}
