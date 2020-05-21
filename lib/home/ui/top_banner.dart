import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TopBanner extends StatelessWidget {
  String path;
  String title = "";

  TopBanner({@required this.path, this.title,});

  @override
  Widget build(BuildContext context) {
    if (title == null) title = "";
    return Container(
      margin: EdgeInsets.fromLTRB(10, 30, 10, 0),
      width: double.maxFinite,
      height: 250,
      decoration: ShapeDecoration(
        color: Colors.black,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(6))),
      ),
      child: Stack(
        alignment: Alignment.center,
        fit: StackFit.expand,
        children: <Widget>[
          Material(
            type: MaterialType.card,
            elevation: 12,
            borderRadius:  BorderRadius.all(Radius.circular(6)),
            shadowColor: Colors.grey.withOpacity(0.8),
            color: Colors.black,
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(6)),
              child: CachedNetworkImage(
                placeholder: (context,des) {
                  return Image.asset("assets/placeholder.jpg",fit: BoxFit.fill,);
                },
                errorWidget: (context,des,err) {
                  return Image.asset("assets/placeholder.jpg",fit: BoxFit.fill,);
                },
                imageUrl: path,
                fit: BoxFit.fill,
              ),
            ),
          ),
          Positioned(
            bottom: 0.0,
            left: 0.0,
            right: 0.0,
            height: 40,
            child: Container(
              alignment: Alignment.bottomCenter,
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
                  Colors.black.withOpacity(0.6),
                  Colors.black.withOpacity(0.4),
                  Colors.black.withOpacity(0.2)
                ], begin: Alignment.bottomCenter, end: Alignment.topCenter),
                shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(6),bottomRight: Radius.circular(6))
              ),
            ),
          ),
          Positioned(
            bottom: 0.0,
            left: 0.0,
            right: 0.0,
            height: 40,
            child: Container(
              alignment: Alignment.bottomCenter,
              padding: EdgeInsets.only(left: 12,bottom: 4),
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: GoogleFonts.artifika()
                    .copyWith(color: Colors.white, fontSize: 14),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
