import 'package:netflix_sample_app/details/model/MovieDetails.dart';
import 'package:netflix_sample_app/home/model/LatestMovieResponse.dart';
import 'package:netflix_sample_app/home/model/MovieResponse.dart';
import 'package:netflix_sample_app/home/repo/MovieRepository.dart';
import 'package:netflix_sample_app/network/ApiHelper.dart';

class MovieDetailRepository {

  ApiHelper _helper = ApiHelper();

  Future<MovieDetails> fetchMovieDetails(String id) async {
    final response = await _helper.get("movie/$id?api_key=$apiKey&language=en-US");
    return MovieDetails.fromJson(response);
  }

}
