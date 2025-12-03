enum WindDirection {
  north(0),
  northEast(45),
  east(90),
  southEast(135),
  south(180),
  southWest(225),
  west(270),
  northWest(315);

  final int angle;

  const WindDirection(this.angle);

  factory WindDirection.fromDegree(int degree) {
    switch (degree) {
      case < 45:
        return north;
      case < 90:
        return northEast;
      case < 135:
        return east;
      case < 180:
        return southEast;
      case < 225:
        return south;
      case < 270:
        return southWest;
      case < 315:
        return west;
      case <= 360:
        return northWest;
      default:
        return north;
    }
  }

  bool get isNorth => this == WindDirection.north;
  bool get isNorthEast => this == WindDirection.northEast;
  bool get isEast => this == WindDirection.east;
  bool get isSouthEast => this == WindDirection.southEast;
  bool get isSouth => this == WindDirection.south;
  bool get isSouthWest => this == WindDirection.southWest;
  bool get isWest => this == WindDirection.west;
  bool get isNorthWest => this == WindDirection.northWest;
}
