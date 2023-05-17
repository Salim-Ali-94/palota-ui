import "package:flutter/material.dart";
import "package:flutter_spotify_africa_assessment/features/spotify/presentation/components/playlist_card.dart";


class GridSection extends StatelessWidget {

  final List<Map<String, Future<String>>> playlists;

  const GridSection({ Key? key, 
                      required this.playlists, }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return (playlists.isEmpty) ? const Center(child: CircularProgressIndicator()) : 
                                 Container(padding: const EdgeInsets.symmetric(horizontal: 24),
                                           child: GridView.count(crossAxisCount: 2,
                                                                 crossAxisSpacing: 16,
                                                                 mainAxisSpacing: 16,
                                                                 shrinkWrap: true,
                                                                 childAspectRatio: 163 / 187,
                                                                 physics: const NeverScrollableScrollPhysics(),

                                                                 children: playlists.map((playlist) => PlaylistCard(playlist: playlist,
                                                                                                                    padding: 4,
                                                                                                                    gap: 4,
                                                                                                                    size: 12,
                                                                                                                    innerRadius: 8,
                                                                                                                    bold: true,
                                                                                                                    outerRadius: 12), ).toList(), ), );
  }

}
