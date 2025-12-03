import 'package:froom/froom.dart';

import '../../domain/entities/daily_weather_entity.dart';

@Entity(tableName: 'dailyWeather', primaryKeys: ['time'])
class DailyWeatherModel extends DailyWeatherEntity {
  const DailyWeatherModel({
    super.time,
    super.weather,
    super.maxTemp,
    super.minTemp,
  });

  DailyWeatherModel copyWith({
    DateTime? time,
    int? weather,
    int? maxTemp,
    int? minTemp,
  }) => DailyWeatherModel(
    time: time ?? this.time,
    weather: weather ?? this.weather,
    maxTemp: maxTemp ?? this.maxTemp,
    minTemp: minTemp ?? this.minTemp,
  );

  DailyWeatherEntity get toEntity {
    return DailyWeatherEntity(
      time: time,
      weather: weather,
      maxTemp: maxTemp,
      minTemp: minTemp,
    );
  }
}
