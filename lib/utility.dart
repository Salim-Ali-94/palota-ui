import "package:flutter/material.dart";
import 'package:intl/intl.dart';


Widget textBuilder(context, snapshot, size, { int lines = 1 }) {

  if (snapshot.connectionState == ConnectionState.done) {

    final text = snapshot.data;

    if (text != null && text.isNotEmpty && text != "") {
    // if (snapshot.data != "") {

      // final text = snapshot.data;

      return Text(text,
                  maxLines: lines,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: size,
                                  fontWeight: FontWeight.bold, ), );

    } else {
      
        print("FUTURE TEXT IS EMPTY");
        return CircularProgressIndicator();

    }

  } else {

    return CircularProgressIndicator();

  }

}


Widget imageBuilder(context, snapshot, radius) {

  if (snapshot.connectionState == ConnectionState.done) {

    final url = snapshot.data;

    if (url != null && url.isNotEmpty && url != "") {

      // final imageUrl = snapshot.data;
      return ClipRRect(borderRadius: BorderRadius.circular(radius), 
                        child: Image.network(url!));

    } else {

        print("FUTURE IMG IS EMPTY");
        return Center(child: CircularProgressIndicator());

    }

  } else {

      return Center(child: CircularProgressIndicator());

  }

}
// Widget imageBuilder(
//     BuildContext context, AsyncSnapshot<dynamic> snapshot, double radius) {
//   if (snapshot.connectionState == ConnectionState.done) {
//     final imageUrlFuture = snapshot.data! as Future<dynamic>?;
//     return FutureBuilder<dynamic>(
//       future: imageUrlFuture,
//       builder: (context, AsyncSnapshot<dynamic> snapshot) {
//         if (snapshot.connectionState == ConnectionState.done) {
//           final imageUrl = snapshot.data as String?;
//           return ClipRRect(
//             borderRadius: BorderRadius.circular(radius),
//             child: Image.network(imageUrl!),
//           );
//         } else {
//           return Center(child: CircularProgressIndicator());
//         }
//       },
//     );
//   } else {
//     return Center(child: CircularProgressIndicator());
//   }
// }

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