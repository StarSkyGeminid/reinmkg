import 'package:reinmkg/domain/domain.dart';

class SetSelectedRadar {
  final RadarRepository _repository;

  SetSelectedRadar(this._repository);

  void call({required RadarEntity params}) {
    return _repository.setSelected(params);
  }
}
