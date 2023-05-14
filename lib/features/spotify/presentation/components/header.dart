import "package:flutter/material.dart";
import 'package:flutter_spotify_africa_assessment/colors.dart';


class Header extends StatelessWidget {

  const Header({ super.key });

  @override
  Widget build(BuildContext context) {

    return Container(decoration: BoxDecoration(color: AppColors.grey,
                                               borderRadius: BorderRadius.only(topLeft: Radius.circular(12), 
                                                                               bottomLeft: Radius.circular(12), ), ),
                                                    
                     width: 366,
                     height: 72, 
                     padding: EdgeInsets.symmetric(horizontal: 4),
                     
                     child: Row(children: [Image.asset("assets/images/avatar.png"), 
                                           SizedBox(width: 20),
                                           RichText(text: TextSpan(style: DefaultTextStyle.of(context).style,
                                                                   children: <TextSpan>[
                                                                   TextSpan(text: 'Afro',
                                                                            style: TextStyle(fontSize: 28,
                                                                                             fontWeight: FontWeight.bold, ), ),
                                                                   TextSpan(text: ' playlists',
                                                                            style: TextStyle(fontSize: 28, ), ), ], ), ), ], ), );

  }

}