import 'package:flutter/material.dart';
import 'package:testapp/model/model_movie.dart';

class CarouselImage extends StatefulWidget {
  final List<Movie> movies;
  CarouselImage({this.movies});
  _CarouselImageState createState() => _CarouselImageState();
  
}

 class _CarouselImageState extends State<CarouselImage> {

  List<Movie> movies;
  List<Widget> images;
  List<String> keywords;
  List<bool> likes;

  int _currentPage = 0;
  String _currentKeyword;

  @override
  void initState() {
    super.initState();
    movies = widget.movies;
    images = movies.map((m) => Image.asset('./images/' + m.poster)).toList();
    keywords = movies.map((m) => m.keyword).toList();
    
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
 }