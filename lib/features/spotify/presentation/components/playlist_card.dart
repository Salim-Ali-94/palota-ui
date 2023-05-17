import "package:flutter/material.dart";
import 'package:flutter_spotify_africa_assessment/colors.dart';
import 'package:flutter_spotify_africa_assessment/routes.dart';
import 'package:flutter_spotify_africa_assessment/providers/screen_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_spotify_africa_assessment/utility.dart';


class PlaylistCard extends StatefulWidget {

  Map<String, Future<String>> playlist;
  late double gap;
  late double padding;
  late double innerRadius;
  late double outerRadius;
  late double size;
  late bool bold;
  
  PlaylistCard({ super.key,
                 required this.gap,
                 required this.padding,
                 required this.size,
                 required this.innerRadius,
                 required this.outerRadius,
                 required this.bold,
                 required this.playlist, });

  @override
  State<PlaylistCard> createState() => _PlaylistCardState();

}

class _PlaylistCardState extends State<PlaylistCard> {

  void pressHandler() {

    context.read<ScreenProvider>().setPlaylist(widget.playlist);
    Navigator.pushNamed(context, AppRoutes.spotifyPlaylist);

  }

  @override
  Widget build(BuildContext context) {

    return GestureDetector(onTap: () => pressHandler(), 
                           child: Container(padding: EdgeInsets.all(widget.padding),
                                            decoration: BoxDecoration(color: AppColors.grey,
                                            borderRadius: BorderRadius.circular(widget.outerRadius)), 

                                            child: Column(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [FutureBuilder<String>(future: widget.playlist["image"],
                                                                                           builder: (context, snapshot) => imageBuilder(context, snapshot, widget.innerRadius), ), 

                                                                     SizedBox(height: widget.gap),

                                                                     FutureBuilder<String>(future: widget.playlist["title"],
                                                                                           builder: (context, snapshot) => textBuilder(context, snapshot, widget.size, bold: widget.bold), ), ], ), ), );

  }

}