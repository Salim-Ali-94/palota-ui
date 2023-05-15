import 'package:flutter/material.dart';
import 'package:flutter_spotify_africa_assessment/colors.dart';
import 'package:flutter_spotify_africa_assessment/utility.dart';


class TracklistRow extends StatelessWidget {

  Map<String, Future<String>> tracks;
  List<List<Future<String>>> artists;

  TracklistRow({ super.key,
                 required this.tracks,
                 required this.artists });

  @override
  Widget build(BuildContext context) {

    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, 
               children: [Container(child: Row(children: [FutureBuilder<String>(future: this.tracks["image"],
                                                builder: (context, snapshot) => imageBuilder(context, snapshot, 8.0), ),
                                                
                                                          SizedBox(width: 10),

                                                        Column(crossAxisAlignment : CrossAxisAlignment.start, 
                                                               children: [FutureBuilder<String>(future: this.tracks["song"],
                                                builder: (context, snapshot) => textBuilder(context, snapshot, 12.0), ), FutureBuilder<String>(future: this.artists[0][0],
                                                builder: (context, snapshot) => textBuilder(context, snapshot, 12.0), ),], ), ], ), ), 

                          FutureBuilder<String>(future: this.tracks["duration"],
                                                builder: (context, snapshot) => textBuilder(context, snapshot, 12.0), ),
                                                
                                                ]);

  }

}