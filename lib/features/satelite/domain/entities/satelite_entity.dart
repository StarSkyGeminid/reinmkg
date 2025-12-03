import 'package:equatable/equatable.dart';

class SateliteEntity extends Equatable {
  final String id;
  final String imageUrl;
  final DateTime time;

  const SateliteEntity({
    required this.id,
    required this.imageUrl,
    required this.time,
  });

  @override
  List<Object?> get props => [id, imageUrl, time];
}
