import 'package:flutter/material.dart';
import 'package:flutter_spotify_africa_assessment/providers/screen_context.dart';
import 'package:provider/provider.dart';
import 'package:flutter_spotify_africa_assessment/colors.dart';
import 'package:flutter_spotify_africa_assessment/utility.dart';


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

    return Scaffold(backgroundColor: AppColors.black,
                    body: SafeArea(child: Container(child: Column(children: [FutureBuilder<String>(future: selectedPlaylist["title"],
                                                                                                   builder: (context, snapshot) => textBuilder(context, snapshot), ), ], ), ), ), );

  }

}
