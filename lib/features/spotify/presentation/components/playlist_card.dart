import "package:flutter/material.dart";
import 'package:flutter_spotify_africa_assessment/colors.dart';


class PlaylistCard extends StatelessWidget {

  late Future<String>? image;
  late Future<String>? title;
  
  PlaylistCard({ super.key,
                 required this.image,
                 required this.title });

  Widget imageBuilder(context, snapshot) {

    if (snapshot.connectionState == ConnectionState.done) {

      final imageUrl = snapshot.data;
      return ClipRRect(borderRadius: BorderRadius.circular(8), 
                       child: Image.network(imageUrl!));

    } else {

      return Center(child: CircularProgressIndicator());

    }

  }

  Widget textBuilder(context, snapshot) {

    if (snapshot.connectionState == ConnectionState.done) {

      final categoryName = snapshot.data;

      return Text(categoryName,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 12,
                                   fontWeight: FontWeight.bold, ), );

    } else {

      return CircularProgressIndicator();

    }

  }

  @override
  Widget build(BuildContext context) {

    return Container(
                     //  width: 163, 
                     //  height: 187,
                     padding: EdgeInsets.all(4),
                     decoration: BoxDecoration(color: AppColors.grey,
                                               borderRadius: BorderRadius.circular(12)), 
                     child: Column(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                   crossAxisAlignment: CrossAxisAlignment.start,
                                   children: [FutureBuilder<String>(future: image,
                                                                    builder: (context, snapshot) => imageBuilder(context, snapshot), ), 
                                                                    
                                              FutureBuilder<String>(future: title,
                                                                    builder: (context, snapshot) => textBuilder(context, snapshot), ), ], ), );

  }

}