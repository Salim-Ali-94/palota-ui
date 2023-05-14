import 'package:flutter/material.dart';
import 'package:flutter_spotify_africa_assessment/colors.dart';


class SectionDivier extends StatelessWidget {

  const SectionDivier({ super.key });

  @override
  Widget build(BuildContext context) {

    return Container(height: 4,
                     decoration: BoxDecoration(borderRadius: BorderRadius.circular(50),
                                               gradient: LinearGradient(colors: [ AppColors.blue,
                                                                                  AppColors.cyan, 
                                                                                  AppColors.green, ], 
                                                                        begin: Alignment.centerLeft, 
                                                                        end: Alignment.centerRight, ), ), );

  }

}