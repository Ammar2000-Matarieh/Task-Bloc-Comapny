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
        log("Response Data: $data"); // طباعة البيانات المستلمة
        final movies = ModelMovies.fromJson(data);
        emit(LoadedStateApi(movies));
      } else {
        print("Error: ${res.statusCode}");
        emit(ErrorStateApi(mess: "Error Fetch Data in App"));
      }
    } catch (e) {
      print("Exception: $e");
      emit(ErrorStateApi(mess: "Error Fetch Data in App"));
    }
  }

  // Future fetchTVShows() async {
  //   emit(LoadingInitial());
  //   final url = Uri.parse("${AppConstants.baseUrl}/discover/tv");
  //   try {
  //     var res = await http.get(
  //       url,
  //       headers: {
  //         "Authorization": "Bearer ${AppConstants.apiKeyAuthorization}",
  //       },
  //     );

  //     if (res.statusCode == 200 || res.statusCode == 201) {
  //       final data = json.decode(res.body);
  //       log("Response Data: $data"); // طباعة البيانات المستلمة
  //       final movies = ModelMovies.fromJson(data);
  //       emit(LoadedStateApi(movies));
  //     } else {
  //       print("Error: ${res.statusCode}");
  //       emit(ErrorStateApi(mess: "Error Fetch Data in App"));
  //     }
  //   } catch (e) {
  //     print("Exception: $e");
  //     emit(ErrorStateApi(mess: "Error Fetch Data in App"));
  //   }
  // }
}
// try {
    //   var res = await http.get(
    //     url,
    //     headers: {
    //       "Authorization": "Bearer ${AppConstants.apiKeyAuthorization}",
    //     },
    //   );

    //   if (res.statusCode == 200 || res.statusCode == 201) {
    //     final data = json.decode(res.body); // Entire JSON object
    //     final movies =
    //         ModelMovies.fromJson(data); // Parse the entire JSON response
    //     emit(LoadedStateApi(movies));
    //   } else {
    //     emit(ErrorStateApi());
    //   }
    // } catch (e) {
    //   emit(ErrorStateApi());
    // }
// final url = Uri.parse(
    //     '${AppConstants.baseUrl}/discover/tv?api_key=${AppConstants.apiKeyAuthorization}');
    // final response = await http.get(url);

    // if (response.statusCode == 200) {
    //   final data = json.decode(response.body);
    //   return (data['results'] as List)
    //       .map((item) => ModelMovies.fromJson(item))
    //       .toList();
    // } else {
    //   throw Exception("Failed to fetch TV shows");
    // }
    // Future<void> fetchTopRatedMovies() async {
  //   // final url = '/movie/top_rated';
  //   try {
  //     final url = Uri.parse("${AppConstants.baseUrl}movie/top_rated");
  //     final response = await http.get(
  //       url,
  //       headers: {
  //         "Authorization": "Bearer ${AppConstants.apiKeyAuthorization}",
  //       },
  //     );
  //     if (response.statusCode == 200 || response.statusCode == 201) {
  //       final data = json.decode(response.body);
  //       log("Response Data: $data"); // طباعة البيانات المستلمة
  //       final movies = ModelMovies.fromJson(data);
  //       emit(LoadedStateApi(movies));
  //     } else {
  //       print("Error: ${response.statusCode}");
  //       emit(ErrorStateApi());
  //     }
  //   } catch (e) {
  //     log(
  //       e.toString(),
  //     );
  //   }
  // return response.data['results'];
  // }