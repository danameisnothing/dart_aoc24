import 'package:dart_aoc24/utils/utils.dart';

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

class NeighbourCollectionData {
  Vector2 pos;
  SearchDirection dir;

  NeighbourCollectionData(this.pos, this.dir);

  @override
  String toString() => "{${pos.toString()}, $dir}";
}

class NeighbourCheckReturnData {
  List<NeighbourCollectionData> data;

  NeighbourCheckReturnData() : data = [];

  @override
  String toString() => data.toString();
}

// Returns an index list of found charTargets
// AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
// FIXME: DOCS!
NeighbourCheckReturnData neighbourCheck(List<List<String>> input, int xIndex, int yIndex, String charTarget, [List<SearchDirection> filterDirectionsTo = const <SearchDirection>[]]) {
  final returnData = NeighbourCheckReturnData();
  // Top left
  if (!(xIndex - 1).isNegative && !(yIndex - 1).isNegative && filterDirectionsTo.contains(SearchDirection.topLeft)) {
    if (input.elementAt(yIndex - 1).elementAt(xIndex - 1) == charTarget) {
      returnData.data.add(NeighbourCollectionData(Vector2(xIndex - 1, yIndex - 1), SearchDirection.topLeft));
    }
  }
  // Top
  if (!(yIndex - 1).isNegative && filterDirectionsTo.contains(SearchDirection.top)) {
    if (input.elementAt(yIndex - 1).elementAt(xIndex) == charTarget) {
      returnData.data.add(NeighbourCollectionData(Vector2(xIndex, yIndex - 1), SearchDirection.top));
    }
  }
  // Top right (Assuming all lines are of equal length)
  if (xIndex + 1 < input.first.length && !(yIndex - 1).isNegative && filterDirectionsTo.contains(SearchDirection.topRight)) {
    if (input.elementAt(yIndex - 1).elementAt(xIndex + 1) == charTarget) {
      returnData.data.add(NeighbourCollectionData(Vector2(xIndex + 1, yIndex - 1), SearchDirection.topRight));
    }
  }
  // Left
  if (!(xIndex - 1).isNegative && filterDirectionsTo.contains(SearchDirection.left)) {
    if (input.elementAt(yIndex).elementAt(xIndex - 1) == charTarget) {
      returnData.data.add(NeighbourCollectionData(Vector2(xIndex - 1, yIndex), SearchDirection.left));
    }
  }
  // Right (Assuming all lines are of equal length)
  if (xIndex + 1 < input.first.length && filterDirectionsTo.contains(SearchDirection.right)) {
    if (input.elementAt(yIndex).elementAt(xIndex + 1) == charTarget) {
      returnData.data.add(NeighbourCollectionData(Vector2(xIndex + 1, yIndex), SearchDirection.right));
    }
  }
  // Bottom left (Assuming all lines are of equal length)
  if (!(xIndex - 1).isNegative && yIndex + 1 < input.length && filterDirectionsTo.contains(SearchDirection.bottomLeft)) {
    if (input.elementAt(yIndex + 1).elementAt(xIndex - 1) == charTarget) {
      returnData.data.add(NeighbourCollectionData(Vector2(xIndex - 1, yIndex + 1), SearchDirection.bottomLeft));
    }
  }
  // Bottom (Assuming all lines are of equal length)
  if (yIndex + 1 < input.length && filterDirectionsTo.contains(SearchDirection.bottom)) {
    if (input.elementAt(yIndex + 1).elementAt(xIndex) == charTarget) {
      returnData.data.add(NeighbourCollectionData(Vector2(xIndex, yIndex + 1), SearchDirection.bottom));
    }
  }
  // Bottom right (Assuming all lines are of equal length)
  if (xIndex + 1 < input.first.length && yIndex + 1 < input.length && filterDirectionsTo.contains(SearchDirection.bottomRight)) {
    if (input.elementAt(yIndex + 1).elementAt(xIndex + 1) == charTarget) {
      returnData.data.add(NeighbourCollectionData(Vector2(xIndex + 1, yIndex + 1), SearchDirection.bottomRight));
    }
  }

  return returnData;
}