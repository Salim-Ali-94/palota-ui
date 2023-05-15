// import 'package:flutter/material.dart';
// import 'package:flutter_spotify_africa_assessment/colors.dart';
// import 'package:flutter_spotify_africa_assessment/utility.dart';


// class TracklistRow extends StatelessWidget {

//   // Map<String, Future<String>> tracks;
//   // Map<String, dynamic> tracks;
//   Map<String, Future<dynamic>> tracks; 
  
//   TracklistRow({ super.key,
//                  required this.tracks });

//   @override
//   Widget build(BuildContext context) {

//     return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, 
//                children: [FutureBuilder<String>(future: this.tracks["image"],
//                                                 builder: (context, AsyncSnapshot<dynamic> snapshot) => imageBuilder(context, snapshot, 8.0), ), 
//                           Text("TRACKS")]);

//   }

// }



























import 'package:flutter/material.dart';
import 'package:flutter_spotify_africa_assessment/colors.dart';
import 'package:flutter_spotify_africa_assessment/utility.dart';


class TracklistRow extends StatelessWidget {

  // Map<String, Future<String>> tracks;
  // Map<String, dynamic> tracks;

  // Map<String, Future<dynamic>> tracks; 

  Map<String, Future<String>> tracks;

  // List<Future<String>> artists;
  // List<Future<String>> artists;
  List<List<Future<String>>> artists;

  // Map<String, Future<String?>> tracks;
  // Map<String, Future<dynamic>?> tracks;

  TracklistRow({ super.key,
                 required this.tracks,
                 required this.artists });

  @override
  Widget build(BuildContext context) {

    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, 
               children: [FutureBuilder<String>(future: this.artists[0][0],
                                                // builder: (context, snapshot) => imageBuilder(context, snapshot, 12.0), ), 
                                                builder: (context, snapshot) => textBuilder(context, snapshot, 8.0), ), 
                          FutureBuilder<String>(future: this.tracks["image"],
                                                builder: (context, snapshot) => imageBuilder(context, snapshot, 12.0), ), 
                                                // builder: (context, snapshot) => textBuilder(context, snapshot, 8.0), ),
                                                ]);

  }

}