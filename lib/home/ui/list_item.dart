import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ListItem extends StatelessWidget {
 String path;
 double height;

  ListItem({@required this.path,this.height = 160 });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: height,
      margin: EdgeInsets.only(left: 10),
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
          borderRadius: BorderRadius.all(Radius.circular(6))
      ),
      child: Card(
        shape: RoundedRectangleBorder( borderRadius: BorderRadius.all(Radius.circular(6))),
        color:Colors.white.withOpacity(0.15),
        child: InkWell(
          onTap: (){},
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
          ),),
        ),
      ),
    );
  }

}