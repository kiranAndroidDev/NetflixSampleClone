import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:netflix_sample_app/AppTheme.dart';
import 'package:netflix_sample_app/details/DetailsPage.dart';
import 'package:netflix_sample_app/home/bloc/MovieBloc.dart';
import 'package:netflix_sample_app/downloads/Downloads.dart';
import 'package:netflix_sample_app/home/model/LatestMovieResponse.dart';
import 'package:netflix_sample_app/home/model/MovieResponse.dart';
import 'package:netflix_sample_app/home/ui/list_item.dart';
import 'package:netflix_sample_app/home/ui/top_banner.dart';
import 'package:netflix_sample_app/network/ApiResponse.dart';
import 'package:netflix_sample_app/search/SearchList.dart';
import 'package:shimmer/shimmer.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  MovieBloc _bloc;

  @override
  void initState() {
    _bloc = MovieBloc();
    _refresh();
  }

  Future<Null> _refresh() async {
    _bloc.fetchPopularMovieList();
    _bloc.fetchLatestMovie();
    _bloc.fetchTopRatedMovieList();
    _bloc.fetchUpcomingMovieList();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          title: _buildAppBar(),
        ),
        drawer: _buildBottomNavigationBar(),
        body: RefreshIndicator(
          onRefresh: _refresh,
          child: ListView(
            shrinkWrap: true,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Column(
                    children: [
                      StreamBuilder<ApiResponse<LatestMovieResponse>>(
                        stream: _bloc.latestMovieStream,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            switch (snapshot.data.status) {
                              case Status.COMPLETED:
                                String path;
                                String id = snapshot.data.data.id.toString();
                                {
                                  if (snapshot.data.data.posterPath == null)
                                    path = placeholderUrl;
                                  else
                                    path = "https://image.tmdb.org/t/p/w500" +
                                        snapshot.data.data.posterPath;
                                }
                                return Container(
                                  padding: EdgeInsets.only(
                                      left: 20, right: 20, bottom: 20, top: 10),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20))),
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          new MaterialPageRoute(
                                              builder: (context) =>
                                                  new DetailsPage(
                                                    id: id,
                                                  )));
                                    },
                                    customBorder: new RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20))),
                                    child: TopBanner(
                                      path: path,
                                      title: snapshot.data.data.title,
                                    ),
                                  ),
                                );
                                break;
                              case Status.LOADING:
                                return Container(
                                    height: 250,
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
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Popular Movies",
                      style: GoogleFonts.roboto()
                          .copyWith(color: Colors.white, fontSize: 18),
                    ),
                    margin: EdgeInsets.fromLTRB(10, 30, 10, 10),
                  ),
                  StreamBuilder<ApiResponse<List<Movie>>>(
                    stream: _bloc.popularMovieListStream,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        switch (snapshot.data.status) {
                          case Status.COMPLETED:
                            return Container(
                                height: 160,
                                child: _buildMovieList(snapshot.data.data));
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
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Top Rated Movies",
                      style: GoogleFonts.roboto()
                          .copyWith(color: Colors.white, fontSize: 18),
                    ),
                    margin: EdgeInsets.fromLTRB(10, 30, 10, 10),
                  ),
                  StreamBuilder<ApiResponse<List<Movie>>>(
                    stream: _bloc.topRatedmovieListStream,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        switch (snapshot.data.status) {
                          case Status.COMPLETED:
                            return Container(
                              height: 160,
                              child: _buildMovieList(snapshot.data.data),
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
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Upcoming Movies",
                      style: GoogleFonts.roboto()
                          .copyWith(color: Colors.white, fontSize: 18),
                    ),
                    margin: EdgeInsets.fromLTRB(10, 30, 10, 10),
                  ),
                  StreamBuilder<ApiResponse<List<Movie>>>(
                    stream: _bloc.upcomingmovieListStream,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        switch (snapshot.data.status) {
                          case Status.COMPLETED:
                            {
                              return Container(
                                height: 160,
                                margin: EdgeInsets.only(bottom: 20),
                                child: _buildMovieList(snapshot.data.data),
                              );
                            }
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
              )
            ],
          ),
        ),
      ),
    );
  }

  _buildMovieList(List<Movie> res) {
    return new ListView.builder(
        itemCount: res.length,
        shrinkWrap: true,
        physics: ClampingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext ctxt, int index) {
          if (res[index].posterPath != null)
            return ListItem(
                path: "https://image.tmdb.org/t/p/w500" +
                    res[index].posterPath.toString());
          else
            return ListItem(path: placeholderUrl);
        });
  }

  int i = 0;

  _buildBottomNavigationBar() {
    return Drawer(
      child: Container(
        color: Colors.black,
        child: Column(
          children: <Widget>[
            Container(
              height: 40,
              child: DrawerHeader(
                child: Text(
                  "Hello, Guest",
                  style: GoogleFonts.robotoMono()
                      .copyWith(color: Colors.white, fontSize: 20),
                ),
                padding: EdgeInsets.only(left: 10),
                margin: EdgeInsets.all(2),
              ),
            ),
            ListTile(
              title: Text(
                'Home',
                style: GoogleFonts.roboto()
                    .copyWith(color: Colors.white, fontSize: 16),
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text(
                'Search',
                style: GoogleFonts.roboto()
                    .copyWith(color: Colors.white, fontSize: 16),
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (context) => new SearchList()));
              },
            ),
            ListTile(
              title: Text(
                'Downloads',
                style: GoogleFonts.roboto()
                    .copyWith(color: Colors.white, fontSize: 16),
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (context) => new Downloads()));

              },
            ),
          ],
        ),
      ),
    );
  }

  static const String placeholderUrl =
      "https://cdn.pixabay.com/photo/2016/08/04/09/05/coming-soon-1568623__340.jpg";

  _buildAppBar() {
    return Container(
      height: 20,
      transform: Matrix4.translationValues(-20, 0, 0),
      color: primary,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.max,
        children: [
          Text(
            "Tv Shows",
            style: GoogleFonts.robotoMono()
                .copyWith(color: Colors.white, fontSize: 16),
          ),
          Text(
            "Movies",
            style: GoogleFonts.robotoMono()
                .copyWith(color: Colors.white, fontSize: 16),
          ),
          Text(
            "My List",
            style: GoogleFonts.robotoMono()
                .copyWith(color: Colors.white, fontSize: 16),
          ),
        ],
      ),
    );
  }
}
