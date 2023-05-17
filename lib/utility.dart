import "package:flutter/material.dart";
import 'package:intl/intl.dart';
// import 'dart:async';


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


// Future<List<Map<String, String>>> convertFutureArray(List<Map<String, Future<String>>> objects) async {

//   final array = await Future.wait(objects.map((item) async {

//     final element = <String, String>{};

//     await Future.forEach(item.entries, (entry) async {

//       final value = await entry.value;
//       element[entry.key] = value;

//     });

//     return element;

//   }));

//   return array;

// }









Future<List<Map<String, String>>> convertFutureArray(List<Map<String, Future<String>>> objects) async {
  final array = await Future.wait(objects.map((item) async {
    final element = <String, String>{};
    await Future.forEach(item.entries, (entry) async {
      final value = await entry.value;
      element[entry.key] = value;
    });
    return element;
  }));
  return array;
}


// List<Map<String, String>> convertFutureArray(List<Map<String, Future<String>>> objects) {

//   final array = objects.map((element) {

//     final element = <String, String>{};

//     element.forEach((key, item) {

//       element[key] = item.toString();
      
//     });

//     return element;

//   }).toList();

//   return array;

// }





// xx
// Future<List<Map<String, String>>> convertFutureArray(List<Map<String, Future<String>>>> objects) async {

//   List<Map<String, String>> array = [];

//   for (var item in objects) {

//     Map<String, String> element = {};

//     await Future.wait(item.entries.map((entry) async {

//       element[entry.key] = await entry.value;

//     }));

//     array.add(element);

//   }

//   return array;
  
// }
// xx



// Future<List<Map<String, Future<String>>>> convertArray(List<Map<String, String>> objects) async {

//   final array = <Map<String, Future<String>>>[];
  
//   for (final item in objects) {

//     final element = <String, Future<String>>{};
    
//     item.forEach((key, value) {

//       element[key] = Future.value(value);

//     });
    
//     array.add(element);
  
//   }
  
//   return array;

// }
// Future<List<Map<String, Future<String>>>> convertArray(List<Map<String, String>> objects) async {
//   final array = <Map<String, Future<String>>>[];

//   for (final item in objects) {
//     final element = <String, Future<String>>{};
//     item.forEach((key, value) {
//       element[key] = Future.value(value);
//     });
//     array.add(element);
//   }

//   return array;
// }

// List<Map<String, Future<String>>> convertArray(List<Map<String, String>> objects) {
//   final array = <Map<String, Future<String>>>[];

//   for (final item in objects) {
//     final element = <String, Future<String>>{};
//     item.forEach((key, value) {
//       element[key] = Future.value(value);
//     });
//     array.add(element);
//   }

//   return array;
// }
// List<Map<String, Future<String>>> convertArray(List<dynamic> objects) {
//   final array = <Map<String, Future<String>>>[];

//   for (final item in objects) {
//     final element = <String, Future<String>>{};
//     item.forEach((key, value) {
//       element[key] = Future.value(value);
//     });
//     array.add(element);
//   }

//   return array;
// }
List<Map<String, Future<String>>> convertArray(List<dynamic> objects) {
  final array = <Map<String, Future<String>>>[];

  for (final item in objects) {
    final element = <String, Future<String>>{};
    item.forEach((key, value) {
      if (value is String) {
        element[key] = Future.value(value);
      } else if (value is Future<String>) {
        element[key] = value;
      }
    });
    array.add(element);
  }

  return array;
}

// List<Map<String, Future<String>>> convertArray(List<Map<String, String>> objects) {

//   return objects.map((item) {

//     return item.map((key, value) {

//       return MapEntry(key, Future.value(value));

//     });

//   }).toList();

// }
        // _box.get(id)["tracks"].then((entry) {
        
        //   convertArray(entry).then((element) {

        //     setState(() {

        //       tracks = element;
            
        //     });
          
        //   });
        
        // });

        // _box.get(id)["featured"].then((entry) {
        
        //   convertArray(entry).then((element) {

        //     setState(() {

        //       featuredArtists = element;
            
        //     });
          
        //   });
        
        // });

        // _box.get(id)["tracks"].then((entry) {
        
        //   convertArray(entry).then((element) {

        //     setState(() {

        //       filteredTracks = element;
            
        //     });
          
        //   });
        
        // });



































//         Future<List<Map<String, String>>> convertArray(List<Map<String, Future<String>>> objects) async {
//   final array = <Map<String, String>>[];

//   for (final item in objects) {
//     final element = <String, String>{};

//     await Future.forEach(item.entries, (entry) async {
//       final value = await entry.value;
//       element[entry.key] = value;
//     });

//     array.add(element);
//   }

//   return array;
// }
