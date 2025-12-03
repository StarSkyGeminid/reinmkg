import 'radar_unit.dart';

enum RadarType {
  cmax(RadarUnit.dbz),
  cmaxssa(RadarUnit.dbz),
  cmaxhwind(RadarUnit.dbz),
  cappi05(RadarUnit.dbz),
  cappi1(RadarUnit.dbz),
  qpf(RadarUnit.mm),
  sri(RadarUnit.mmhr),
  pac1(RadarUnit.mm),
  pac6(RadarUnit.mm),
  pac12(RadarUnit.mm),
  pac24(RadarUnit.mm);

  final RadarUnit unit;

  const RadarType(this.unit);

  bool get isCmax => this == cmax;
  bool get isQpf => this == qpf;
  bool get isCmaxSsa => this == cmaxssa;
  bool get isCmaxHwind => this == cmaxhwind;
  bool get isCappi05 => this == cappi05;
  bool get isCappi1 => this == cappi1;
  bool get isSri => this == sri;
  bool get isPac1 => this == pac1;
  bool get isPac6 => this == pac6;
  bool get isPac12 => this == pac12;
  bool get isPac24 => this == pac24;

  String get displayName {
    switch (this) {
      case RadarType.cmax:
        return 'CMAX';
      case RadarType.qpf:
        return 'QPF';
      case RadarType.cmaxssa:
        return 'CMAX SSA';
      case RadarType.cmaxhwind:
        return 'CMAX HWIND';
      case RadarType.cappi05:
        return 'CAPPI 0.5km';
      case RadarType.cappi1:
        return 'CAPPI 1km';
      case RadarType.sri:
        return 'SRI';
      case RadarType.pac1:
        return 'PAC 1hr';
      case RadarType.pac6:
        return 'PAC 6hr';
      case RadarType.pac12:
        return 'PAC 12hr';
      case RadarType.pac24:
        return 'PAC 24hr';
    }
  }
}
