import 'package:flutter_bloc/flutter_bloc.dart';
// ignore: depend_on_referenced_packages
import 'package:provider/single_child_widget.dart';
import 'package:task_company_app_new_2025/features/details_movies/presentation/cubit/details_movies_cubit.dart';
import 'package:task_company_app_new_2025/features/discover/presentation/cubit/call_api_cubit.dart';
import 'package:task_company_app_new_2025/features/change_nav_bar/presentation/cubit/change_nav_bar_cubit.dart';
import 'package:task_company_app_new_2025/features/favorites_user/presentation/cubit/favorites_user_cubit.dart';
import 'package:task_company_app_new_2025/features/init_controller_tabbar/presentation/cubit/init_controller_tabbar_cubit.dart';
import 'package:task_company_app_new_2025/features/search/presentation/cubit/search_cubit.dart';
import 'package:task_company_app_new_2025/features/top_cupit/presentation/cubit/top_cubit_cubit.dart';
import 'package:task_company_app_new_2025/features/tv_views/presentation/cubit/tv_views_cubit.dart';

List<SingleChildWidget> blocsProviders = [
  BlocProvider(
    create: (context) => ChangeNavBarCubit(),
  ),

  BlocProvider(
    create: (context) => CallApiCubit()..getAllMoviesData(),
  ),
  BlocProvider(create: (context) => TvViewsCubit()..getTVShowsData()),
  BlocProvider(
    create: (context) => SearchCubit(),
  ),
  BlocProvider(
    create: (context) => InitControllerTabbarCubit(),
  ),
  //InitControllerTabbarCubit

  BlocProvider(
    create: (context) => DetailsMoviesCubit(),
  ),

  BlocProvider(
    create: (context) => TopCubitCubit()..fetchTopRatedTV(),
  ),

  BlocProvider(
    create: (context) => FavoritesUserCubit()..loadFavorites(),
  ),
  // CallApiCubit()..getAllMoviesData(),
];
