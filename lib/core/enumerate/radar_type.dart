enum RadarType {
  cmax,
  qpf,
  cmaxssa,
  cmaxhwind,
  cappi05,
  cappi1,
  sri,
  pac1,
  pac6,
  pac12,
  pac24,
  ;

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
}
