import 'package:flutter/material.dart';
import 'package:flutter_spotify_africa_assessment/features/spotify/presentation/components/tracklist_row.dart';
import 'package:flutter_spotify_africa_assessment/providers/screen_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_spotify_africa_assessment/colors.dart';
import 'package:flutter_spotify_africa_assessment/utility.dart';
import 'package:flutter_spotify_africa_assessment/features/spotify/presentation/components/playlist_card.dart';
import 'package:flutter_spotify_africa_assessment/features/spotify/presentation/components/followers_banner.dart';
import 'package:flutter_spotify_africa_assessment/features/spotify/presentation/components/section_divider.dart';
import 'package:flutter_spotify_africa_assessment/features/spotify/presentation/components/tracklist_row.dart';
import 'package:flutter_spotify_africa_assessment/features/spotify/presentation/components/featured_banner.dart';
import 'package:flutter_spotify_africa_assessment/features/spotify/presentation/components/artist_card.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';


class SpotifyPlaylist extends StatefulWidget {

  SpotifyPlaylist({Key? key}) : super(key: key);

  @override
  State<SpotifyPlaylist> createState() => _SpotifyPlaylistState();

}

//TODO: complete this page - you may choose to change it to a stateful widget if necessary
class _SpotifyPlaylistState extends State<SpotifyPlaylist> {

  String base = "https://palota-jobs-africa-spotify-fa.azurewebsites.net/api";
  String spotifyApiKey = dotenv.get('SPOTIFY_API_KEY', fallback: '');
  Future<String>? followers;
  // List<Map<String, Future<String>>> tracks = [{ "image": Future.value("") }];
  // List<Future<String>> musicians = [Future.value("")];  
  List<Map<String, Future<String>>> featuredArtists = [{ "image": Future.value("") }];
  String searchQuery = '';

  // List<Map<String, Future<String>>> filteredTracks = [{ "image": Future.value("") }];
  List<Future<String>> filteredMusicians = [Future.value("")]; 


  List<Map<String, Future<String>>> tracks = [{ "image": Future.value(""),
                                                "artists": Future.value("") }];
  List<Future<String>> musicians = [Future.value("")];  
  List<Map<String, Future<String>>> filteredTracks = [{ "image": Future.value(""),
                                                "artists": Future.value("") }];
 
// void filterTracksBySearchQuery(value) async {
//   if (value.isNotEmpty) {
//     final tracks_result = await Future.wait(filteredTracks.map((track) async {
//       final String? song = await track["song"];
//       return song?.toString().toLowerCase().contains(value.toLowerCase()) ?? false;
//     }));

//     final musicians_result = await Future.wait(filteredMusicians.map((singer) async {
//       final String? singers = await singer;
//       return singers?.toString().toLowerCase().contains(value.toLowerCase()) ?? false;
//     }));

//     setState(() {
//       filteredTracks = tracks_result.where((result) => result).map((_) => filteredTracks[tracks_result.indexOf(_)]).toList().cast<Map<String, Future<String>>>();
//       filteredMusicians = musicians_result.where((result) => result).map((_) => filteredMusicians[musicians_result.indexOf(_)]).toList().cast<Future<String>>();
//     });
//   } else {
//     // Reset the filtered lists if the search query is empty
//     setState(() {
//       filteredTracks = List<Map<String, Future<String>>>.from(tracks);
//       filteredMusicians = List<Future<String>>.from(musicians);
//     });
//   }
// }

 
// void filterTracksBySearchQuery(String value) async {
//   if (value.isNotEmpty) {
//     final tracks_result = await Future.wait(filteredTracks.map((track) async {
//       final String? song = await track["song"];
//       final String? artists = await track["artists"];
//       return song?.toString().toLowerCase().contains(value.toLowerCase()) == true ||
//           artists?.toString().toLowerCase().contains(value.toLowerCase()) == true;
//     }));

//     // final musicians_result = await Future.wait(filteredMusicians.map((singer) async {
//     //   final String? singers = await singer;
//     //   return singers?.toString().toLowerCase().contains(value.toLowerCase()) ?? false;
//     // }));

//     setState(() {
//       filteredTracks = tracks_result
//           .where((result) => result)
//           .map((_) => filteredTracks[tracks_result.indexOf(_)])
//           .toList()
//           .cast<Map<String, Future<String>>>();

//       // filteredMusicians = musicians_result
//       //     .where((result) => result)
//       //     .map((_) => filteredMusicians[musicians_result.indexOf(_)])
//       //     .toList()
//       //     .cast<Future<String>>();
//     });
//   } else {
//     // Reset the filtered lists if the search query is empty
//     setState(() {
//       filteredTracks = List<Map<String, Future<String>>>.from(tracks);
//       // filteredMusicians = List<Future<String>>.from(musicians);
//     });
//   }
// }


// void filterTracksBySearchQuery(String value) async {
//   if (value.isNotEmpty) {
//     final tracks_result = await Future.wait(filteredTracks.map((track) async {
//       final String? song = await track["song"];
//       final String? artists = await track["artists"];
//       return song?.toString().toLowerCase().contains(value.toLowerCase()) == true ||
//           artists?.toString().toLowerCase().contains(value.toLowerCase()) == true;
//     }));

//     setState(() {
//       filteredTracks = tracks_result
//           .where((result) => result)
//           .map((_) => filteredTracks[tracks_result.indexOf(_)])
//           .toList()
//           .cast<Map<String, Future<String>>>();
//     });
//   } else {
//     // Reset the filtered list if the search query is empty
//     setState(() {
//       filteredTracks = List<Map<String, Future<String>>>.from(tracks);
//     });
//   }
// }
void filterTracksBySearchQuery(String value) async {
  if (value.isNotEmpty) {
    final tracks_result = await Future.wait(filteredTracks.map((track) async {
      final String? song = await track["song"];
      final String? artists = await track["artists"];
      return song?.toString().toLowerCase().contains(value.toLowerCase()) == true ||
          artists?.toString().toLowerCase().contains(value.toLowerCase()) == true;
    }));

    setState(() {
      filteredTracks = tracks_result
          .asMap()
          .entries
          .where((entry) => entry.value)
          .map((entry) => filteredTracks[entry.key])
          .toList()
          .cast<Map<String, Future<String>>>();
    });
  } else {
    setState(() {
      filteredTracks = List<Map<String, Future<String>>>.from(tracks);
    });
  }
}


//  void filterTracksBySearchQuery(value) {

//   print("SEARCH");
//   print(value);
//   if (value.isNotEmpty) {
//     final tracks_result = tracks.where((track) {
//   print("TRACK");
//   print(track);
//       final String song = track["song"].toString().toLowerCase();
//   print("SONG");
//   print(song);
//       return song.contains(value.toLowerCase());
//     }).toList();

//     final musicians_result = musicians.where((singer) {
//       final String singers = singer.toString().toLowerCase();
//       return singers.contains(value.toLowerCase());
//     }).toList();

//   print("RESULTS");
//   print(musicians_result);
//   print(tracks_result);

//     setState(() {
//       filteredTracks = tracks_result;
//       filteredMusicians = musicians_result;
//     });
//   } else {
//     // Reset the filtered lists if the search query is empty
//     setState(() {
//       filteredTracks = List.from(tracks);
//       filteredMusicians = List.from(musicians);
//     });
//   }
// }

// void filterTracksBySearchQuery() {
//   // final String searchQuery = context.read<ScreenProvider>().searchQuery;
  
//   // if (searchQuery.isEmpty) {
//   //   return tracks;
//   // }
  
//   // return tracks.where((track) {
//   //   final String song = track["song"].toString().toLowerCase();
//   //   final String artists = musicians[tracks.indexOf(track)].toString().toLowerCase();
//   //   return song.contains(searchQuery.toLowerCase()) || artists.contains(searchQuery.toLowerCase());
//   // }).toList();
  
//   if (searchQuery.isNotEmpty) {

//     final tracks_result = tracks.where((track) {

//       final String song = track["song"].toString().toLowerCase();
//       return song.contains(searchQuery.toLowerCase());

//     }).toList();

//     final musicians_result = musicians.where((singer) {

//       final String singers = musicians[musicians.indexOf(singer)].toString().toLowerCase();
//       return singers.contains(searchQuery.toLowerCase());

//     }).toList();

//     setState(() {

//       filteredTracks = tracks_result;
//       filteredMusicians = musicians_result;

//     });

//   }

//   }

  @override
  void initState() {

    super.initState();
    fetchData();

  }

  Future<void> fetchData() async {

    final selectedPlaylist = context.read<ScreenProvider>().selectedPlaylist;
    final id = await selectedPlaylist['identifier'];
    String endpoint = "$base/playlists/$id";
    final response = await http.get(Uri.parse(endpoint),
                                    headers: {'x-functions-key': spotifyApiKey}, );

    if (response.statusCode == 200) {

      final data = jsonDecode(response.body);
      String number = formatNumber(data["followers"]["total"].toString()) + " followers";
      List<Map<String, Future<String>>> tracklist = [];
      List<Future<String>> musicianList = [];
      final allTracks = data["tracks"]["items"];
      List<Map<String, Future<String>>> artist_featured = [];
      List<String> allArtists = [];

      for (int index = 0; index < allTracks.length; index++) {

        if (allTracks[index]["track"] != null) {

          String duration = formatDuration(allTracks[index]["track"]["duration_ms"]);
          String image = allTracks[index]["track"]["album"]["images"][2]["url"];
          String song = allTracks[index]["track"]["album"]["name"];
          List artistCollection = allTracks[index]["track"]["album"]["artists"];
          final artists = [];
          final List<Map<String, Future<String>>> features = [];

          for (int element = 0; element < artistCollection.length; element++) {

            artists.add(artistCollection[element]["name"]);
            final String link = "$base/artists/${artistCollection[element]['id']}";
            final request = await http.get(Uri.parse(link),
                                           headers: {'x-functions-key': spotifyApiKey}, );
            final payload = jsonDecode(request.body);

            if (payload.containsKey("images")) {

              final photo = payload["images"][0]["url"];

              if (allArtists.contains(artistCollection[element]["name"]) == false) {

                features.add({ "name": Future.value(artistCollection[element]["name"]),
                               "image": Future.value(photo) });

                allArtists.add(artistCollection[element]["name"]);

              }

            }

          }

          final joined = artists.join(", ");
          musicianList.add(Future.value(joined));
          artist_featured.addAll(features);
          tracklist.add({ "duration": Future.value(duration), 
                          "image": Future.value(image),
                          "artists": Future.value(joined),
                          "song": Future.value(song), });

        }

      }

      setState(() {

        followers = Future.value(number);
        tracks = tracklist;
        musicians = musicianList;
        featuredArtists = artist_featured;

        filteredMusicians = musicianList;
        filteredTracks = tracklist;

      });

    } else {

      print('Request failed with status: ${response.statusCode}');

    }

  }

  @override
  Widget build(BuildContext context) {

    var selectedPlaylist = context.watch<ScreenProvider>().selectedPlaylist;

    return Scaffold(appBar: AppBar(backgroundColor: Colors.transparent,
                                   elevation: 0,
                                   
                                   actions: [
          Container(width: 200, height: 50,
            margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: TextField(
              onChanged: (value) {
                // print(value);

                // setState(() {
                //   searchQuery = value;
                // });
                filterTracksBySearchQuery(value);
              },
              decoration: InputDecoration(
                hintText: 'Search',
                border: InputBorder.none,
                prefixIcon: Icon(Icons.search),
                contentPadding: EdgeInsets.all(12),
              ),
            ),
          ),
        ],), 

                    backgroundColor: AppColors.black,
                    body: SingleChildScrollView(physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                                                child: Container(padding: EdgeInsets.symmetric(vertical: 16),
                                                                 child: Column(children: [Container(padding: EdgeInsets.only(left: 48,
                                                                                                                             right: 48, ),
                                                                                                                
                                                                                                    child: PlaylistCard(playlist: selectedPlaylist,
                                                                                                                        padding: 15,
                                                                                                                        gap: 14,
                                                                                                                        size: 22,
                                                                                                                        innerRadius: 12,
                                                                                                                        outerRadius: 24, ), ), 
                                                                                                           
                                                                                           SizedBox(height: 15), 
                                                                                          
                                                                                           Container(padding: EdgeInsets.symmetric(horizontal: 16),
                                                                                                     child: Row(children: [Expanded(child: FutureBuilder<String>(future: selectedPlaylist["description"],
                                                                                                                                                                 builder: (context, snapshot) => textBuilder(context, snapshot, 12.0, lines: 2), ), ), ], ), ), 
                                                                                                                
                                                                                           SizedBox(height: 4), 
                                                                                          
                                                                                           Container(padding: EdgeInsets.only(left: 195),
                                                                                                     child: FollowersBanner(followers: followers), ),
                                                                                           
                                                                                           SizedBox(height: 16), 

                                                                                           Container(padding: EdgeInsets.symmetric(horizontal: 32), 
                                                                                                     child: SectionDivider(), ), 
                                                                                                     
                                                                                           SizedBox(height: 32), 

                                                                                           Container(padding: EdgeInsets.only(left: 16,
                                                                                                                              right: 16, ), 

                                                                                                    //  child: Column(children: filterTracksBySearchQuery().asMap().entries.map(
                                                                                                    //  child: Column(children: filteredTracks.asMap().entries.map(
                                                                                                     child: Column(children: filteredTracks.map(
                    (entry) {
                      // int index = entry.key;
                      return [
                        TracklistRow(
                          // track: filteredTracks[index],
                          // artists: filteredMusicians[0],
                          track: entry,
                          // artists: tracks[index]["artists"],
                        ),
                        (entry != tracks[tracks.length - 1])
                            ? SizedBox(height: 10)
                            : SizedBox.shrink(),
                      ];
                    },
                  ).expand((element) => element).toList(),
                ),
              ), 
                                                                                                                                                                                             
                                                                                                                                                                                             

                                                                                           SizedBox(height: 32),

                                                                                           Container(padding: EdgeInsets.only(right: 48), 
                                                                                                     child: FeaturedBanner(), ), 
                                                                                                     
                                                                                           SizedBox(height: 32),
                                                                                           
                                                                                           Container(height: 143, 
                                                                                                     child: ListView.builder(scrollDirection: Axis.horizontal,
                                                                                                     itemCount: featuredArtists.length,
                                                                                                     itemBuilder: (context, index) { return ArtistCard(gap: 32, 
                                                                                                                                                       image: featuredArtists[index]["image"],
                                                                                                                                                       name: featuredArtists[index]["name"], 
                                                                                                                                                       position: index, ); } ), ), ], ), ), ), );
  }

}
