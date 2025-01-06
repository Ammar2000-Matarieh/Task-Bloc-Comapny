import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_company_app_new_2025/features/top_cupit/presentation/cubit/top_cubit_cubit.dart';

class TopRatingScreen extends StatelessWidget {
  const TopRatingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TopCubitCubit()..fetchTopRatedTV(),
      child: BlocBuilder<TopCubitCubit, TopCubitState>(
        builder: (context, state) {
          if (state is TopRatedTVLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is TopRatedTVLoaded) {
            final tvShowsData = state.tvShows.results!;

            return ListView.builder(
              itemCount: tvShowsData.length,
              itemBuilder: (context, index) {
                final tvShow = tvShowsData[index];
                return Card(
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundImage: tvShow.posterPath != null
                          ? NetworkImage(
                              'https://image.tmdb.org/t/p/w500/${tvShow.posterPath}',
                            )
                          : null,
                      child: tvShow.posterPath == null ? Icon(Icons.tv) : null,
                    ),
                    title: Text(tvShow.title ?? 'No Title'),
                    subtitle: Text(
                        'Rating: ${tvShow.voteAverage?.toStringAsFixed(1) ?? 'N/A'}'),
                  ),
                );
              },
            );
          } else if (state is TopRatedTVError) {
            return Center(child: Text(state.message));
          }
          return Container();
        },
      ),
    );
  }
}
