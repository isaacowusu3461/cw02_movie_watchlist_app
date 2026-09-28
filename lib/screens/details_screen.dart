import 'package:flutter/material.dart';

import '../models/movie.dart';

class DetailsScreen extends StatefulWidget {
  final Movie movie;

  const DetailsScreen({
    super.key,
    required this.movie,
  });

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  void toggleWatchlist() {
    setState(() {
      widget.movie.isWatchlisted = !widget.movie.isWatchlisted;
    });

    ScaffoldMessenger.of(context).hideCurrentSnackBar();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          widget.movie.isWatchlisted
              ? '${widget.movie.title} added to your watchlist'
              : '${widget.movie.title} removed from your watchlist',
        ),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final movie = widget.movie;

    return Scaffold(
      appBar: AppBar(
        title: Text(movie.title),
        actions: [
          IconButton(
            tooltip: movie.isWatchlisted
                ? 'Remove from Watchlist'
                : 'Add to Watchlist',
            onPressed: toggleWatchlist,
            icon: Icon(
              movie.isWatchlisted
                  ? Icons.bookmark_rounded
                  : Icons.bookmark_border_rounded,
              color: movie.isWatchlisted ? Colors.amber : null,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Hero(
              tag: movie.title,
              child: SizedBox(
                height: 360,
                width: double.infinity,
                child: Image.asset(
                  movie.posterPath,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: Colors.grey.shade900,
                      child: const Center(
                        child: Icon(
                          Icons.movie,
                          size: 80,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.fromLTRB(20, 24, 20, 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          movie.title,
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium
                              ?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Icon(
                        movie.isWatchlisted
                            ? Icons.bookmark_rounded
                            : Icons.bookmark_border_rounded,
                        color: movie.isWatchlisted
                            ? Colors.amber
                            : Colors.grey,
                        size: 30,
                      ),
                    ],
                  ),

                  const SizedBox(height: 28),

                  const SectionTitle(
                    icon: Icons.people_alt_rounded,
                    title: 'Cast',
                  ),

                  const SizedBox(height: 12),

                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: movie.cast.map((actor) {
                      return Chip(
                        avatar: const Icon(
                          Icons.person,
                          size: 17,
                        ),
                        label: Text(actor),
                      );
                    }).toList(),
                  ),

                  const SizedBox(height: 30),

                  const SectionTitle(
                    icon: Icons.description_rounded,
                    title: 'Synopsis',
                  ),

                  const SizedBox(height: 12),

                  Text(
                    movie.synopsis,
                    style: TextStyle(
                      color: Colors.grey.shade300,
                      fontSize: 16,
                      height: 1.6,
                    ),
                  ),

                  const SizedBox(height: 30),

                  SizedBox(
                    width: double.infinity,
                    child: FilledButton.icon(
                      onPressed: toggleWatchlist,
                      icon: Icon(
                        movie.isWatchlisted
                            ? Icons.bookmark_remove
                            : Icons.bookmark_add,
                      ),
                      label: Text(
                        movie.isWatchlisted
                            ? 'Remove from Watchlist'
                            : 'Add to Watchlist',
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SectionTitle extends StatelessWidget {
  final IconData icon;
  final String title;

  const SectionTitle({
    super.key,
    required this.icon,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          size: 22,
          color: Colors.deepPurpleAccent,
        ),
        const SizedBox(width: 8),
        Text(
          title,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}