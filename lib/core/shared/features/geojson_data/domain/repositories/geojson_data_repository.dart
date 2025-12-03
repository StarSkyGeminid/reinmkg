abstract class GeojsonDataRepository {
  Future<String> getRegionBorder();

  Future<String> getFaultLine();

  Future<String> getMaritimeBoundary();

  Future<String> getProvinceBorder();
}
