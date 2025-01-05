import 'dart:convert';
import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_company_app_new_2025/features/details_movies/data/models/model_details_movies.dart';
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
        log("Response Data: $data"); // طباعة البيانات المستلمة
        final movieDetails = MoviesDetails.fromJson(
            data); // تحويل البيانات إلى نموذج MovieDetails
        emit(LoadedStateApiDetails(movieDetails)); // إرسال الحالة مع التفاصيل
      } else {
        print("Error: ${res.statusCode}");
        emit(ErrorStateApiDetails(mess: "Error Fetching Movie Details"));
      }
    } catch (e) {
      print("Exception: $e");
      emit(ErrorStateApiDetails(mess: "Error Fetching Movie Details"));
    }
  }
}
