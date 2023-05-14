import "package:flutter/material.dart";
import "package:flutter_spotify_africa_assessment/features/spotify/presentation/components/playlist_card.dart";


class GridSection extends StatelessWidget {

  const GridSection({ super.key });

  @override
  Widget build(BuildContext context) {

    return Container(width: 342,
                     child: Wrap(spacing: 16, 
                                 runSpacing: 16,
                                 children: [PlaylistCard(), 
                                            PlaylistCard(),
                                            PlaylistCard(), 
                                            PlaylistCard()]));

  }

}