import 'package:flutter/material.dart';
import 'package:flutter_spotify_africa_assessment/colors.dart';
import 'package:flutter_spotify_africa_assessment/utility.dart';


class FollowersBanner extends StatelessWidget {
 
  Future<String>? followers;
  
  FollowersBanner({ super.key,
                    required this.followers });

  @override
  Widget build(BuildContext context) {

    return Container(height: 32,
                     padding: EdgeInsets.only(right: 16),
                     decoration: BoxDecoration(color: AppColors.grey,
                                               borderRadius: BorderRadius.only(topLeft: Radius.circular(12),
                                                                               bottomLeft: Radius.circular(12), ), ), 
                                                                               
                     child: Row(mainAxisAlignment: MainAxisAlignment.end,
                                children: [FutureBuilder<String>(future: this.followers,
                                                                 builder: (context, snapshot) => textBuilder(context, snapshot, 11.0), ),], ), );

  }

}