import 'package:flutter/material.dart';
import 'package:flutter_spotify_africa_assessment/colors.dart';
import 'package:flutter_spotify_africa_assessment/utility.dart';


class Header extends StatelessWidget {

  late Future<String>? image;
  late Future<String>? category;

  Header({ super.key,
           required this.image,
           required this.category });

  @override
  Widget build(BuildContext context) {

    return Expanded(child: Container(decoration: BoxDecoration(color: AppColors.grey,
                                                              boxShadow: [BoxShadow(color: AppColors.grey.withOpacity(0.2), // Shadow color
                                                                                    blurRadius: 6, // Spread radius
                                                                                    offset: const Offset(4, 4), ), ],

                                                              borderRadius: const BorderRadius.only(topLeft: Radius.circular(12), 
                                                                                                    bottomLeft: Radius.circular(12), ), ),
                                                    
                    // margin: EdgeInsets.only(left: 24),
                     height: 72, 
                     padding: const EdgeInsets.symmetric(horizontal: 4, 
                                                         vertical: 4),
                     
                     child: Row(children: [FutureBuilder<String>(future: image,
                                                                 builder: (context, snapshot) => imageBuilder(context, snapshot, 8.0), ),

                                           const SizedBox(width: 20),
                                            
                                           FutureBuilder<String>(future: category,
                                                                 builder: (context, snapshot) => textBuilder(context, snapshot, 28.0, rich: true), ), ], ), ), );

  }

}