import 'dart:io';

import 'package:dart_aoc24/utils/utils.dart';

// No neat constants here

bool _isXShapedMAS(List<List<String>> data, Vector2 origin) {
  final searchFilter = [SearchDirection.topLeft, SearchDirection.topRight, SearchDirection.bottomLeft, SearchDirection.bottomRight];
  final mData = neighbourCheck(data, origin.x, origin.y, "M", searchFilter);
  final sData = neighbourCheck(data, origin.x, origin.y, "S", searchFilter);

  if (mData.data.length != 2 || sData.data.length != 2) return false;

  List<List<Object>> collectedData = [];

  for (final mCollection in mData.data) {
    collectedData.add([mCollection.pos, mCollection.dir, "M"]);
  }
  for (final sCollection in sData.data) {
    collectedData.add([sCollection.pos, sCollection.dir, "S"]);
  }

  final topLeftData = collectedData.firstWhere((e) => e.elementAt(1) == SearchDirection.topLeft);
  final topRightData = collectedData.firstWhere((e) => e.elementAt(1) == SearchDirection.topRight);
  final bottomLeftData = collectedData.firstWhere((e) => e.elementAt(1) == SearchDirection.bottomLeft);
  final bottomRightData = collectedData.firstWhere((e) => e.elementAt(1) == SearchDirection.bottomRight);

  if ((topLeftData.elementAt(2) == "M" && bottomRightData.elementAt(2) == "S") || (topLeftData.elementAt(2) == "S" && bottomRightData.elementAt(2) == "M")) {
    return true;
  }

  return false;
}

void execD4P2() {
  final data = <List<String>>[];
  for (String str in File("lib/solutions/dayfour/parttwo/input.txt").readAsLinesSync()) {
    data.add(str.split(""));
  }

  int total = 0;

  for (int y = 0; y < data.length; y++) {
    for (int x = 0; x < data.elementAt(y).length; x++) {
      // our starting point
      if (data.elementAt(y).elementAt(x) == "A") {
        total += (_isXShapedMAS(data, Vector2(x, y)) == true) ? 1 : 0;
      }
    }
  }

  print(total);
}