import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_company_app_new_2025/features/favorites_user/presentation/cubit/favorites_user_cubit.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoritesUserCubit, FavoritesUserState>(
      builder: (context, state) {
        if (state is FavoritesLoading) {
          return Center(child: CircularProgressIndicator());
        } else if (state is FavoritesLoaded) {
          final movies = state.favorites;

          if (movies.isEmpty) {
            return Center(child: Text('No favorites added yet!'));
          }

          return ListView.builder(
            itemCount: movies.length,
            itemBuilder: (context, index) {
              final movie = movies[index];

              if (movie.results == null || movie.results!.isEmpty) {
                return SizedBox.shrink(); // Safeguard for null or empty results
              }

              final result = movie.results![index];
              // if (result == null) {
              //   return SizedBox.shrink();
              // }

              return ListTile(
                leading: result.posterPath != null
                    ? Image.network(
                        'https://image.tmdb.org/t/p/w500/${result.posterPath}',
                        errorBuilder: (context, error, stackTrace) {
                          return Icon(Icons.broken_image);
                        },
                      )
                    : Icon(Icons.broken_image),
                title: Text(
                  result.title ?? 'No Title',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  'Rating: ${result.voteAverage?.toStringAsFixed(1) ?? 'N/A'}',
                ),
                trailing: IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    context
                        .read<FavoritesUserCubit>()
                        .removeFavorite(result.id!);
                  },
                ),
              );
            },
          );
        } else if (state is FavoritesError) {
          return Center(child: Text(state.message));
        }

        return SizedBox.shrink();
      },
    );
  }
}
