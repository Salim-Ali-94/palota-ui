import "package:flutter/material.dart";
import 'package:intl/intl.dart';


Widget textBuilder(context, snapshot, size, { int lines = 1, bool bold = false, rich = false }) {

  if (snapshot.connectionState == ConnectionState.done) {

    final text = snapshot.data;

    if (text != null && text.isNotEmpty && text != "") {

      return (rich == false) ? Text(text,
                                    maxLines: lines,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(fontSize: size,
                                                     fontWeight: (bold == true) ? FontWeight.w600 : FontWeight.normal, ), ) :
                              
                               RichText(text: TextSpan(style: DefaultTextStyle.of(context).style,
                                     children: <TextSpan>[TextSpan(text: text,
                                                                   style: TextStyle(fontSize: size,
                                                                                    fontWeight: FontWeight.bold, ), ),
                                                          
                                                          TextSpan(text: ' playlists',
                                                                   style: TextStyle(fontSize: size, ), ), ], ), );

    } else {
      
        return CircularProgressIndicator();

    }

  } else {

    return CircularProgressIndicator();

  }

}

Widget imageBuilder(context, snapshot, radius, { width = null, height = null }) {

  if (snapshot.connectionState == ConnectionState.done) {

    final url = snapshot.data;

    if (url != null && url.isNotEmpty && url != "") {

      return ClipRRect(borderRadius: BorderRadius.circular(radius), 
                        child: Image.network(url!,
                                             fit: BoxFit.cover,
                                             width: width,
                                             height: height));

    } else {

        return Center(child: CircularProgressIndicator());

    }

  } else {

      return Center(child: CircularProgressIndicator());

  }

}

String formatNumber(String numberString) {

  final number = int.parse(numberString);
  final formatter = NumberFormat('#,###');
  return formatter.format(number);

}

String formatDuration(int milliseconds) {
 
  Duration duration = Duration(milliseconds: milliseconds);
  int minutes = duration.inMinutes;
  int seconds = (duration.inSeconds % 60).toInt();
  String minutesString = minutes.toString().padLeft(2, '0');
  String secondsString = seconds.toString().padLeft(2, '0');
  return '$minutesString:$secondsString';

}