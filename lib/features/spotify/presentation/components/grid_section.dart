import "package:flutter/material.dart";
import "package:flutter_spotify_africa_assessment/features/spotify/presentation/components/playlist_card.dart";
import "package:http/http.dart" as http;
import "dart:convert";
import 'package:flutter_dotenv/flutter_dotenv.dart';


class GridSection extends StatefulWidget {

  const GridSection({ super.key });

  @override
  State<GridSection> createState() => _GridSectionState();

}

class _GridSectionState extends State<GridSection> {

  String spotifyApiKey = dotenv.get('SPOTIFY_API_KEY', fallback: '');
  // String base = "https://palota-jobs-africa-spotify-fa.azurewebsites.net/api/browse";
  // String base = "https://palota-jobs-africa-spotify-fa.azurewebsites.net/api/browse/categories/afro/playlists?limit=1";
  // String base = "https://palota-jobs-africa-spotify-fa.azurewebsites.net/api/browse/categories/afro/playlists";
  String base = "https://palota-jobs-africa-spotify-fa.azurewebsites.net/api/browse";
  Future<String>? image;
  Future<String>? title;


  @override
  void initState() {

    super.initState();
    fetchData().then((data) {

      setState(() {

        image = Future.value(data["image"]);
        title = Future.value(data["title"]);

      });

    });

  }

  Future<Map<String, String>> fetchData() async {

    String endpoint = "$base/categories/afro/playlists";
    final response = await http.get(Uri.parse(endpoint), 
                                    headers: { 'x-functions-key': spotifyApiKey, }, );

    if (response.statusCode == 200) {

      final data = response.body;
      String image = jsonDecode(data.toString())["playlists"]["items"][0]["images"][0]["url"];
      String title = jsonDecode(data.toString())["playlists"]["items"][0]["name"];
      return { "image": image, "title": title };

    } else {

      print('Request failed with status: ${response.statusCode}');
      return { "image": "", "title": "" };

    }

  }

  @override
  Widget build(BuildContext context) {

    return Container(width: 342,
                     child: GridView.count(crossAxisCount: 2,
                                           crossAxisSpacing: 16,
                                           mainAxisSpacing: 16,
                                           shrinkWrap: true,
                                           childAspectRatio: 163 / 187,
                                           physics: NeverScrollableScrollPhysics(),
                                           children: [PlaylistCard(image: image,
                                                                   title: title),
                                                      PlaylistCard(image: image,
                                                                               title: title),
                                                      PlaylistCard(image: image,
                                                                               title: title),
                                                      PlaylistCard(image: image,
                                                                               title: title),
                                                      PlaylistCard(image: image,
                                                                               title: title),
                                                      PlaylistCard(image: image,
                                                                               title: title),
                                                      PlaylistCard(image: image,
                                                                               title: title),
                                                      PlaylistCard(image: image,
                                                                               title: title),
                                                      PlaylistCard(image: image,
                                                                               title: title),
                                                      PlaylistCard(image: image,
                                                                               title: title),
                                                      PlaylistCard(image: image,
                                                                               title: title),
                                                      PlaylistCard(image: image,
                                                                               title: title),
                                                      PlaylistCard(image: image,
                                                                               title: title),
                                                      PlaylistCard(image: image,
                                                                               title: title),
                                                      PlaylistCard(image: image,
                                                                               title: title),
                                                      PlaylistCard(image: image,
                                                                               title: title), ], ), );

  }

}