import 'package:flutter/material.dart';
import 'package:flutter_spotify_africa_assessment/colors.dart';
import 'package:flutter_spotify_africa_assessment/routes.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_spotify_africa_assessment/features/spotify/presentation/components/header.dart';
import 'package:flutter_spotify_africa_assessment/features/spotify/presentation/components/grid_section.dart';
import "package:http/http.dart" as http;
import "dart:convert";

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
  String base = "https://palota-jobs-africa-spotify-fa.azurewebsites.net/api/browse";
  Future<String>? image;
  Future<String>? category;

  ScrollController _scrollController = ScrollController();
  int page = 1;
  int limit = 6;
  List<Map<String, Future<String>>> playlists = [];

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
    fetchData();
    fetchPlaylist();
  }

  Future<void> fetchData() async {
    String endpoint = "$base/categories/${widget.categoryId}";
    final response = await http.get(
      Uri.parse(endpoint),
      headers: {'x-functions-key': spotifyApiKey},
    );

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
    String endpoint = "$base/categories/${widget.categoryId}/playlists?limit=$limit&offset=$page";
    final response = await http.get(
      Uri.parse(endpoint),
      headers: {'x-functions-key': spotifyApiKey},
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final array = data["playlists"]["items"];

      setState(() {
        page += limit;

        for (int index = 0; index < array.length; index++) {
          String imageUrl = array[index]["images"][0]["url"];
          String title = array[index]["name"];

          playlists.add({
            "image": Future.value(imageUrl),
            "title": Future.value(title),
          });
        }
      });
    } else {
      print('Request failed with status: ${response.statusCode}');
    }
  }

  void _scrollListener() {
    // print("CALLED");
    if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
      fetchPlaylist();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
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
              // begin: Alignment.top,
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
      body: SingleChildScrollView(
        controller: _scrollController,
        physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 32),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Header(image: image, category: category),
                ],
              ),
              SizedBox(height: 32),GridSection(scroll: _scrollController, playlists: playlists),
              
            ],
          ),
        ),
      ),
    );
  }
}


































// import 'package:flutter/material.dart';
// import 'package:flutter_spotify_africa_assessment/colors.dart';
// import 'package:flutter_spotify_africa_assessment/routes.dart';
// import 'package:flutter_dotenv/flutter_dotenv.dart';
// import 'package:flutter_spotify_africa_assessment/features/spotify/presentation/components/header.dart';
// import 'package:flutter_spotify_africa_assessment/features/spotify/presentation/components/grid_section.dart';
// import "package:http/http.dart" as http;
// import "dart:convert";


// // TODO: fetch and populate playlist info and allow for click-through to detail
// // Feel free to change this to a stateful widget if necessary
// class SpotifyCategory extends StatefulWidget {
//   final String categoryId;

//   const SpotifyCategory({
//     Key? key,
//     required this.categoryId,
//   }) : super(key: key);

//   @override
//   State<SpotifyCategory> createState() => _SpotifyCategoryState();

// }

// class _SpotifyCategoryState extends State<SpotifyCategory> {

//   String spotifyApiKey = dotenv.get('SPOTIFY_API_KEY', fallback: '');
//   String base = "https://palota-jobs-africa-spotify-fa.azurewebsites.net/api/browse";
//   Future<String>? image;
//   Future<String>? category;







//   ScrollController _scrollController = ScrollController();
//   int page = 1;
//   // int limit = 100;
//   int limit = 6;
//   List<Map<String, Future<String>>> playlists = [];








//   // https://palota-jobs-africa-spotify-fa.azurewebsites.net/api/browse/categories/afro/playlists?limit=1

//   @override
//   void initState() {

//     super.initState();
//     _scrollController.addListener(_scrollListener);
//     fetchPlaylist();

//     fetchData().then((data) {

//       setState(() {

//         image = Future.value(data["image"]);
//         category = Future.value(data["category"]);

//       });

//     });

//   }

//   Future<Map<String, String>> fetchData() async {

//     String endpoint = "$base/categories/${widget.categoryId}";
//     final response = await http.get(Uri.parse(endpoint), 
//                                     headers: { 'x-functions-key': spotifyApiKey, }, );

//     if (response.statusCode == 200) {

//       final data = response.body;
//       String image = jsonDecode(data.toString())["icons"][0]["url"];
//       String category = jsonDecode(data.toString())["name"];
//       return { "image": image, "category": category };

//     } else {

//       print('Request failed with status: ${response.statusCode}');
//       return { "image": "", "category": "" };

//     }

//   }











//   void _scrollListener() {

//     if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
    
//       setState(() {
//         page += limit;
//         fetchPlaylist();
//       });

//       // fetchData().then((data) {

//       //   setState(() {

//       //     playlists = data;

//       //   });

//       // });

//     }

//   }




// Future<void> fetchPlaylist() async {
//   String endpoint = "$base/categories/afro/playlists?limit=$limit&offset=$page";
//   final response = await http.get(Uri.parse(endpoint),
//       headers: {'x-functions-key': spotifyApiKey});

//   if (response.statusCode == 200) {
//     final data = response.body;
//     final array = jsonDecode(data.toString())["playlists"]["items"];

//     // for (int index = 0; index < array.length; index++) {
//     //   String image = array[index]["images"][0]["url"];
//     //   String title = array[index]["name"];
//     //   playlists.add({
//     //     "image": Future.value(image),
//     //     "title": Future.value(title)
//     //   });
//     // }

//     setState(() {

//       for (int index = 0; index < array.length; index++) {
//         String image = array[index]["images"][0]["url"];
//         String title = array[index]["name"];
//         playlists.add({
//           "image": Future.value(image),
//           "title": Future.value(title)
//         });
//       }

//     });
//       // page += limit;
//   } else {
//     print('Request failed with status: ${response.statusCode}');
//   }
// }











//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.black,
//       appBar: AppBar(
//         title: const Text('Afro'),
//         centerTitle: true,
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.info_outline),
//             onPressed: () => Navigator.of(context).pushNamed(AppRoutes.about),
//           ),
//         ],
//         flexibleSpace: Container(
//           decoration: const BoxDecoration(
//             gradient: LinearGradient(
//               begin: Alignment.topLeft,
//               end: Alignment.bottomRight,
//               colors: <Color>[
//                 AppColors.blue,
//                 AppColors.cyan,
//                 AppColors.green,
//               ],
//             ),
//           ),
//         ),
//       ),

//       body: SingleChildScrollView(physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
//                                   child: Container(padding: EdgeInsets.symmetric(vertical: 32), 
//                                                   //  color: AppColors.black,
//                                                    child: Column(children: [Row(mainAxisAlignment: MainAxisAlignment.end,
//                                                                                 children: [Header(image: image,
//                                                                                                   category: category), ], ), 
                                                                                                  
//                                                                                            SizedBox(height: 32),
                                                                                          
//                                                                                            NotificationListener<ScrollNotification>(
//                 onNotification: (notification) {
//                   if (notification is ScrollEndNotification &&
//                       _scrollController.position.extentAfter == 0) {
//                         page += limit;
//                     fetchPlaylist();
//                   }
//                   return false;
//                 },
//                 child: GridSection(scroll: _scrollController,
//                                     playlists: playlists), )], ), ), ),

//     );
//   }
// }
