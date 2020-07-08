import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:new_weathe_sapp/model/model.dart';

String getWeatherData(String coordinat) {
  return "https://api.darksky.net/forecast/7a3a30979a60318eca99f6c43f746ad3/${coordinat}?exclude=flags&units=si";
}

String getWeatherDataTime(String coordinat, String times) {
  return "https://api.darksky.net/forecast/7a3a30979a60318eca99f6c43f746ad3/${coordinat},$times?exclude=flags&units=si";
}

Future<WeatherData> getWeatherDataAPI() async {
  final _locationData = await Geolocator()
      .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  var apilinks = getWeatherData(_locationData.latitude.toString() +
      "," +
      _locationData.longitude.toString());
  final response = await http.get(apilinks);
  print(apilinks);
  if (response.statusCode == 200) {
    WeatherData weatherData = WeatherData();
    weatherData = weatherDataFromJson(response.body);
    // double weatherid = weatherData.currently.temperature;

    return weatherDataFromJson(response.body);
  }
}

Future<WeatherData> getWeatherTimeDataAPI(String times) async {
  final _locationData = await Geolocator()
      .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  var apilinks = getWeatherDataTime(
      _locationData.latitude.toString() +
          "," +
          _locationData.longitude.toString(),
      times);
  final response = await http.get(apilinks);
  print(apilinks);
  if (response.statusCode == 200) {
    WeatherData weatherData = WeatherData();
    weatherData = weatherDataFromJson(response.body);
    // double weatherid = weatherData.currently.temperature;

    return weatherDataFromJson(response.body);
  }
}

Future<String> getLocations() async {
  final _locationData = await Geolocator().getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
      locationPermissionLevel: GeolocationPermission.locationAlways);
  List<Placemark> placemark = await Geolocator().placemarkFromCoordinates(
      _locationData.latitude, _locationData.longitude);
  return placemark[0].locality;
}

Future<List<Currently>> getCurrentsListAPI() async {
  WeatherData weatherData = await getWeatherDataAPI();
  List<Currently> currentList;
  if (weatherData != null) {
    currentList = weatherData.hourly.data;
    return currentList;
  }
  return null;
}
