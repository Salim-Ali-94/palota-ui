import "package:flutter/material.dart";
import 'package:flutter_spotify_africa_assessment/colors.dart';


class Header extends StatelessWidget {

  late Future<String>? image;
  late Future<String>? category;

  Header({ super.key,
           required this.image,
           required this.category });

  Widget imageBuilder(context, snapshot) {

    if (snapshot.connectionState == ConnectionState.done) {

      final imageUrl = snapshot.data;
      return ClipRRect(borderRadius: BorderRadius.circular(8), 
                       child: Image.network(imageUrl!));

    } else {

      return CircularProgressIndicator();

    }

  }

  Widget textBuilder(context, snapshot) {

    if (snapshot.connectionState == ConnectionState.done) {

      final categoryName = snapshot.data;

      return RichText(text: TextSpan(style: DefaultTextStyle.of(context).style,
                                     children: <TextSpan>[TextSpan(text: categoryName,
                                                                   style: TextStyle(fontSize: 28,
                                                                                    fontWeight: FontWeight.bold, ), ),
                                                          
                                                          TextSpan(text: ' playlists',
                                                                   style: TextStyle(fontSize: 28, ), ), ], ), );

    } else {

      return Center(child: CircularProgressIndicator());

    }

  }

  @override
  Widget build(BuildContext context) {

    return Container(decoration: BoxDecoration(color: AppColors.grey,
                                               borderRadius: BorderRadius.only(topLeft: Radius.circular(12), 
                                                                               bottomLeft: Radius.circular(12), ), ),
                                                    
                     width: 366,
                     height: 72, 
                     padding: EdgeInsets.symmetric(horizontal: 4, 
                                                   vertical: 4),
                     
                     child: Row(children: [FutureBuilder<String>(future: image,
                                                                 builder: (context, snapshot) => imageBuilder(context, snapshot), ),

                                           SizedBox(width: 20),
                                            
                                           FutureBuilder<String>(future: category,
                                                                  builder: (context, snapshot) => textBuilder(context, snapshot), ), ], ), );

  }

}