

import 'dart:collection';

import 'package:flutter/material.dart';

class ListData extends ChangeNotifier {
  List _listData = [

  ];

  UnmodifiableListView get listData {
    return UnmodifiableListView(_listData);
  }

  int get listCount {
    return _listData.length;
  }

  void addData(String data) {
    _listData.add(data);
    notifyListeners();
  }
}