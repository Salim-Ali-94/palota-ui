import "package:flutter/material.dart";


class GridSection extends StatelessWidget {

  const GridSection({ super.key });

  @override
  Widget build(BuildContext context) {

    return Container(width: 342,
                     color: Colors.blue,
                     child: Wrap(spacing: 16, 
                                 runSpacing: 16,
                                 children: [Container(width: 163, color: Colors.amber, child: Text("GRID")), 
                                            Container(width: 163, color: Colors.amber, child: Text("GRID")),
                                            Container(width: 163, color: Colors.amber, child: Text("GRID")), 
                                            Container(width: 163, color: Colors.amber, child: Text("GRID"))]));

  }

}