import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_company_app_new_2025/features/details_movies/presentation/cubit/details_movies_cubit.dart';

class DetailsMoviesScreen extends StatelessWidget {
  const DetailsMoviesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Details Movies ",
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
      ),
      body: BlocBuilder<DetailsMoviesCubit, DetailsMoviesState>(
        builder: (context, state) {
          if (state is DetailsMoviesLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is LoadedStateApiDetails) {
            final movie = state.movieDetails;
            return SingleChildScrollView(
              child: Column(
                children: [
                  Image.network(
                    'https://image.tmdb.org/t/p/w500/${movie.posterPath}',
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(movie.title!,
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold)),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(movie.overview!),
                  ),
                  // RatingWidget(movieId: movieId), // Use the rating widget here
                ],
              ),
            );
          } else if (state is ErrorStateApiDetails) {
            return Center(child: Text('Error fetching data.'));
          }
          return Container();
        },
      ),
    );
  }
}
