import 'package:flutter/material.dart';
import 'package:flutter_spotify_africa_assessment/colors.dart';
import 'package:flutter_spotify_africa_assessment/utility.dart';


class ArtistCard extends StatelessWidget {

  late Future<String>? image;
  late Future<String>? name;

  ArtistCard({ super.key,
               required this.image,
               required this.name });

  @override
  Widget build(BuildContext context) {

    return Container(
      height: 143,
                     width: 120,
                     child: Column(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                   children: [FutureBuilder<String>(future: this.image,
                                                                                     builder: (context, snapshot) => imageBuilder(context, snapshot, 32.0, width: 120.0, height: 120.0), ), 
                                              // SizedBox(height: 8),
                                              
                                              FutureBuilder<String>(future: name,
                                                                  builder: (context, snapshot) => textBuilder(context, snapshot, 12.0), ), ], ), );

  }

}