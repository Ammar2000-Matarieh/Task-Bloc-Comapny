import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_company_app_new_2025/features/details_movies/presentation/cubit/details_movies_cubit.dart';
import 'package:task_company_app_new_2025/features/discover/presentation/cubit/call_api_cubit.dart';
import 'package:task_company_app_new_2025/features/details_movies/presentation/screens/details_movies_screen.dart';
import 'package:task_company_app_new_2025/features/favorites_user/presentation/cubit/favorites_user_cubit.dart';

class ViewTvScreen extends StatelessWidget {
  const ViewTvScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CallApiCubit, CallApiState>(
      builder: (context, state) {
        if (state is LoadingInitial) {
          return Center(child: CircularProgressIndicator());
        } else if (state is ErrorStateApi) {
          return Center(child: Text(state.mess));
        } else if (state is LoadedStateApi) {
          final movies = state.modelMovies.results ?? [];

          return GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.7,
            ),
            itemCount: movies.length,
            itemBuilder: (context, index) {
              final movie = movies[index];
              if (movie.id == null) return SizedBox.shrink(); // Safeguard

              final isFavorite = context
                  .read<FavoritesUserCubit>()
                  .favoriteIds
                  .contains(movie.id);

              return GestureDetector(
                onTap: () {
                  BlocProvider.of<DetailsMoviesCubit>(context)
                      .getDetailsData(movie.id!);
                  Navigator.of(context).push(
                    CupertinoPageRoute(
                      builder: (context) => DetailsMoviesScreen(),
                    ),
                  );
                },
                child: Card(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        child: movie.posterPath != null
                            ? Image.network(
                                "https://image.tmdb.org/t/p/w200${movie.posterPath}",
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return Icon(Icons.image_not_supported);
                                },
                              )
                            : Icon(Icons.image_not_supported),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          movie.title ?? 'No Title',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      IconButton(
                        icon: Icon(
                          isFavorite ? Icons.favorite : Icons.favorite_border,
                          color: isFavorite ? Colors.red : Colors.grey,
                        ),
                        onPressed: () {
                          final favoritesCubit =
                              context.read<FavoritesUserCubit>();
                          if (isFavorite) {
                            favoritesCubit.removeFavorite(movie.id!);
                          } else {
                            favoritesCubit.addFavorite(movie.id!);
                          }
                        },
                      )
                    ],
                  ),
                ),
              );
            },
          );
        }
        return SizedBox.shrink();
      },
    );
  }
}
