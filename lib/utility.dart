import "package:flutter/material.dart";


Widget textBuilder(context, snapshot) {

  if (snapshot.connectionState == ConnectionState.done) {

    final text = snapshot.data;

    return Text(text,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 12,
                                 fontWeight: FontWeight.bold, ), );

  } else {

    return CircularProgressIndicator();

  }

}
