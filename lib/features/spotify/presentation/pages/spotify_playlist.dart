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

  // String base = "https://palota-jobs-africa-spotify-fa.azurewebsites.net/api/playlists";
  String base = "https://palota-jobs-africa-spotify-fa.azurewebsites.net/api";
  String spotifyApiKey = dotenv.get('SPOTIFY_API_KEY', fallback: '');
  Future<String>? followers;
  List<Map<String, Future<String>>> tracks = [{ "image": Future.value("") }];
  List<Future<String>> musicians = [Future.value("")];  
  // List<Future<String>> featuredArtists = [Future.value("")];  
  List<Map<String, Future<String>>> featuredArtists = [{ "image": Future.value("") }];

  @override
  void initState() {

    super.initState();
    fetchData();

  }

  Future<void> fetchData() async {

    final selectedPlaylist = context.read<ScreenProvider>().selectedPlaylist;
    final id = await selectedPlaylist['identifier'];
    // String endpoint = "$base/$id";
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
          // final List<String> allArtists = [];
          final List<Map<String, Future<String>>> features = [];

          for (int element = 0; element < artistCollection.length; element++) {

            artists.add(artistCollection[element]["name"]);
            // print("ID");
            // print(artistCollection[element]['id']);
            final String link = "$base/artists/${artistCollection[element]['id']}";
            // print("LINK");
            // print(link);
            final request = await http.get(Uri.parse(link),
                                           headers: {'x-functions-key': spotifyApiKey}, );
            final payload = jsonDecode(request.body);
            // print("PAYLOAD");
            // print(payload);

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
          // features = features.toSet().toList();
          // artist_featured = features.toSet().toList();
          // artist_featured.addAll(features.toSet().toList());
          artist_featured.addAll(features);
          // print("FEATURES");
          // print(features);
          tracklist.add({ "duration": Future.value(duration), 
                          "image": Future.value(image),
                          "song": Future.value(song), });

        }

      }

      // artist_featured = artist_featured.toSet().toList();

      setState(() {

        followers = Future.value(number);
        tracks = tracklist;
        musicians = musicianList;
        featuredArtists = artist_featured;

      });

    } else {

      print('Request failed with status: ${response.statusCode}');

    }

  }

  @override
  Widget build(BuildContext context) {

    var selectedPlaylist = context.watch<ScreenProvider>().selectedPlaylist;

    return Scaffold(appBar: AppBar(backgroundColor: AppColors.black,
                                   elevation: 0), 

                    backgroundColor: AppColors.black,
                    body: SingleChildScrollView(physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                                                child: Container(padding: EdgeInsets.symmetric(vertical: 16),
                                                                 child: Column(children: [Container(padding: EdgeInsets.only(left: 48,
                                                                                                                             right: 48, ),
                                                                                                                            //  top: 16, ), 
                                                                                                                
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
                                                                                                                              // bottom: 32), 
                                                                                                     child: Column(children: this.tracks.asMap().entries.map((entry) { int index = entry.key;
                                                                                                                                                                        return [TracklistRow(track: tracks[index],
                                                                                                                                                                                             artists: musicians[index]), (index != tracks.length - 1) ? SizedBox(height: 10) : SizedBox.shrink()]; }).expand((i) => i).toList() ), ), 
                                                                                                                                                                                             
                                                                                                                                                                                             

                                                                                           SizedBox(height: 32),

                                                                                           Container(padding: EdgeInsets.only(right: 48), 
                                                                                                     child: FeaturedBanner(), ), 
                                                                                                     
                                                                                           SizedBox(height: 32),
                                                                                           
                                                                                          //  Container(padding: EdgeInsets.only(left: 32), child: Row(children: [ArtistCard(image: featuredArtists[0]["image"],
                                                                                          //             name: featuredArtists[0]["name"],)])), ], ), ), ), );
                                                                                          //  Container(padding: EdgeInsets.symmetric(horizontal: 32), 
                                                                                          //  Container(margin: EdgeInsets.symmetric(horizontal: 32), 
                                                                                           Container( 
                                                                                           height: 143, child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: featuredArtists.length,
          itemBuilder: (context, index) { return ArtistCard(gap: (index == featuredArtists.length - 1) ? 32 : 32, image: featuredArtists[index]["image"],
                                                                                                      name: featuredArtists[index]["name"], position: index, );})), ], ), ), ), );
  }

}
