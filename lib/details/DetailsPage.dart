import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:netflix_sample_app/details/bloc/MovieDetailsBloc.dart';
import 'package:netflix_sample_app/details/model/MovieDetails.dart';
import 'package:netflix_sample_app/network/ApiResponse.dart';

class DetailsPage extends StatefulWidget {
  String id;

  DetailsPage({@required this.id});

  @override
  State<StatefulWidget> createState() {
    return _DetailPageState(id);
  }
}

class _DetailPageState extends State<DetailsPage> {
  String mId;
  MovieDetailBloc _bloc;

  _DetailPageState(String id) {
    this.mId = id;
  }

  @override
  void initState() {
    super.initState();
    _bloc = MovieDetailBloc();
    _bloc.fetchMovieDetail(mId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white.withOpacity(0.15),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              child: Column(
                children: <Widget>[
                  StreamBuilder<ApiResponse<MovieDetails>>(
                    stream: _bloc.movieDetailStream,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        switch (snapshot.data.status) {
                          case Status.COMPLETED:
                            return Container(
                              child: _buildDetailsPage(snapshot.data.data),
                            );
                            break;
                          case Status.LOADING:
                            return Container(
                                height: 160,
                                alignment: Alignment.center,
                                child: CircularProgressIndicator());
                            break;
                          case Status.ERROR:
                            return Container(
                              child: Text("Something went wrong"),
                            );
                        }
                      }
                      if (snapshot.hasError)
                        return Container(
                          child: Text("Something went wrong"),
                        );
                      return Container(
                        child: Text("Something went wrong"),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ));
  }

  Column _buildDetailsPage(MovieDetails data) {
    String path;
    if (data.posterPath == null)
      path = placeholderUrl;
    else
      path = "https://image.tmdb.org/t/p/w500" + data.posterPath;
    return Column(
      children: <Widget>[
        Container(
          height: 290,
          child: Stack(
            fit: StackFit.loose,
            children: [
              Container(
                height: 270,
                child: CachedNetworkImage(
                  placeholder: (context, des) {
                    return Image.asset(
                      "assets/placeholder.jpg",
                      fit: BoxFit.fill,
                    );
                  },
                  errorWidget: (context, des, err) {
                    return Image.asset(
                      "assets/placeholder.jpg",
                      fit: BoxFit.fill,
                    );
                  },
                  imageUrl: path,
                  fit: BoxFit.fill,
                ),
                width: double.infinity,
              ),
              Container(
                alignment: Alignment.bottomCenter,
                child: FloatingActionButton(
                  onPressed: () {},
                  elevation: 6,
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.red,
                  splashColor: Colors.grey[50],
                  hoverColor: Colors.grey[50],
                  focusColor: Colors.grey[50],
                  child: Icon(
                    Icons.play_arrow,
                    color: Colors.white,
                  ),
                ),
              )
            ],
          ),
        ),
        Container(
          alignment: Alignment.center,
          child: Text(
            data.title,
            style: GoogleFonts.roboto().copyWith(
                color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
          ),
          margin: EdgeInsets.fromLTRB(10, 30, 10, 10),
        ),
        if (data.tagline != null && data.tagline != "")
          Container(
            alignment: Alignment.center,
            child: Text(
              data.tagline,
              style: GoogleFonts.roboto()
                  .copyWith(color: Colors.white, fontSize: 20),
            ),
            margin: EdgeInsets.fromLTRB(10, 30, 10, 10),
          ),
        if (data.overview != null && !data.overview.isEmpty)
          Container(
            alignment: Alignment.centerLeft,
            child: Text(
              "Overview",
              style: GoogleFonts.roboto().copyWith(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w400),
            ),
            margin: EdgeInsets.fromLTRB(10, 30, 10, 10),
          ),
        Container(
          margin: EdgeInsets.fromLTRB(20, 10, 10, 10),
          child: Text(
            data.overview,
            style: Theme.of(context).textTheme.bodyText1.copyWith(
                color: Colors.white,
                letterSpacing: 1.5,
                height: 1.5,
                fontSize: 14),
          ),
        ),
        Container(
          alignment: Alignment.centerLeft,
          child: Text(
            "Popularity :   " +
                (data.popularity == null ? "0.0" : data.popularity.toString()),
            style: GoogleFonts.roboto().copyWith(
                color: Colors.white, fontSize: 18, fontWeight: FontWeight.w400),
          ),
          margin: EdgeInsets.fromLTRB(10, 30, 10, 10),
        ),
        Container(
          alignment: Alignment.centerLeft,
          child: Text(
            "Average Ratings :   " +
                (data.voteAverage == null
                    ? "0.0"
                    : data.voteAverage.toString()),
            style: GoogleFonts.roboto().copyWith(
                color: Colors.white, fontSize: 18, fontWeight: FontWeight.w400),
          ),
          margin: EdgeInsets.fromLTRB(10, 30, 10, 10),
        ),
        if (data.genres != null && data.genres.length > 0)
          Container(
            alignment: Alignment.centerLeft,
            child: Text(
              "Geners",
              style: GoogleFonts.roboto().copyWith(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w400),
            ),
            margin: EdgeInsets.fromLTRB(10, 30, 10, 10),
          ),
        if (data.genres != null && data.genres.length > 0)
          Container(
            margin: EdgeInsets.fromLTRB(30, 0, 10, 10),
            child: ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                return Row(
                  children: <Widget>[
                    Container(
                      width: 6,
                      height: 6,
                      margin: EdgeInsets.only(right: 8),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: Colors.white),
                    ),
                    Text(data.genres[index].name,
                        style: Theme.of(context).textTheme.bodyText1.copyWith(
                            color: Colors.white,
                            letterSpacing: 1.5,
                            height: 1.5,
                            fontSize: 14)),
                  ],
                );
              },
              itemCount: data.genres.length,
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
            ),
          )
      ],
    );
  }

  static const String placeholderUrl =
      "https://cdn.pixabay.com/photo/2016/08/04/09/05/coming-soon-1568623__340.jpg";
}
