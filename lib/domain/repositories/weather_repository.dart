import 'package:dartz/dartz.dart';
import 'package:weather_app/domain/entities/weather.dart';

import '../../data/failure.dart';

// to be implemented in the data layer
abstract class WeatherRepository {
  Future<Either<Failure, Weather>> getCurrentWeather(String cityName);
}
