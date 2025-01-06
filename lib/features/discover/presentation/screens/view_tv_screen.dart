import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_company_app_new_2025/features/details_movies/presentation/cubit/details_movies_cubit.dart';
import 'package:task_company_app_new_2025/features/discover/presentation/cubit/call_api_cubit.dart';
import 'package:task_company_app_new_2025/features/details_movies/presentation/screens/details_movies_screen.dart';

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
          final movies = state.modelMovies.results!;
          return GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.7,
            ),
            itemCount: movies.length,
            itemBuilder: (context, index) {
              final movie = movies[index];
              return GestureDetector(
                onTap: () {
                  BlocProvider.of<DetailsMoviesCubit>(context).getDetailsData(
                    movie.id!,
                  );
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
                        child: Image.network(
                          "https://image.tmdb.org/t/p/w200${movie.posterPath}",
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Icon(Icons.image_not_supported);
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          movie.title!,
                          style: TextStyle(
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
        return SizedBox.shrink();
      },
    );
  }
}
// appBar: AppBar(
      //   title: Text('Discover Movies'),
      //   actions: [
      //     IconButton(
      //       icon: Icon(Icons.search),
      //       onPressed: () {
      //         Navigator.push(
      //           context,
      //           MaterialPageRoute(builder: (context) => SearchScreen()),
      //         );
      //       },
      //     ),
      //   ],
      // ),
      // body: