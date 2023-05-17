import "package:hive_flutter/hive_flutter.dart";


class PlaylistCache {

  // late List<Map<String, Future<String>>> data;
  // PlaylistCache({ required this.data });



  // List toDoList = [];

  List<Map<String, Future<String>>> tracksCollection = [];
  // final _myBox = Hive.box("mybox");
  final _box = Hive.box("collection");

  // void createInitialData() {
  void initializeData(List<Map<String, Future<String>>> data) {

  //     toDoList = [["code an app", true],
  //                 ["go gym", false]];

    // tracksCollection = this.data;

    tracksCollection = data;
    // List<Map<String, Future<String>>> tracksCollection = [{ "image": Future.value(""),
    //                                                         "artists": Future.value("") }];

  }

  // void loadData() {

  //   toDoList = _myBox.get("TODO_LIST");

  // }
  void loadData() {

    tracksCollection = _box.get("tracks");

  }

  // void updateDataBase() {

  //   _myBox.put("TODO_LIST", toDoList);

  // }
  void updateData() {

    _box.put("tracks", tracksCollection);

  }

}