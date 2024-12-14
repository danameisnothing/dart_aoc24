import 'dart:io';

import 'package:dart_aoc24/utils/utils.dart';

// Ignore the no inheritance stuff, this is just a quick and dirty job anyway
abstract class _Tile {
  Vector2 pos = Vector2.zero();
  List<String> attributes = [];
}

class _WorldTile extends _Tile {
  bool collidesWithPlayer;

  _WorldTile(Vector2 pos, this.collidesWithPlayer) {
    super.pos = pos;
  }
}

class _SimulatedPlayer extends _Tile {
  Vector2 dir;

  _SimulatedPlayer(Vector2 pos, this.dir) {
    super.pos = pos;
  }
}

// No neat constants here

/*bool _isXShapedMAS(List<List<String>> data, Vector2 origin) {
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
}*/

List<_Tile> _loadMap(List<List<String>> mapData) {
  final world = <_Tile>[];

  for (int y = 0; y < mapData.length; y++) {
    for (int x = 0; x < mapData.elementAt(y).length; x++) {
      String charMap = mapData.elementAt(y).elementAt(x);

      switch (charMap) {
        case ".":
          world.add(_WorldTile(Vector2(x, y), false));
          break;
        case "^":
          world.add(_SimulatedPlayer(Vector2(x, y), Vector2(0, -1)));
          world.add(_WorldTile(Vector2(x, y), false));
          break;
        case "#":
          world.add(_WorldTile(Vector2(x, y), true));
          break;
        default:
          throw UnimplementedError();
      }
    }
  }

  return world;
}

bool _tick(List<_Tile> world) {
  final farthestObjectTmp = List<_Tile>.from(world)..sort((a, b) => b.pos.x.compareTo(a.pos.x) + b.pos.y.compareTo(a.pos.y));
  /// The farthest tile from the top left of the world
  final farthestObject = farthestObjectTmp.first;

  for (_Tile element in world) {
    if (element is _SimulatedPlayer) {
      final prevPosition = element.pos;
      final targetPosition = element.pos + element.dir;
      /// The tile "below" the simulated player
      final baseTile = world.firstWhere((el) => el.pos == prevPosition && el is! _SimulatedPlayer);

      if (!baseTile.attributes.contains("stepped")) baseTile.attributes.add("stepped");

      if (targetPosition.x < 0 || targetPosition.x > farthestObject.pos.x || targetPosition.y < 0 || targetPosition.y > farthestObject.pos.y) return false;

      // Checks if we will collide with anything if we move in the same direction as dir
      if ((world.firstWhere((el) => el.pos == targetPosition) as _WorldTile).collidesWithPlayer) element.dir = Vector2(-element.dir.y, element.dir.x);

      element.pos += element.dir;
    }
  }
  return true;
}

void execD6P1() {
  List<_Tile> world = _loadMap(File("lib/solutions/daysix/partone/input.txt").readAsLinesSync().map((xAxis) => xAxis.split("")).toList());
  
  while (_tick(world)) {}

  int total = world.where((el) => el.attributes.contains("stepped")).length;

  print(total);
}