import 'package:flutter/material.dart';
import 'package:flutter_spotify_africa_assessment/providers/screen_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_spotify_africa_assessment/colors.dart';
import 'package:flutter_spotify_africa_assessment/utility.dart';
import 'package:flutter_spotify_africa_assessment/features/spotify/presentation/components/playlist_card.dart';
import 'package:flutter_spotify_africa_assessment/features/spotify/presentation/components/followers_banner.dart';
import 'package:flutter_spotify_africa_assessment/features/spotify/presentation/components/section_divider.dart';
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

  String base = "https://palota-jobs-africa-spotify-fa.azurewebsites.net/api/playlists";
  String spotifyApiKey = dotenv.get('SPOTIFY_API_KEY', fallback: '');
  Future<String>? followers;

  @override
  void initState() {

    super.initState();
    fetchData();

  }

  Future<void> fetchData() async {

    final selectedPlaylist = context.read<ScreenProvider>().selectedPlaylist;
    final id = await selectedPlaylist['identifier'];
    String endpoint = "$base/$id";
    final response = await http.get(Uri.parse(endpoint),
                                    headers: {'x-functions-key': spotifyApiKey}, );

    if (response.statusCode == 200) {

      final data = jsonDecode(response.body);
      String number = formatNumber(data["followers"]["total"].toString()) + " followers";

      setState(() {

        followers = Future.value(number);

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
                                                child: Container(child: Column(children: [Container(padding: EdgeInsets.only(left: 48,
                                                                                                                             right: 48,
                                                                                                                             top: 16), 
                                                                                                                
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
                                                                                                     child: SectionDivier(), ), ], ), ), ), );

  }

}
