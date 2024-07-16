import 'package:flutter/material.dart';
import 'package:testapp/model/model_movie.dart';

class CarouselImage extends StatefulWidget {
  final List<Movie> movies;
  const CarouselImage({super.key, required this.movies});
  @override
  _CarouselImageState createState() => _CarouselImageState();
}

class _CarouselImageState extends State<CarouselImage> {
  late List<Movie> movies;
  late List<Widget> images;
  late List<String> keywords;
  late List<bool> likes;

  final int _currentPage = 0;
  late String _currentKeyword;

  @override
  void initState() {
    super.initState();
    movies = widget.movies;
    images = movies.map((m) => Image.asset('./images/${m.poster}')).toList();
    keywords = movies.map((m) => m.keyword).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
