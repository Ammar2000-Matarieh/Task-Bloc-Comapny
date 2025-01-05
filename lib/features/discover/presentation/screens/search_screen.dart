import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_company_app_new_2025/features/search/presentation/cubit/search_cubit.dart';

class SearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search Movies'),
      ),
      body: BlocProvider(
        create: (context) => SearchCubit(), // Provide the SearchCubit
        child: SearchView(),
      ),
    );
  }
}

class SearchView extends StatefulWidget {
  @override
  _SearchViewState createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            controller: _searchController,
            decoration: InputDecoration(
              hintText: 'Search movies...',
              prefixIcon: Icon(Icons.search),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
            ),
            onSubmitted: (query) {
              context
                  .read<SearchCubit>()
                  .searchMovies(query); // Call searchMovies method of Cubit
            },
          ),
        ),
        Expanded(
          child: BlocBuilder<SearchCubit, SearchState>(
            builder: (context, state) {
              if (state is SearchLoading) {
                return Center(child: CircularProgressIndicator());
              } else if (state is SearchLoaded) {
                return ListView.builder(
                  itemCount: state.movies.length,
                  itemBuilder: (context, index) {
                    final movie = state.movies[index];
                    return ListTile(
                      leading: Image.network(
                        'https://image.tmdb.org/t/p/w200/${movie['poster_path'] ?? ''}',
                        errorBuilder: (context, error, stackTrace) =>
                            Icon(Icons.image_not_supported),
                      ),
                      title: Text(movie['title'] ?? 'No Title'),
                      subtitle: Text(movie['release_date'] ?? 'Unknown Date'),
                    );
                  },
                );
              } else if (state is SearchError) {
                return Center(child: Text(state.message));
              }
              return Center(child: Text('Search for movies by typing above.'));
            },
          ),
        ),
      ],
    );
  }
}
