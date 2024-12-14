class Vector2 {
  int x, y;

  Vector2(this.x, this.y);

  Vector2.zero() : x = 0, y = 0;
  Vector2.one() : x = 1, y = 1;

  @override
  String toString() => "Vector2($x, $y)";

  Vector2 operator -(Vector2 other) => Vector2(x - other.x, y - other.y);
  Vector2 operator +(Vector2 other) => Vector2(x + other.x, y + other.y);

  @override
  int get hashCode => x.hashCode + y.hashCode;
  
  @override
  bool operator ==(Object other) {
    if (other is! Vector2) return false;
    return x == other.x && y == other.y;
  }
}