import 'package:flutter/material.dart';
import 'package:flutter_spotify_africa_assessment/providers/screen_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_spotify_africa_assessment/colors.dart';
import 'package:flutter_spotify_africa_assessment/utility.dart';
import "package:flutter_spotify_africa_assessment/features/spotify/presentation/components/playlist_card.dart";


//TODO: complete this page - you may choose to change it to a stateful widget if necessary
class SpotifyPlaylist extends StatelessWidget {
  const SpotifyPlaylist({Key? key}) : super(key: key);

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

  @override
  Widget build(BuildContext context) {

    var selectedPlaylist = context.watch<ScreenProvider>().selectedPlaylist;

    return Scaffold(appBar: AppBar(backgroundColor: AppColors.black,
                                   elevation: 0), 
                    backgroundColor: AppColors.black,
                    body: SafeArea(child: Container(child: Column(children: [Container(padding: EdgeInsets.only(left: 48,
                                                                                                                right: 48,
                                                                                                                top: 16), 
                                                                                                                
                                                                                       child: PlaylistCard(playlist: selectedPlaylist,
                                                                                                           padding: 15,
                                                                                                           gap: 14,
                                                                                                           size: 22,
                                                                                                           innerRadius: 12,
                                                                                                          //  height: ,
                                                                                                           outerRadius: 24,), ), ], ), ), ), );

  }

}
