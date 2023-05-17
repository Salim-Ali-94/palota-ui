import 'package:flutter/material.dart';
import 'package:flutter_spotify_africa_assessment/utility.dart';


class TracklistRow extends StatelessWidget {

  Map<String, Future<String>> track;

  TracklistRow({ super.key,
                 required this.track, });

  @override
  Widget build(BuildContext context) {

    return Container(height: 72, 
                     child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, 
                                children: [Container(child: Row(children: [FutureBuilder<String>(future: track["image"],
                                                                                                 builder: (context, snapshot) => imageBuilder(context, snapshot, 8.0, width: 64.0, height: 64.0), ),
                                                
                                           const SizedBox(width: 10),

                                           Column(crossAxisAlignment : CrossAxisAlignment.start, 
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [Container(constraints: const BoxConstraints(maxWidth: 200), 
                                                                       child: FutureBuilder<String>(future: track["song"],
                                                                       builder: (context, snapshot) => textBuilder(context, snapshot, 12.0, bold: true ), ), ), 
                                
                                                             Container(constraints: const BoxConstraints(maxWidth: 200), 
                                                                       child: FutureBuilder<String>(future: track["artists"],
                                                                                                    builder: (context, snapshot) => textBuilder(context, snapshot, 12.0), ), ), ], ), ], ), ), 

                                           FutureBuilder<String>(future: track["duration"],
                                                                 builder: (context, snapshot) => textBuilder(context, snapshot, 12.0), ), ], ), );

  }

}