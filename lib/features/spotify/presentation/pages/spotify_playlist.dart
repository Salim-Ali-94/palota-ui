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
import 'package:flutter_spotify_africa_assessment/constants.dart';
import 'package:hive/hive.dart';


class SpotifyPlaylist extends StatefulWidget {

  SpotifyPlaylist({Key? key}) : super(key: key);

  @override
  State<SpotifyPlaylist> createState() => _SpotifyPlaylistState();

}

//TODO: complete this page - you may choose to change it to a stateful widget if necessary
class _SpotifyPlaylistState extends State<SpotifyPlaylist> {

  Future<String>? followers;
  final _box = Hive.box("collection");
  List<Map<String, Future<String>>> featuredArtists = [{ "image": Future.value(""),
                                                         "name": Future.value("") }];

  List<Map<String, Future<String>>> tracks = [{ "image": Future.value(""),
                                                "artists": Future.value("") }];

  List<Map<String, Future<String>>> filteredTracks = [{ "image": Future.value(""),
                                                        "artists": Future.value("") }];

  @override
  void initState() {

    super.initState();
    final selectedPlaylist = context.read<ScreenProvider>().selectedPlaylist;

    selectedPlaylist["identifier"]?.then((id) {

      if (_box.get(id) == null) {

        fetchData();

      } else {

        setState(() {

          followers = Future.value(_box.get(id)["followers"]);
          tracks = convertArray(_box.get(id)["tracks"]);
          featuredArtists = convertArray(_box.get(id)["featured"]);
          filteredTracks = convertArray(_box.get(id)["tracks"]);

        });

      }

    });

  }

  Future<void> fetchData() async {

    final selectedPlaylist = context.read<ScreenProvider>().selectedPlaylist;
    final id = await selectedPlaylist['identifier'];
    String endpoint = "$spotifyBaseUrl/playlists/$id";
    final response = await http.get(Uri.parse(endpoint),
                                    headers: {'x-functions-key': spotifyApiKey}, );

    if (response.statusCode == 200) {

      final data = jsonDecode(response.body);
      String number = formatNumber(data["followers"]["total"].toString()) + " followers";
      List<Map<String, Future<String>>> tracklist = [];
      final allTracks = data["tracks"]["items"];
      List<Map<String, Future<String>>> featured_artists = [];
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
            final String link = "$spotifyBaseUrl/artists/${artistCollection[element]['id']}";

            final request = await http.get(Uri.parse(link),
                                           headers: {'x-functions-key': spotifyApiKey}, );

            final payload = jsonDecode(request.body);

            if (payload.containsKey("images")) {
              
              if (allArtists.contains(artistCollection[element]["name"]) == false) {

                final photo = (payload["images"].length > 0) ? payload["images"][0]["url"] : "https://icons-for-free.com/iconfiles/png/128/music+round+icon+spotify+icon-1320190507294268936.png";

                features.add({ "name": Future.value(artistCollection[element]["name"]),
                               "image": Future.value(photo) });

                allArtists.add(artistCollection[element]["name"]);

              }

            }

          }

          final joined = artists.join(", ");
          featured_artists.addAll(features);
          tracklist.add({ "duration": Future.value(duration), 
                          "image": Future.value(image),
                          "artists": Future.value(joined),
                          "song": Future.value(song), });

        }

      }

      _box.put(id, { "tracks": await convertFutureArray(tracklist),
                     "followers": number,
                     "featured": await convertFutureArray(featured_artists) });

      setState(() {

        followers = Future.value(number);
        tracks = tracklist;
        featuredArtists = featured_artists;
        filteredTracks = tracklist;

      });

    } else {

      print('Request failed with status: ${response.statusCode}');

    }

  }

  void filterSearch(String value) async {

    if (value.isNotEmpty) {

      final List<Map<String, Future<String>>> filtered = [];

      for (final track in tracks) {

        final String? song = await track["song"];
        final String? artists = await track["artists"];

        if (song != null && artists != null) {

          final songMatch = song.toLowerCase().contains(value.toLowerCase());
          final artistMatch = artists.toLowerCase().contains(value.toLowerCase());

          if (songMatch || artistMatch) {

            filtered.add(track);

          }

        }

      }

      setState(() {

        filteredTracks = filtered;

      });

    } else {

      setState(() {

        filteredTracks = List<Map<String, Future<String>>>.from(tracks);

      });

    }

  }

  @override
  Widget build(BuildContext context) {

    var selectedPlaylist = context.watch<ScreenProvider>().selectedPlaylist;
    var screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(appBar: AppBar(backgroundColor: Colors.transparent,
                                   elevation: 0,
                                   actions: [Container(width: screenWidth*0.5, height: 35,
                                                       margin: EdgeInsets.symmetric(vertical: 8, 
                                                                                    horizontal: 16),

                                                       decoration: BoxDecoration(color: Colors.white,
                                                                                 borderRadius: BorderRadius.circular(8), ),

                                                       child: TextField(onChanged: (value) => filterSearch(value),
                                                                        style: TextStyle(color: Colors.black),
                                                                        decoration: InputDecoration(hintText: 'Search',
                                                                                                    hintStyle: TextStyle(color: Colors.grey, ),
                                                                                                    border: InputBorder.none,
                                                                                                    prefixIcon: Padding(padding: EdgeInsets.symmetric(vertical: 8),
                                                                                                                        child: Icon(Icons.search), ),

                                                                                                    contentPadding: EdgeInsets.all(0), ), ), ), ], ), 

                    backgroundColor: AppColors.black,
                    body: SingleChildScrollView(physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                                                child: Container(padding: EdgeInsets.symmetric(vertical: 16),
                                                                 child: Column(children: [Container(padding: EdgeInsets.only(left: 48,
                                                                                                                             right: 48, ),
                                                                                                                
                                                                                                    child: PlaylistCard(playlist: selectedPlaylist,
                                                                                                                        padding: 15,
                                                                                                                        gap: 14,
                                                                                                                        size: 22,
                                                                                                                        bold: false,
                                                                                                                        innerRadius: 12,
                                                                                                                        outerRadius: 24, ), ), 
                                                                                                           
                                                                                           SizedBox(height: 15), 
                                                                                          
                                                                                           Container(padding: EdgeInsets.symmetric(horizontal: 16),
                                                                                                     child: Row(children: [Expanded(child: FutureBuilder<String>(future: selectedPlaylist["description"],
                                                                                                                                                                 builder: (context, snapshot) => textBuilder(context, snapshot, 12.0, lines: 2, bold: true), ), ), ], ), ), 
                                                                                                                
                                                                                           SizedBox(height: 4), 
                                                                                          
                                                                                           Container(padding: EdgeInsets.only(left: 195),
                                                                                                     child: FollowersBanner(followers: followers), ),
                                                                                           
                                                                                           SizedBox(height: 16), 

                                                                                           Container(padding: EdgeInsets.symmetric(horizontal: 32), 
                                                                                                     child: SectionDivider(), ), 
                                                                                                     
                                                                                           SizedBox(height: 32), 

                                                                                           Container(padding: EdgeInsets.only(left: 16,
                                                                                                                              right: 16, ), 
                                                                                                     
                                                                                                     child: Column(children: (filteredTracks.length == 0) ? [Container(width: screenWidth*0.9, 
                                                                                                                                                                       child: Text("No tracks exist that match your search query",
                                                                                                                                                                                   style: TextStyle(fontWeight: FontWeight.bold, ), ), ), ] : filteredTracks.map((entry) { return [TracklistRow(track: entry),
                                                                                                                                                                                                                                                                                   (entry != tracks[tracks.length - 1]) ? SizedBox(height: 10) : SizedBox.shrink(), ]; }, ).expand((element) => element).toList(), ), ),
                                                                                                                                                                                                                                                            
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