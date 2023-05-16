import "package:flutter/material.dart";
import "package:flutter_spotify_africa_assessment/features/spotify/presentation/components/playlist_card.dart";


class GridSection extends StatelessWidget {

  final List<Map<String, Future<String>>> playlists;

  const GridSection({ Key? key, 
                      required this.playlists, }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return (playlists.isEmpty) ? Center(child: CircularProgressIndicator()) : 
                                 Container(padding: EdgeInsets.symmetric(horizontal: 24),
                                           child: GridView.count(crossAxisCount: 2,
                                                                 crossAxisSpacing: 16,
                                                                 mainAxisSpacing: 16,
                                                                 shrinkWrap: true,
                                                                 childAspectRatio: 163 / 187,
                                                                 physics: NeverScrollableScrollPhysics(),

                                                                //  children: playlists.map((playlist) => PlaylistCard(image: playlist["image"],
                                                                //                                                     title: playlist["title"], 
                                                                //                                                     index: index), ).toList(), ), );
                                                                 children: playlists.map((playlist) => PlaylistCard(playlist: playlist,
                                                                                                                    padding: 4,
                                                                                                                    gap: 4,
                                                                                                                    size: 12,
                                                                                                                    innerRadius: 8,
                                                                                                                    bold: true,
                                                                                                                    outerRadius: 12), ).toList(), ), );
  }

}
