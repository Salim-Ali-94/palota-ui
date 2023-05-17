import 'package:flutter/material.dart';
import 'package:flutter_spotify_africa_assessment/colors.dart';


class FeaturedBanner extends StatelessWidget {

  const FeaturedBanner({ super.key });

  @override
  Widget build(BuildContext context) {

    return Container(height: 56,
                     padding: const EdgeInsets.symmetric(horizontal: 16),
                     decoration: BoxDecoration(color: AppColors.grey,
                                               borderRadius: const BorderRadius.only(topRight: Radius.circular(12),
                                                                                     bottomRight: Radius.circular(12), ),
                                                                                
                                               boxShadow: [BoxShadow(color: AppColors.grey.withOpacity(0.2), // Shadow color
                                                                                    blurRadius: 6, // Spread radius
                                                                                    offset: const Offset(-4, 4), ), ], ), 
                                                                               
                     child: Row(children: const [Expanded(child: Text("Featured Artists", 
                                                                      maxLines: 1,
                                                                      overflow: TextOverflow.ellipsis,
                                                                      style: TextStyle(fontSize: 22), ), ), ], ), );

  }

}