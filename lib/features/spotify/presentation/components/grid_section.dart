// import "package:flutter/material.dart";
// import "package:flutter_spotify_africa_assessment/features/spotify/presentation/components/playlist_card.dart";
// import "package:http/http.dart" as http;
// import "dart:convert";
// import 'package:flutter_dotenv/flutter_dotenv.dart';


// class GridSection extends StatefulWidget {

//   late ScrollController scroll;
//   late List<Map<String, Future<String>>> playlists;
  
//   GridSection({ super.key,
//                 required this.scroll,
//                 required this.playlists });

//   @override
//   State<GridSection> createState() => _GridSectionState();

// }

// class _GridSectionState extends State<GridSection> {

//   String spotifyApiKey = dotenv.get('SPOTIFY_API_KEY', fallback: '');
//   // String base = "https://palota-jobs-africa-spotify-fa.azurewebsites.net/api/browse";
//   // String base = "https://palota-jobs-africa-spotify-fa.azurewebsites.net/api/browse/categories/afro/playlists?limit=1";
//   // String base = "https://palota-jobs-africa-spotify-fa.azurewebsites.net/api/browse/categories/afro/playlists";
//   String base = "https://palota-jobs-africa-spotify-fa.azurewebsites.net/api/browse";
//   // Future<String>? image;
//   // Future<String>? title;
//   // List<Map<String, Future<String>>> playlists = [];



//   // ScrollController _scrollController = ScrollController();
//   // int page = 1;
//   // // int limit = 100;
//   // int limit = 6;



//   // @override
//   // void initState() {
//   //   super.initState();
//   //   _scrollController.addListener(_scrollListener);
//   // }


//   // @override
//   // void initState() {

//   //   super.initState();
//   //   _scrollController.addListener(_scrollListener);
//   //   fetchData();
//   //   // fetchData().then((data) {

//   //   //   setState(() {

//   //   //     playlists = data;

//   //   //   });

//   //   // });

//   // }




//   // void _scrollListener() {

//   //   if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
    
//   //     fetchData();

//   //     // fetchData().then((data) {

//   //     //   setState(() {

//   //     //     playlists = data;

//   //     //   });

//   //     // });

//   //   }

//   // }






//   // Future<List<Map<String, Future<String>>>> fetchData() async {

//   //   // String endpoint = "$base/categories/afro/playlists";
//   //   String endpoint = "$base/categories/afro/playlists?limit=5";
//   //   final response = await http.get(Uri.parse(endpoint), 
//   //                                   headers: { 'x-functions-key': spotifyApiKey, }, );

//   //   if (response.statusCode == 200) {

//   //     final data = response.body;
//   //     List<Map<String, Future<String>>> playlist = [];
//   //     // String image = jsonDecode(data.toString())["playlists"]["items"][0]["images"][0]["url"];
//   //     // String title = jsonDecode(data.toString())["playlists"]["items"][0]["name"];
//   //     final array = jsonDecode(data.toString())["playlists"]["items"];

//   //     for (int index = 0; index < array.length; index++) {

//   //       String image = array[index]["images"][0]["url"];
//   //       String title = array[index]["name"];
//   //       playlist.add({ "image": Future.value(image), 
//   //                      "title": Future.value(title) });        

//   //     }

//   //     return playlist;

//   //   } else {

//   //     print('Request failed with status: ${response.statusCode}');
//   //     return [{ "image": Future.value(""), 
//   //               "title": Future.value("") }];

//   //   }

//   // }








// // Future<void> fetchData() async {
// //   String endpoint = "$base/categories/afro/playlists?limit=$limit&offset=$page";
// //   final response = await http.get(Uri.parse(endpoint),
// //       headers: {'x-functions-key': spotifyApiKey});

// //   if (response.statusCode == 200) {
// //     final data = response.body;
// //     final array = jsonDecode(data.toString())["playlists"]["items"];

// //     for (int index = 0; index < array.length; index++) {
// //       String image = array[index]["images"][0]["url"];
// //       String title = array[index]["name"];
// //       playlists.add({
// //         "image": Future.value(image),
// //         "title": Future.value(title)
// //       });
// //     }

// //     setState(() {
// //       page += limit;
// //     });
// //   } else {
// //     print('Request failed with status: ${response.statusCode}');
// //   }
// // }









//   // Future<void> fetchData() async {
//   //   String endpoint = "$base/categories/afro/playlists?limit=$limit&offset=$page";
//   //   final response = await http.get(Uri.parse(endpoint),
//   //       headers: {'x-functions-key': spotifyApiKey});

//   //   if (response.statusCode == 200) {
//   //     final data = response.body;
//   //     final array = jsonDecode(data.toString())["playlists"]["items"];

//   //     for (int index = 0; index < array.length; index++) {
//   //       String image = array[index]["images"][0]["url"];
//   //       String title = array[index]["name"];
//   //       playlists.add({
//   //         "image": Future.value(image),
//   //         "title": Future.value(title)
//   //       });
//   //     }


//   //     setState(() {
//   //       // Update the UI with the updated playlists
//   //       playlists = playlists;
//   //       // Increment the page number for the next batch of data
//   //       page++;
        
//   //     });
//   //   } else {
//   //     print('Request failed with status: ${response.statusCode}');
//   //   }
//   // }





//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       // width: 342,
//       padding: EdgeInsets.symmetric(horizontal: 24),
//       child: GridView.count(
//         controller: widget.scroll,
//         // controller: _scrollController,
//         crossAxisCount: 2,
//         crossAxisSpacing: 16,
//         mainAxisSpacing: 16,
//         shrinkWrap: true,
//         childAspectRatio: 163 / 187,
//         physics: NeverScrollableScrollPhysics(),
//         children: widget.playlists.map((playlist) {
//           return PlaylistCard(
//             image: playlist["image"],
//             title: playlist["title"],
//           );
//         }).toList(),
//       ),
//     );
//   }
// }


// //   @override
// //   Widget build(BuildContext context) {

// //     return Container(width: 342,
// //                      child: FutureBuilder<List<Map<String, Future<String>>>>(
// //         future: fetchData(),
// //         builder: (context, snapshot) {
// //           if (snapshot.connectionState == ConnectionState.waiting) {
// //             return Container(child: Center(child: CircularProgressIndicator()));
// //           } else if (snapshot.hasError) {
// //             return Text('Error: ${snapshot.error}');
// //           } else {
// //             return GridView.count(
// //               crossAxisCount: 2,
// //               crossAxisSpacing: 16,
// //               mainAxisSpacing: 16,
// //               shrinkWrap: true,
// //               childAspectRatio: 163 / 187,
// //               physics: NeverScrollableScrollPhysics(),
// //               children: snapshot.data!.map((playlist) {
// //                 return PlaylistCard(
// //                   image: playlist["image"],
// //                   title: playlist["title"],
// //                 );
// //               }).toList(),
// //             );
// //           }
// //         },
// //       ), );

// //   }

// // }




import "package:flutter/material.dart";
import "package:flutter_spotify_africa_assessment/features/spotify/presentation/components/playlist_card.dart";

class GridSection extends StatelessWidget {
  final ScrollController scroll;
  final List<Map<String, Future<String>>> playlists;

  const GridSection({
    Key? key,
    required this.scroll,
    required this.playlists,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24),
      child: GridView.count(
        // controller: scroll,
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        shrinkWrap: true,
        childAspectRatio: 163 / 187,
        physics: NeverScrollableScrollPhysics(),
        children: playlists.map((playlist) {
          return PlaylistCard(
            image: playlist["image"],
            title: playlist["title"],
          );
        }).toList(),
      ),
    );
  }
}
