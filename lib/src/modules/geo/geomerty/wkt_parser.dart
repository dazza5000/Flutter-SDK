part of backendless_sdk;

class WKTParser {
  static const _SPACE = " ";
  static const _POINT_COORDINATED_LEN = 2;

  SpatialReferenceSystem srs;

  WKTParser({SpatialReferenceSystem srs}) {
    this.srs = srs != null ? srs : SpatialReferenceManager.defaultSrs;
  }

  T read<T extends Geometry>(String wellKnownText) {
    final formatterWKT = wellKnownText.toUpperCase();
    final type = formatterWKT.split(" ").first;

    switch (type) {
      case Point.wktType:
        return _readPoint(formatterWKT);
      case LineString.wktType:
        return _readLineString(formatterWKT);
      case Polygon.wktType:
        return _readPolygon(formatterWKT);
      default:
        return null;
    }
  }

  Geometry _readPoint(String wellKnownText) {
    final cleanedFromType =
        wellKnownText.replaceAll(Point.wktType + WKTParser._SPACE, "");
    final rawPoint = cleanedFromType.substring(1, cleanedFromType.length - 1);
    return _getPoint(rawPoint);
  }

  Point _getPoint(String rawPoint) {
    final rawCoordinates = rawPoint.trim().split(WKTParser._SPACE);
    if (rawCoordinates.length != _POINT_COORDINATED_LEN) {
      return null;
    }

    final x = double.parse(rawCoordinates.first);
    final y = double.parse(rawCoordinates.last);

    return Point(x: x, y: y, srs: srs);
  }

  Geometry _readLineString(String wellKnownText) {
    final cleanedFromType =
        wellKnownText.replaceAll(LineString.wktType + WKTParser._SPACE, "");
    final rawLineString =
        cleanedFromType.substring(1, cleanedFromType.length - 1);
    return _getLineString(rawLineString);
  }

  LineString _getLineString(String rawLineString) {
    final rawPoints = rawLineString.split(", ");
    final points = rawPoints.map(_getPoint).toList();

    return LineString(points: points, srs: srs);
  }

  Geometry _readPolygon(String wellKnownText) {
    final cleanedFromType =
        wellKnownText.replaceAll(Polygon.wktType + WKTParser._SPACE, "");
    final rawPolygon = cleanedFromType.substring(1, cleanedFromType.length - 1);

    return _getPolygon(rawPolygon);
  }

  Polygon _getPolygon(String rawPolygon) {
    final regexp = RegExp(r"\([^)]+\)");
    final matches = regexp.allMatches(rawPolygon).toList();

    final lineStrings = matches
        .map((m) => rawPolygon.substring(m.start, m.end))
        .map((matchedLine) => matchedLine.substring(1, matchedLine.length - 1))
        .map(_getLineString)
        .toList();

    return Polygon(
        boundary: lineStrings.first, holes: lineStrings.sublist(1), srs: srs);
  }
}