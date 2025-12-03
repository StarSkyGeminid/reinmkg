import '../../domain/enumerate/wave_height.dart';

class MaritimeWaveItem {
  final String? id;
  final WaveHeight? today;
  final WaveHeight? h1;
  final WaveHeight? h2;
  final WaveHeight? h3;

  const MaritimeWaveItem({this.id, this.today, this.h1, this.h2, this.h3});
}
