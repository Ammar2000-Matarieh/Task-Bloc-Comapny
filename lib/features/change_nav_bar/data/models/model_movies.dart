import 'package:task_company_app_new_2025/features/change_nav_bar/data/models/results_model.dart';

class ModelMovies {
  int? page;
  List<ResultsModel>? results;
  int? totalPages;
  int? totalResults;

  ModelMovies({this.page, this.results, this.totalPages, this.totalResults});

  factory ModelMovies.fromJson(Map<String, dynamic> json) {
    return ModelMovies(
      page: json['page'],
      results: json['results'] != null
          ? List<ResultsModel>.from(
              json['results'].map((v) => ResultsModel.fromJson(v)))
          : null,
      totalPages: json['total_pages'],
      totalResults: json['total_results'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'page': page,
      'results': results?.map((v) => v.toJson()).toList(),
      'total_pages': totalPages,
      'total_results': totalResults,
    };
  }
}
