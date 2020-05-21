import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:netflix_sample_app/home/bloc/MovieBloc.dart';
import 'package:netflix_sample_app/home/model/MovieResponse.dart';
import 'package:netflix_sample_app/home/ui/list_item.dart';
import 'package:netflix_sample_app/network/ApiResponse.dart';

class SearchList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SearchListState();
  }
}

class _SearchListState extends State<SearchList> {
  MovieBloc _bloc;

  @override
  void initState() {
    _bloc = MovieBloc();
    _refresh();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          "Results",
          style:
              GoogleFonts.roboto().copyWith(color: Colors.white, fontSize: 18),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                child: TextFormField(
                  decoration: InputDecoration(
                      hintText: "Search",
                      icon: Icon(
                        Icons.search,
                        color: Colors.grey,
                      ),),
                ),
                height: 40,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(6)),
                    color: Colors.white),
                margin: EdgeInsets.only(left: 10, right: 10),
                padding: EdgeInsets.only(left: 10),
              ),
              StreamBuilder<ApiResponse<List<Movie>>>(
                stream: _bloc.topRatedmovieListStream,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    switch (snapshot.data.status) {
                      case Status.COMPLETED:
                        return Container(
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
        scrollDirection: Axis.vertical,
        itemBuilder: (BuildContext ctxt, int index) {
          if (res[index].posterPath != null)
            return Container(
              margin: EdgeInsets.fromLTRB(10, 20, 20, 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  ListItem(
                    path: "https://image.tmdb.org/t/p/w500" +
                        res[index].posterPath.toString(),
                    height: 80,
                  ),
                  Container(
                    width: 200,
                    child: Text(
                      res[index].title,
                      style: GoogleFonts.robotoMono()
                          .copyWith(color: Colors.white, fontSize: 16),
                    ),
                    margin: EdgeInsets.only(left: 10),
                  )
                ],
              ),
            );
          else
            return ListItem(
              path: placeholderUrl,
              height: 80,
            );
        });
  }

  static const String placeholderUrl =
      "https://cdn.pixabay.com/photo/2016/08/04/09/05/coming-soon-1568623__340.jpg";

  void _refresh() {
    _bloc.fetchTopRatedMovieList();
  }
}
