import "package:flutter/material.dart";
import 'package:flutter_spotify_africa_assessment/colors.dart';
import 'package:flutter_spotify_africa_assessment/routes.dart';
import 'package:flutter_spotify_africa_assessment/providers/screen_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_spotify_africa_assessment/utility.dart';


class PlaylistCard extends StatefulWidget {

  Map<String, Future<String>> playlist;
  // late int index;
  late double gap;
  late double padding;
  late double innerRadius;
  late double outerRadius;
  late double size;
  
  PlaylistCard({ super.key,
                //  required this.image,
                 required this.gap,
                 required this.padding,
                 required this.size,
                 required this.innerRadius,
                 required this.outerRadius,
                 required this.playlist, });

  @override
  State<PlaylistCard> createState() => _PlaylistCardState();

}


class _PlaylistCardState extends State<PlaylistCard> {

  // late Future<String>? image;
  // late Future<String>? title;
  // Map<String, Future<String>> playlist;
  // // late int index;
  
  // PlaylistCard({ super.key,
  //               //  required this.image,
  //                required this.playlist, });
  //               //  required this.index, });
  //               //  required this.title });

  // Widget imageBuilder(context, snapshot) {

  //   if (snapshot.connectionState == ConnectionState.done) {

  //     final imageUrl = snapshot.data;
  //     // return ClipRRect(borderRadius: BorderRadius.circular(8), 
  //     return ClipRRect(borderRadius: BorderRadius.circular(widget.innerRadius), 
  //                      child: Image.network(imageUrl!));

  //   } else {

  //     return Center(child: CircularProgressIndicator());

  //   }

  // }

  // Widget textBuilder(context, snapshot) {

  //   if (snapshot.connectionState == ConnectionState.done) {

  //     final categoryName = snapshot.data;

  //     return Text(categoryName,
  //                 maxLines: 1,
  //                 overflow: TextOverflow.ellipsis,
  //                 style: TextStyle(fontSize: 12,
  //                                  fontWeight: FontWeight.bold, ), );

  //   } else {

  //     return CircularProgressIndicator();

  //   }

  // }

  void pressHandler() {

    context.read<ScreenProvider>().setPlaylist(widget.playlist);
    Navigator.pushNamed(context, AppRoutes.spotifyPlaylist);

  }

  @override
  Widget build(BuildContext context) {

    return GestureDetector(onTap: () => pressHandler(), 
                           child: Container(
                     //  width: 163, 
                     //  width: 163, 
                      // height: 336,
                    //  padding: EdgeInsets.all(4),
                     padding: EdgeInsets.all(widget.padding),
                     decoration: BoxDecoration(color: AppColors.grey,
                                              //  borderRadius: BorderRadius.circular(12)), 
                                               borderRadius: BorderRadius.circular(widget.outerRadius)), 
                     child: Column(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                   crossAxisAlignment: CrossAxisAlignment.start,
                                   children: [FutureBuilder<String>(future: widget.playlist["image"],
                                                                    builder: (context, snapshot) => imageBuilder(context, snapshot, widget.innerRadius), ), 

                                              SizedBox(height: widget.gap),

                                              FutureBuilder<String>(future: widget.playlist["title"],
                                                                    builder: (context, snapshot) => textBuilder(context, snapshot, widget.size), ), ], ), ));

  }

}