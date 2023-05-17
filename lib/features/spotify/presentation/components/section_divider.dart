import 'package:flutter/material.dart';
import 'package:flutter_spotify_africa_assessment/colors.dart';


class SectionDivider extends StatelessWidget {

  const SectionDivider({ super.key });

  @override
  Widget build(BuildContext context) {

    return Container(height: 4,
                     decoration: BoxDecoration(borderRadius: BorderRadius.circular(50),
                                               gradient: const LinearGradient(colors: [ AppColors.blue,
                                                                                        AppColors.cyan, 
                                                                                        AppColors.green, ], 
                                                                              begin: Alignment.centerLeft, 
                                                                              end: Alignment.centerRight, ), ), );

  }

}