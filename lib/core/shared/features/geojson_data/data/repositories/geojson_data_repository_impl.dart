import 'package:reinmkg/core/core.dart';

class RegionBorderOverlayRepositoryImpl implements GeojsonDataRepository {
  final LocalGeojsonDataService localService;

  RegionBorderOverlayRepositoryImpl(this.localService);

  @override
  Future<String> getRegionBorder() {
    return localService.getRegionBorder();
  }

  @override
  Future<String> getFaultLine() {
    return localService.getFaultLine();
  }

  @override
  Future<String> getMaritimeBoundary() {
    return localService.getMaritimeBoundary();
  }

  @override
  Future<String> getProvinceBorder() {
    return localService.getProvinceBorder();
  }
}
