import 'dart:io';

const targetString = "XMAS";

/*class SearchDirection {
  static int get topLeft => 0;
  static int get top => 1;
  static int get topRight => 2;
  static int get left => 3;
  static int get right => 4;
  static int get bottomLeft => 5;
  static int get bottom => 6;
  static int get bottomRight => 7;
}*/
enum SearchDirection {
  topLeft,
  top,
  topRight,
  left,
  right,
  bottomLeft,
  bottom,
  bottomRight
}

class Vector2 {
  int x, y;

  Vector2(this.x, this.y);
}

class NeighbourCollectionData {
  Vector2 pos;
  SearchDirection dir;

  NeighbourCollectionData(this.pos, this.dir);
}

class NeighbourCheckReturnData {
  List<NeighbourCollectionData> data;

  NeighbourCheckReturnData() : data = [];
}

// Returns an index list of found charTargets
// AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
NeighbourCheckReturnData _neighbourCheck(List<List<String>> input, int xIndex, int yIndex, String charTarget) {
  final returnData = NeighbourCheckReturnData();
  // Top left
  if (!(xIndex - 1).isNegative && !(yIndex - 1).isNegative) {
    if (input.elementAt(yIndex - 1).elementAt(xIndex - 1) == charTarget) {
      returnData.data.add(NeighbourCollectionData(Vector2(xIndex - 1, yIndex - 1), SearchDirection.topLeft));
    }
  }
  // Top
  if (!(yIndex - 1).isNegative) {
    if (input.elementAt(yIndex - 1).elementAt(xIndex) == charTarget) {
      returnData.data.add(NeighbourCollectionData(Vector2(xIndex, yIndex - 1), SearchDirection.top));
    }
  }
  // Top right (Assuming all lines are of equal length)
  if (xIndex + 1 < input.first.length && !(yIndex - 1).isNegative) {
    if (input.elementAt(yIndex - 1).elementAt(xIndex + 1) == charTarget) {
      returnData.data.add(NeighbourCollectionData(Vector2(xIndex + 1, yIndex - 1), SearchDirection.topRight));
    }
  }
  // Left
  if (!(xIndex - 1).isNegative) {
    if (input.elementAt(yIndex).elementAt(xIndex - 1) == charTarget) {
      returnData.data.add(NeighbourCollectionData(Vector2(xIndex - 1, yIndex), SearchDirection.left));
    }
  }
  // Right (Assuming all lines are of equal length)
  if (xIndex + 1 < input.first.length) {
    if (input.elementAt(yIndex).elementAt(xIndex + 1) == charTarget) {
      returnData.data.add(NeighbourCollectionData(Vector2(xIndex + 1, yIndex), SearchDirection.right));
    }
  }
  // Bottom left (Assuming all lines are of equal length)
  if (!(xIndex - 1).isNegative && yIndex + 1 < input.length) {
    if (input.elementAt(yIndex + 1).elementAt(xIndex - 1) == charTarget) {
      returnData.data.add(NeighbourCollectionData(Vector2(xIndex - 1, yIndex + 1), SearchDirection.bottomLeft));
    }
  }
  // Bottom (Assuming all lines are of equal length)
  if (yIndex + 1 < input.length) {
    if (input.elementAt(yIndex + 1).elementAt(xIndex) == charTarget) {
      returnData.data.add(NeighbourCollectionData(Vector2(xIndex, yIndex + 1), SearchDirection.bottom));
    }
  }
  // Bottom right (Assuming all lines are of equal length)
  if (xIndex + 1 < input.first.length && yIndex + 1 < input.length) {
    if (input.elementAt(yIndex + 1).elementAt(xIndex + 1) == charTarget) {
      returnData.data.add(NeighbourCollectionData(Vector2(xIndex + 1, yIndex + 1), SearchDirection.bottomRight));
    }
  }

  return returnData;
}

// Assume we are starting with "X"
bool _beginSearch(List<List<String>> data, int xCoor, int yCoor, int currProgressInTargetStr, [SearchDirection? searchDir]) {
  if (currProgressInTargetStr >= targetString.length) {
    return true;
  }

  final ret = _neighbourCheck(data, xCoor, yCoor, targetString[currProgressInTargetStr]);

  Iterable<NeighbourCollectionData> target = ret.data;

  if (searchDir != null) {
    target = target.where((x) => x.dir == searchDir);
  }
  
  for (NeighbourCollectionData coors in target) {
    print("Checking ${targetString[currProgressInTargetStr - 1]} to ${targetString[currProgressInTargetStr]} ($xCoor, $yCoor) to (${coors.pos.x}, ${coors.pos.y})");
    return _beginSearch(data, coors.pos.x, coors.pos.y, currProgressInTargetStr + 1, coors.dir);
  }

  return false;
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
      if (data.elementAt(y).elementAt(x) == targetString.substring(0, 1)) {
        total += (_beginSearch(data, x, y, 1) == true) ? 1 : 0;
        print("");
      }
    }
  }
  
  print(total);
}