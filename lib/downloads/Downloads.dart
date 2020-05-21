import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Downloads extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: Key("1"),
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text("Downloads",style: GoogleFonts.roboto().copyWith(color: Colors.white,fontSize: 18),),
      ),
      body: Center(
          child: Text("Download list is empty",style: GoogleFonts.robotoMono().copyWith(color: Colors.white,fontSize: 16),)
      ),
    );
  }

}