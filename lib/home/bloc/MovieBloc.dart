import 'dart:async';

import 'package:netflix_sample_app/home/model/LatestMovieResponse.dart';
import 'package:netflix_sample_app/home/model/MovieResponse.dart';
import 'package:netflix_sample_app/home/repo/MovieRepository.dart';
import 'package:netflix_sample_app/network/ApiResponse.dart';

class MovieBloc {
  MovieRepository _movieRepository;

  StreamController _popularMovieListController;

  StreamSink<ApiResponse<List<Movie>>> get popularMovieListSink =>
      _popularMovieListController.sink;

  Stream<ApiResponse<List<Movie>>> get popularMovieListStream =>
      _popularMovieListController.stream;

  StreamController _topRatedMovieListController;

  StreamSink<ApiResponse<List<Movie>>> get topRatedMovieListSink =>
      _topRatedMovieListController.sink;

  Stream<ApiResponse<List<Movie>>> get topRatedmovieListStream =>
      _topRatedMovieListController.stream;

  StreamController _upcomingMovieListController;

  StreamSink<ApiResponse<List<Movie>>> get upcomingMovieListSink =>
      _upcomingMovieListController.sink;

  Stream<ApiResponse<List<Movie>>> get upcomingmovieListStream =>
      _upcomingMovieListController.stream;

  StreamController _latestMovieController;

  StreamSink<ApiResponse<LatestMovieResponse>> get latestMovieSink =>
      _latestMovieController.sink;

  Stream<ApiResponse<LatestMovieResponse>> get latestMovieStream =>
      _latestMovieController.stream;

  MovieBloc() {
    _topRatedMovieListController = StreamController<ApiResponse<List<Movie>>>();
    _popularMovieListController = StreamController<ApiResponse<List<Movie>>>();
    _upcomingMovieListController = StreamController<ApiResponse<List<Movie>>>();
    _latestMovieController = StreamController<ApiResponse<LatestMovieResponse>>();
    _movieRepository = MovieRepository();
  }

  fetchPopularMovieList() async {
    popularMovieListSink.add(ApiResponse.loading('Fetching Popular Movies'));
    try {
      List<Movie> movies = await _movieRepository.fetchPopularMovieList();
      popularMovieListSink.add(ApiResponse.completed(movies));
    } catch (e) {
      popularMovieListSink.add(ApiResponse.error(e.toString()));
      print(e);
    }
  }

  fetchTopRatedMovieList() async {
    topRatedMovieListSink.add(ApiResponse.loading('Fetching Top Rated Movies'));
    try {
      List<Movie> movies = await _movieRepository.fetchTopRatedMovieList();
      topRatedMovieListSink.add(ApiResponse.completed(movies));
    } catch (e) {
      topRatedMovieListSink.add(ApiResponse.error(e.toString()));
      print(e);
    }
  }

  fetchUpcomingMovieList({int page = 1}) async {
    upcomingMovieListSink.add(ApiResponse.loading('Fetching Upcoming Movies'));
    try {
      List<Movie> movies = await _movieRepository.fetchUpcomingMovieList(page);
      upcomingMovieListSink.add(ApiResponse.completed(movies));
      print("movies" + movies.toString());
    } catch (e) {
      upcomingMovieListSink.add(ApiResponse.error(e.toString()));
      print(e);
    }
  }

  fetchLatestMovie() async {
    latestMovieSink.add(ApiResponse.loading('Fetching Latest Movies'));
    try {
      LatestMovieResponse latestMovieResponse =
          await _movieRepository.fetchLatestMovie();
      latestMovieSink.add(ApiResponse.completed(latestMovieResponse));
      print("movies" + latestMovieResponse.toString());
    } catch (e) {
      latestMovieSink.add(ApiResponse.error(e.toString()));
      print(e);
    }
  }

  dispose() {
    _topRatedMovieListController?.close();
    _popularMovieListController?.close();
    _upcomingMovieListController?.close();
    _latestMovieController?.close();
  }
}
