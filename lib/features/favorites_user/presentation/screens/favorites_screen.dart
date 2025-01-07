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
          final movies = state.favoriteIds;

          if (movies.isEmpty) {
            return Center(child: Text('No favorites added yet!'));
          }

          return ListView.builder(
            itemCount: movies.length,
            itemBuilder: (context, index) {
              final movieId = movies[index];

              // Assuming you fetch the movie details using the movie ID
              return ListTile(
                leading: Icon(Icons.movie), // Placeholder for movie poster
                title: Text(
                    'Movie ID: $movieId'), // Show movie ID (you should fetch title)
                subtitle: Text('Favorite movie'),
                trailing: IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    context
                        .read<FavoritesUserCubit>()
                        .toggleFavorite(movieId, false); // Remove favorite
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
