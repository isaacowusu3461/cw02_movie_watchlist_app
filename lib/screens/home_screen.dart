import 'package:flutter/material.dart';

import '../data/movies_data.dart';
import '../models/movie.dart';
import 'details_screen.dart';
import 'watchlist_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int get watchlistCount {
    return sampleMovies.where((movie) => movie.isWatchlisted).length;
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

  void openWatchlist() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const WatchlistScreen(),
      ),
    ).then((_) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          children: [
            Icon(
              Icons.movie_filter_rounded,
              size: 28,
            ),
            SizedBox(width: 10),
            Text(
              'Movie Vault',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            tooltip: 'View Watchlist',
            onPressed: openWatchlist,
            icon: Badge(
              isLabelVisible: watchlistCount > 0,
              label: Text('$watchlistCount'),
              child: const Icon(Icons.bookmark_rounded),
            ),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Discover your next movie',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Browse movies and save your favorites to your watchlist.',
                    style: TextStyle(
                      color: Colors.grey.shade400,
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),

          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final movie = sampleMovies[index];

                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: MovieCard(
                      movie: movie,
                      onTap: () => openMovie(movie),
                    ),
                  );
                },
                childCount: sampleMovies.length,
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: openWatchlist,
        icon: const Icon(Icons.bookmark),
        label: Text(
          watchlistCount == 0
              ? 'Watchlist'
              : 'Watchlist ($watchlistCount)',
        ),
      ),
    );
  }
}

class MovieCard extends StatelessWidget {
  final Movie movie;
  final VoidCallback onTap;

  const MovieCard({
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
          height: 180,
          child: Row(
            children: [
              SizedBox(
                width: 120,
                height: double.infinity,
                child: Image.asset(
                  movie.posterPath,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: Colors.grey.shade900,
                      child: const Icon(
                        Icons.movie,
                        size: 50,
                      ),
                    );
                  },
                ),
              ),

              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        movie.title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 12),

                      Text(
                        'Cast',
                        style: TextStyle(
                          color: Colors.grey.shade400,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 4),

                      Text(
                        movie.cast.take(2).join(', '),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 13,
                        ),
                      ),

                      const Spacer(),

                      Row(
                        children: [
                          Icon(
                            movie.isWatchlisted
                                ? Icons.bookmark
                                : Icons.bookmark_border,
                            size: 18,
                            color: movie.isWatchlisted
                                ? Colors.amber
                                : Colors.grey,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            movie.isWatchlisted
                                ? 'In Watchlist'
                                : 'Add to Watchlist',
                            style: TextStyle(
                              color: movie.isWatchlisted
                                  ? Colors.amber
                                  : Colors.grey.shade400,
                              fontSize: 12,
                            ),
                          ),
                          const Spacer(),
                          const Icon(
                            Icons.arrow_forward_ios,
                            size: 16,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}