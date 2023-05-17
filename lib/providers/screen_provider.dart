import 'package:flutter/material.dart';


class ScreenProvider with ChangeNotifier {

  Map<String, Future<String>> _selectedPlaylist = {};
  Map<String, Future<String>> get selectedPlaylist => _selectedPlaylist;

  void setPlaylist(Map<String, Future<String>> playlist) {

    _selectedPlaylist = playlist;
    notifyListeners();

  }

}