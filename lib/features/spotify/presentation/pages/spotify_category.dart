import 'package:flutter/material.dart';
import 'package:flutter_spotify_africa_assessment/colors.dart';
import 'package:flutter_spotify_africa_assessment/routes.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_spotify_africa_assessment/features/spotify/presentation/components/header.dart';
import 'package:flutter_spotify_africa_assessment/features/spotify/presentation/components/grid_section.dart';
import "package:http/http.dart" as http;
import "dart:convert";


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
  String base = "https://palota-jobs-africa-spotify-fa.azurewebsites.net/api/browse/categories/afro";

  Future<String> fetchImage() async {

    // String endpoint= "$base";
    // var response = await http.get(Uri.parse(endpoint));

    final response = await http.get(Uri.parse(base), 
                                    headers: { 'x-functions-key': spotifyApiKey, }, );

    if (response.statusCode == 200) {

      final data = response.body;
      String img = jsonDecode(response.body.toString())["icons"][0]["url"];
      return img;

    } else {

      print('Request failed with status: ${response.statusCode}');
      return "";

    }

    return "";

  }

  Future<String> fetchCategory() async {

    // String endpoint= "$base";
    // var response = await http.get(Uri.parse(endpoint));

    final response = await http.get(Uri.parse(base), 
                                    headers: { 'x-functions-key': spotifyApiKey, }, );

    if (response.statusCode == 200) {

      final data = response.body;
      String category = jsonDecode(response.body.toString())["name"];
      return category;

    } else {

      print('Request failed with status: ${response.statusCode}');
      return "";

    }

    return "";

  }

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
                                  child: Container(padding: EdgeInsets.only(top: 32), 
                                                  //  color: AppColors.black,
                                                   child: Column(children: [Row(mainAxisAlignment: MainAxisAlignment.end,
                                                                                children: [Header(image: fetchImage(),
                                                                                                  category: fetchCategory()), ], ), 
                                                                                                  
                                                                            SizedBox(height: 32),
                                                                            
                                                                            GridSection(),], ), ), ),

    );
  }
}
