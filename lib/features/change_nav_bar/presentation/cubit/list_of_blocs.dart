import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/single_child_widget.dart';
import 'package:task_company_app_new_2025/features/details_movies/presentation/cubit/details_movies_cubit.dart';
import 'package:task_company_app_new_2025/features/discover/presentation/cubit/call_api_cubit.dart';
import 'package:task_company_app_new_2025/features/change_nav_bar/presentation/cubit/change_nav_bar_cubit.dart';
import 'package:task_company_app_new_2025/features/search/presentation/cubit/search_cubit.dart';

List<SingleChildWidget> blocsProviders = [
  BlocProvider(
    create: (context) => ChangeNavBarCubit(),
  ),

  BlocProvider(
    create: (context) => CallApiCubit()..getAllMoviesData(),
  ),

  BlocProvider(
    create: (context) => SearchCubit(),
  ),

  BlocProvider(
    create: (context) => DetailsMoviesCubit(),
  ),
  // CallApiCubit()..getAllMoviesData(),
];
