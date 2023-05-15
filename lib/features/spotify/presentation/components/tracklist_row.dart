import 'package:flutter/material.dart';
import 'package:flutter_spotify_africa_assessment/colors.dart';
import 'package:flutter_spotify_africa_assessment/utility.dart';


class TracklistRow extends StatelessWidget {

  Map<String, Future<String>> track;
  // List<List<Future<String>>> artists;
  // List<Future<String>> artists;
  Future<String> artists;

  TracklistRow({ super.key,
                 required this.track,
                 required this.artists });

  @override
  Widget build(BuildContext context) {

    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, 
               children: [Container(child: Row(children: [FutureBuilder<String>(future: this.track["image"],
                                                builder: (context, snapshot) => imageBuilder(context, snapshot, 8.0), ),
                                                
                                                          SizedBox(width: 10),

                                                        Column(crossAxisAlignment : CrossAxisAlignment.start, 
                                                               children: [Container(constraints: BoxConstraints(maxWidth: 200), child: FutureBuilder<String>(future: this.track["song"],
                                                // builder: (context, snapshot) => textBuilder(context, snapshot, 12.0, bold: true ), ), FutureBuilder<String>(future: this.artists[0][0],
                                                // builder: (context, snapshot) => textBuilder(context, snapshot, 12.0, bold: true ), ), FutureBuilder<String>(future: Future.value(this.artists.join(', ')),
                                                builder: (context, snapshot) => textBuilder(context, snapshot, 12.0, bold: true ), )), 
                                                
                                                Container(constraints: BoxConstraints(maxWidth: 200), child: FutureBuilder<String>(future: this.artists,
                                                // builder: (context, snapshot) => textBuilder(context, snapshot, 12.0, bold: true ), ), FutureBuilder<String>(future: this.artists[0],
                                                builder: (context, snapshot) => textBuilder(context, snapshot, 12.0), )), ], ), ], ), ), 

                          FutureBuilder<String>(future: this.track["duration"],
                                                builder: (context, snapshot) => textBuilder(context, snapshot, 12.0), ),
                                                
                                                ]);

  }

}