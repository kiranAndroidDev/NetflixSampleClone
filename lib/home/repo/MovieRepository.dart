import 'package:netflix_sample_app/home/model/LatestMovieResponse.dart';
import 'package:netflix_sample_app/home/model/MovieResponse.dart';
import 'package:netflix_sample_app/network/ApiHelper.dart';
const  String apiKey = "your api key";
class MovieRepository {


  ApiHelper _helper = ApiHelper();

  Future<List<Movie>> fetchPopularMovieList() async {
    final response = await _helper.get("movie/popular?api_key=$apiKey");
    return MovieResponse.fromJson(response).results;
  }

  Future<List<Movie>> fetchTopRatedMovieList() async {
    final response = await _helper.get("movie/top_rated?api_key=$apiKey");
    return MovieResponse.fromJson(response).results;
  }

  Future<List<Movie>> fetchUpcomingMovieList(int page) async {
    print("Page $page");
    final response = await _helper.get("movie/upcoming?api_key=$apiKey&page=$page");
    return MovieResponse.fromJson(response).results;
  }

  Future<LatestMovieResponse> fetchLatestMovie() async {
    final response = await _helper.get("movie/latest?api_key=$apiKey");
    print("Latest Reponse => $response");
    return LatestMovieResponse.fromJson(response);
  }
}
