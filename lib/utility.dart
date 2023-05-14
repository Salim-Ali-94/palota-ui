import "package:flutter/material.dart";
import 'package:intl/intl.dart';


Widget textBuilder(context, snapshot, size, { int lines = 1 }) {

  if (snapshot.connectionState == ConnectionState.done) {

    final text = snapshot.data;

    return Text(text,
                maxLines: lines,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: size,
                                 fontWeight: FontWeight.bold, ), );

  } else {

    return CircularProgressIndicator();

  }

}

Widget imageBuilder(context, snapshot, radius) {

  if (snapshot.connectionState == ConnectionState.done) {

    final imageUrl = snapshot.data;
    return ClipRRect(borderRadius: BorderRadius.circular(radius), 
                      child: Image.network(imageUrl!));

  } else {

    return Center(child: CircularProgressIndicator());

  }

}

String formatNumber(String numberString) {

  final number = int.parse(numberString);
  final formatter = NumberFormat('#,###');
  return formatter.format(number);

}