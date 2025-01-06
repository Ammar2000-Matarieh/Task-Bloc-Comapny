import 'dart:convert';
import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_company_app_new_2025/features/details_movies/data/models/model_tv_details.dart';
import 'package:task_company_app_new_2025/features/tv_views/data/models/tv_model.dart';
import 'package:task_company_app_new_2025/utils/constants/app_constants.dart';
import 'package:http/http.dart' as http;
part 'tv_views_state.dart';

class TvViewsCubit extends Cubit<TvViewsState> {
  TvViewsCubit() : super(TvViewsInitial());

  Future<void> getTVShowsData() async {
    emit(LoadingTVInitial());
    final url = Uri.parse("${AppConstants.baseUrl}/discover/tv");
    try {
      var res = await http.get(
        url,
        headers: {
          "Authorization": "Bearer ${AppConstants.apiKeyAuthorization}",
        },
      );

      if (res.statusCode == 200 || res.statusCode == 201) {
        final data = json.decode(res.body);
        log("TV Shows Data: $data");
        final tvShows = TVModels.fromJson(data); // Use TVModels
        emit(LoadedTVStates(tvShows));
      } else {
        emit(ErrorApiStatesTV(mess: "Failed to fetch TV shows data"));
      }
    } catch (e) {
      emit(ErrorApiStatesTV(mess: "Error: $e"));
    }
  }
}
