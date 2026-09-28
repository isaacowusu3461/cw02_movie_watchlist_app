import 'package:flutter/material.dart';

import '../data/movies_data.dart';
import '../models/movie.dart';
import 'details_screen.dart';

class WatchlistScreen extends StatefulWidget {
  const WatchlistScreen({super.key});

  @override
  State<WatchlistScreen> createState() => _WatchlistScreenState();
}

class _WatchlistScreenState extends State<WatchlistScreen> {
  List<Movie> get watchlistedMovies {
    return sampleMovies
        .where((movie) => movie.isWatchlisted)
        .toList();
  }

  void openMovie(Movie movie) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DetailsScreen(movie: movie),
      ),
    ).then((_) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    final movies = watchlistedMovies;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'My Watchlist',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: movies.isEmpty
          ? const EmptyWatchlist()
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: movies.length,
              itemBuilder: (context, index) {
                final movie = movies[index];

                return Padding(
                  padding: const EdgeInsets.only(bottom: 14),
                  child: WatchlistMovieCard(
                    movie: movie,
                    onTap: () => openMovie(movie),
                  ),
                );
              },
            ),
    );
  }
}

class WatchlistMovieCard extends StatelessWidget {
  final Movie movie;
  final VoidCallback onTap;

  const WatchlistMovieCard({
    super.key,
    required this.movie,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: SizedBox(
          height: 125,
          child: Row(
            children: [
              SizedBox(
                width: 90,
                height: double.infinity,
                child: Image.asset(
                  movie.posterPath,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: Colors.grey.shade900,
                      child: const Icon(Icons.movie),
                    );
                  },
                ),
              ),

              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(14),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        movie.title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                        ),
                      ),

                      const SizedBox(height: 8),

                      Text(
                        movie.cast.take(2).join(', '),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Colors.grey.shade400,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const Padding(
                padding: EdgeInsets.only(right: 16),
                child: Icon(
                  Icons.bookmark_rounded,
                  color: Colors.amber,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class EmptyWatchlist extends StatelessWidget {
  const EmptyWatchlist({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.bookmark_border_rounded,
              size: 90,
              color: Colors.grey.shade700,
            ),

            const SizedBox(height: 24),

            const Text(
              'Your watchlist is empty',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            Text(
              'Open a movie and tap the bookmark button to save it here.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.grey.shade400,
                fontSize: 15,
              ),
            ),
          ],
        ),
      ),
    );
  }
}