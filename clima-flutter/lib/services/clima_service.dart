import 'package:http/http.dart' as http;

class ClimaService {
  static const String apiKey = "44e431b59ec630d7a0b2224ca7eae50a";

  //Clima actual
  static Future<http.Response> obtenerClima(String ciudad) {
    final url = Uri.parse(
      "https://api.openweathermap.org/data/2.5/weather?q=$ciudad&appid=$apiKey&units=metric&lang=es",
    );

    return http.get(url);
  }

  // Pronóstico
  static Future<http.Response> obtenerPronostico(String ciudad) {
    final url = Uri.parse(
      "https://api.openweathermap.org/data/2.5/forecast?q=$ciudad&appid=$apiKey&units=metric&lang=es",
    );

    return http.get(url);
  }
}
