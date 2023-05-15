import "package:flutter/material.dart";
import 'package:intl/intl.dart';


Widget textBuilder(context, snapshot, size, { int lines = 1, bool bold = false, rich = false }) {

  if (snapshot.connectionState == ConnectionState.done) {

    final text = snapshot.data;

    if (text != null && text.isNotEmpty && text != "") {

      return Text(text,
                  maxLines: lines,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: size,
                                   fontWeight: (bold == true) ? FontWeight.bold : FontWeight.normal, ), );

    } else {
      
        print("FUTURE TEXT IS EMPTY");
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
                                             width: null,
                                             height: null));

    } else {

        print("FUTURE IMG IS EMPTY");
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