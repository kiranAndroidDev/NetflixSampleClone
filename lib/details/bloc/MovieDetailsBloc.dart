import 'dart:async';

import 'package:netflix_sample_app/details/model/MovieDetails.dart';
import 'package:netflix_sample_app/details/repo/MovieDetailRepo.dart';
import 'package:netflix_sample_app/network/ApiResponse.dart';

class MovieDetailBloc{
  MovieDetailRepository _movieDetailRepository;

  StreamController _movieDetailController;

  StreamSink<ApiResponse<MovieDetails>> get movieDetailSink =>
      _movieDetailController.sink;

  Stream<ApiResponse<MovieDetails>> get movieDetailStream =>
      _movieDetailController.stream;

  MovieDetailBloc(){
    _movieDetailController = StreamController<ApiResponse<MovieDetails>>();
    _movieDetailRepository = MovieDetailRepository();
  }


  fetchMovieDetail(String id) async {
    movieDetailSink.add(ApiResponse.loading('Fetching Popular Movies'));
    try {
      MovieDetails movies = await _movieDetailRepository.fetchMovieDetails(id);
      movieDetailSink.add(ApiResponse.completed(movies));
    } catch (e) {
      movieDetailSink.add(ApiResponse.error(e.toString()));
      print(e);
    }
  }
}