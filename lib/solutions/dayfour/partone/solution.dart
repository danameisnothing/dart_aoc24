import 'dart:io';

import 'package:dart_aoc24/utils/utils.dart';

const _targetString = "XMAS";

// Assume we are starting with "X"
int _beginSearch(List<List<String>> data, Vector2 origin, int currProgressInTargetStr, [SearchDirection? searchDir]) {
  // Check for if we found the full sentence (For the very end of the recursion tree)
  if (currProgressInTargetStr >= _targetString.length) {
    return 1;
  }

  final ret = neighbourCheck(data, origin.x, origin.y, _targetString[currProgressInTargetStr]);

  Iterable<NeighbourCollectionData> target = ret.data;

  if (searchDir != null) {
    target = target.where((x) => x.dir == searchDir);
  }

  List<int> retVals = <int>[];
  
  for (NeighbourCollectionData coors in target) {
    retVals.add(_beginSearch(data, coors.pos, currProgressInTargetStr + 1, coors.dir));
  }

  return retVals.where((x) => x.sign == 1).length;
}

void execD4P1() {
  final data = <List<String>>[];
  for (String str in File("lib/solutions/dayfour/partone/input.txt").readAsLinesSync()) {
    data.add(str.split(""));
  }

  int total = 0;

  for (int y = 0; y < data.length; y++) {
    for (int x = 0; x < data.elementAt(y).length; x++) {
      // our starting point
      if (data.elementAt(y).elementAt(x) == _targetString.substring(0, 1)) {
        total += _beginSearch(data, Vector2(x, y), 1);
      }
    }
  }
  
  print(total);
}