part of 'satelite_images_cubit.dart';

@freezed
class SateliteImagesState with _$SateliteImagesState {
  const factory SateliteImagesState.initial({
    @Default(BlocState.initial) BlocState status,
    List<String>? images,
    String? message,
  }) = _Initial;
}
