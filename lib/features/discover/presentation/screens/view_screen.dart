import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_company_app_new_2025/features/details_movies/presentation/cubit/details_movies_cubit.dart';
import 'package:task_company_app_new_2025/features/details_movies/presentation/screens/details_tv_screen.dart';
import 'package:task_company_app_new_2025/features/tv_views/presentation/cubit/tv_views_cubit.dart';

class TVShowsList extends StatelessWidget {
  const TVShowsList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TvViewsCubit, TvViewsState>(
      builder: (context, state) {
        if (state is LoadingTVInitial) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is ErrorApiStatesTV) {
          return Center(child: Text(state.mess));
        } else if (state is LoadedTVStates) {
          final tvShows =
              state.tvModels.results ?? []; // Access results from TVModels
          if (tvShows.isEmpty) {
            return const Center(child: Text("No TV Shows available."));
          }
          return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.7,
            ),
            itemCount: tvShows.length,
            itemBuilder: (context, index) {
              final tvShow = tvShows[index];
              return GestureDetector(
                onTap: () {
                  BlocProvider.of<DetailsMoviesCubit>(context)
                      .fetchSeasonDetails(
                    tvShow.id!,
                  );
                  Navigator.of(context).push(
                    CupertinoPageRoute(
                      builder: (context) => const DetailsTVScreen(),
                    ),
                  );
                },
                child: Card(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        child: tvShow.posterPath != null
                            ? Image.network(
                                "https://image.tmdb.org/t/p/w200${tvShow.posterPath}",
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return const Icon(Icons.image_not_supported);
                                },
                              )
                            : const Icon(Icons.image_not_supported),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          tvShow.name ??
                              "Unknown Title", // Updated to use 'name'
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
