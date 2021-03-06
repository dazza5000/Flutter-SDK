part of backendless_sdk;

class GeoJSONParser {
  static const _TYPE = "type";
  static const _COORDINATES = "coordinates";

  SpatialReferenceSystem srs;

  GeoJSONParser({SpatialReferenceSystem srs}) {
    this.srs = srs != null ? srs : SpatialReferenceManager.defaultSrs;
  }

  T read<T extends Geometry>(String geoJson) {
    Map jsonMap = json.decode(geoJson);

    final type = jsonMap[GeoJSONParser._TYPE];
    final rawCoordinates = jsonMap[GeoJSONParser._COORDINATES] as List;

    switch (type) {
      case Point.geoJsonType:
        return _readPoint(rawCoordinates);
      case LineString.geoJsonType:
        return _readLineString(rawCoordinates);
      case Polygon.geoJsonType:
        return _readPolygon(rawCoordinates);
      default:
        return null;
    }
  }

  Geometry _readPoint(List rawCoordinates) {
    List<double> coordinates =
        List<double>.from(rawCoordinates.map((v) => v.toDouble()));

    return _getPoint(coordinates);
  }

  Point _getPoint(List<double> coordinates) {
    return Point(x: coordinates.first, y: coordinates.last, srs: srs);
  }

  Geometry _readLineString(List rawCoordinates) {
    List<List<double>> coordinates = List.from(rawCoordinates.map((pair) {
      return List<double>.from(pair.map((v) => v.toDouble()));
    }));

    return _getLineString(coordinates);
  }

  LineString _getLineString(List<List<double>> coordinates) {
    final points = coordinates.map(_getPoint).toList();

    return LineString(points: points, srs: srs);
  }

  Geometry _readPolygon(List rawCoordinates) {
    List<List<List<double>>> polygonCoordinates =
        List<List<List<double>>>.from(rawCoordinates.map((rawLineString) {
      return List<List<double>>.from(rawLineString.map((rawPoint) {
        return List<double>.from(rawPoint.map((v) => v.toDouble()));
      }));
    }));

    return _getPolygon(polygonCoordinates);
  }

  Polygon _getPolygon(List<List<List<double>>> coordinates) {
    List<LineString> lineStrings = coordinates.map(_getLineString).toList();

    return Polygon(
        boundary: lineStrings.first, holes: lineStrings.sublist(1), srs: srs);
  }
}
