import 'package:flutter/material.dart';
import 'package:flutter_spotify_africa_assessment/colors.dart';
import 'package:flutter_spotify_africa_assessment/routes.dart';
import 'package:flutter_spotify_africa_assessment/constants.dart';
import 'package:flutter_spotify_africa_assessment/features/spotify/presentation/components/header.dart';
import 'package:flutter_spotify_africa_assessment/features/spotify/presentation/components/grid_section.dart';
import "package:http/http.dart" as http;
import "dart:convert";
import 'package:flutter_spotify_africa_assessment/providers/screen_provider.dart';
import 'package:provider/provider.dart';
import 'package:html/parser.dart' as htmlParser;

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

  List<Map<String, Future<String>>> playlists = [];
  ScrollController _scrollController = ScrollController();
  Future<String>? image;
  Future<String>? category;
  int page = 1;
  int limit = 6;
  bool loading = false;

  @override
  void initState() {

    super.initState();
    _scrollController.addListener(_scrollListener);
    fetchData();
    fetchPlaylist();

  }

  Future<void> fetchData() async {

    String endpoint = "$spotifyBaseUrl/browse/categories/${widget.categoryId}";
    final response = await http.get(Uri.parse(endpoint),
                                    headers: {'x-functions-key': spotifyApiKey}, );

    if (response.statusCode == 200) {

      final data = jsonDecode(response.body);
      String imageUrl = data["icons"][0]["url"];
      String categoryName = data["name"];

      setState(() {

        image = Future.value(imageUrl);
        category = Future.value(categoryName);

      });

    } else {

      print('Request failed with status: ${response.statusCode}');

    }

  }

  Future<void> fetchPlaylist() async {

    String endpoint = "$spotifyBaseUrl/browse/categories/${widget.categoryId}/playlists?limit=$limit&offset=$page";
    final response = await http.get(Uri.parse(endpoint),
                                    headers: {'x-functions-key': spotifyApiKey}, );

    if (response.statusCode == 200) {

      final data = jsonDecode(response.body);
      final array = data["playlists"]["items"];
      List<Map<String, Future<String>>> delta = [];

      for (int index = 0; index < array.length; index++) {

        String imageUrl = array[index]["images"][0]["url"];
        String title = array[index]["name"];
        String text = array[index]["description"];
        String description = htmlParser.parseFragment(text).text.toString();
        String identifier = array[index]["id"];

        delta.add({ "image": Future.value(imageUrl),
                    "title": Future.value(title), 
                    "identifier": Future.value(identifier), 
                    "description": Future.value(description), });

      }

      setState(() {

        playlists.addAll(delta);
        page += limit;

      });

    } else {

      print('Request failed with status: ${response.statusCode}');

    }

  }

  void _scrollListener() {

    if (loading == true) {

      return;

    }

    if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {

      setState(() {
        
        loading = true;

      });

      fetchPlaylist();

      setState(() {
        
        loading = false;

      });

    }

  }


  @override
  Widget build(BuildContext context) {
    var selectedPlaylist = context.watch<ScreenProvider>().selectedPlaylist;

    return Scaffold(
      backgroundColor: AppColors.black,
      appBar: AppBar(
        title: Text('${widget.categoryId[0].toUpperCase()}${widget.categoryId.substring(1).toLowerCase()}'),
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

      body: SingleChildScrollView(controller: _scrollController,
                                  physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                                  child: Container(padding: const EdgeInsets.symmetric(vertical: 32), 
                                                  //  color: AppColors.black,
                                                   child: Column(children: [Container(padding: const EdgeInsets.only(left: 24), 
                                                                                     child: Row(mainAxisAlignment: MainAxisAlignment.end,
                                                                                                children: [Header(image: image,
                                                                                                                  category: category), ], ), ), 
                                                                                                                  
                                                                            const SizedBox(height: 32),
                                                                          
                                                                            GridSection(playlists: playlists), ], ), ), ),

    );
  }
}