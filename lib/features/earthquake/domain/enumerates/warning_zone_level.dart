enum WarningZoneLevel {
  waspada('WASPADA'),
  siaga('SIAGA'),
  awas('AWAS');

  final String name;

  const WarningZoneLevel(this.name);

  factory WarningZoneLevel.fromString(String value) {
    switch (value.toUpperCase()) {
      case "AWAS":
        return WarningZoneLevel.awas;
      case "SIAGA":
        return WarningZoneLevel.siaga;
      case "WASPADA":
        return WarningZoneLevel.waspada;
      default:
        return WarningZoneLevel.waspada;
    }
  }

  bool get isWaspada => this == WarningZoneLevel.waspada;
  bool get isSiaga => this == WarningZoneLevel.siaga;
  bool get isAwas => this == WarningZoneLevel.awas;
}

extension WarningZoneLevelExtension on WarningZoneLevel {
  String get instuction {
    switch (this) {
      case (WarningZoneLevel.waspada):
        return "Pemerintah Propinsi/Kab/Kota yang berada pada status \"Waspada\" diharap memperhatikan dan segera mengarahkan masyarakat untuk menjauhi pantai dan tepian sungai";
      case (WarningZoneLevel.siaga):
        return "Pemerintah Propinsi/Kab/Kota yang berada pada status \"Siaga\" diharap memperhatikan dan segera mengarahkan masyarakat untuk melakukan evakuasi";
      case (WarningZoneLevel.awas):
        return "Pemerintah Propinsi/Kab/Kota yang berada pada status \"Awas\" diharap memperhatikan dan segera mengarahkan masyarakat untuk melakukan evakuasi menyeluruh";
    }
  }
}
