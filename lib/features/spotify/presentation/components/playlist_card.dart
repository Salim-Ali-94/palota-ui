import "package:flutter/material.dart";
import 'package:flutter_spotify_africa_assessment/colors.dart';


class PlaylistCard extends StatelessWidget {

  const PlaylistCard({ super.key });

  @override
  Widget build(BuildContext context) {

    return Container(width: 163, 
                     height: 187,
                     decoration: BoxDecoration(color: AppColors.grey,
                                              borderRadius: BorderRadius.circular(12)), 
                     child: Column(children: [], ));

  }

}