import 'dart:convert';
import 'dart:developer';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:task_company_app_new_2025/features/change_nav_bar/data/models/model_movies.dart';
import 'package:task_company_app_new_2025/utils/constants/app_constants.dart';

part 'call_api_state.dart';

class CallApiCubit extends Cubit<CallApiState> {
  CallApiCubit() : super(InitialStateData());

  Future<void> getAllMoviesData() async {
    emit(LoadingInitial());
    final url = Uri.parse("${AppConstants.baseUrl}discover/movie");
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
        final movies = ModelMovies.fromJson(data);
        emit(LoadedStateApi(movies));
      } else {
        log("Error: ${res.statusCode}");
        emit(ErrorStateApi(mess: "Error Fetch Data in App"));
      }
    } catch (e) {
      log("Exception: $e");
      emit(ErrorStateApi(mess: "Error Fetch Data in App"));
    }
  }
}
