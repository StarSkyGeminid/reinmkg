import '../../domain/entities/satelite_entity.dart';

class SateliteModel extends SateliteEntity {
  const SateliteModel({
    required super.id,
    required super.imageUrl,
    required super.time,
  });

  factory SateliteModel.fromPath(String path) {
    final id = path.split('.').first;

    final url = 'https://api-apps.bmkg.go.id/storage/satelit/$path';

    return SateliteModel(
      id: id,
      imageUrl: url,
      time: _parseDate(path).toLocal(),
    );
  }

  static DateTime _parseDate(String fileName) {
    final regExp = RegExp(
      r'^H08_ET_Indonesia_(\d{4})(\d{2})(\d{2})(\d{2})(\d{2})',
    );

    var match = regExp.firstMatch(fileName);

    if (match == null) {
      throw FormatException('Invalid file name format: $fileName');
    }

    String year = match.group(1)!;
    String month = match.group(2)!;
    String day = match.group(3)!;
    String hour = match.group(4)!;
    String minute = match.group(5)!;

    return DateTime.utc(
      int.parse(year),
      int.parse(month),
      int.parse(day),
      int.parse(hour),
      int.parse(minute),
    );
  }
}
