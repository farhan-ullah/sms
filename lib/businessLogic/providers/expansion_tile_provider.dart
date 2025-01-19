import 'package:flutter/material.dart';

class ExpansionTileProvider with ChangeNotifier {
  int _expandedIndex = -1;

  int get expandedIndex => _expandedIndex;

  // Set the expanded index and notify listeners
  void setExpandedIndex(int index) {
    if (_expandedIndex == index) {
      _expandedIndex = -1; // Collapse if the same tile is clicked
    } else {
      _expandedIndex = index; // Expand the clicked tile
    }
    notifyListeners(); // Notify listeners of the change
  }
}
