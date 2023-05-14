import 'package:flutter/material.dart';
import 'package:flutter_spotify_africa_assessment/colors.dart';
import 'package:flutter_spotify_africa_assessment/routes.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_spotify_africa_assessment/features/spotify/presentation/components/header.dart';


// TODO: fetch and populate playlist info and allow for click-through to detail
// Feel free to change this to a stateful widget if necessary
class SpotifyCategory extends StatefulWidget {
  final String categoryId;

  const SpotifyCategory({
    Key? key,
    required this.categoryId,
  }) : super(key: key);

  @override
  State<SpotifyCategory> createState() => _SpotifyCategoryState();

}

class _SpotifyCategoryState extends State<SpotifyCategory> {

  String spotifyApiKey = dotenv.get('SPOTIFY_API_KEY', fallback: '');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Afro'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline),
            onPressed: () => Navigator.of(context).pushNamed(AppRoutes.about),
          ),
        ],
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: <Color>[
                AppColors.blue,
                AppColors.cyan,
                AppColors.green,
              ],
            ),
          ),
        ),
      ),

      body: SingleChildScrollView(physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                                  child: Container(padding: EdgeInsets.symmetric(vertical: 32), 
                                                   child: Column(children: [Row(mainAxisAlignment: MainAxisAlignment.end,
                                                                                children: [Header(image: "assets/images/avatar.png",
                                                                                                  category: 'Afro'), ], ), ], ), ), ),

    );
  }
}
