import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:clima/services/clima_service.dart';
import 'package:clima/widgets/item_clima.dart';
import 'package:clima/widgets/item_pronostico.dart';

class Inicio extends StatefulWidget {
  const Inicio({super.key});

  @override
  State<Inicio> createState() => _InicioState();
}

class _InicioState extends State<Inicio> with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  String ciudad = "San Salvador";
  String temperatura = "";
  String descripcion = "";
  String humedad = "";
  String viento = "";
  String sensacion = "";

  double tempNumero = 0;

  List pronostico = [];

  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    _animation = Tween<double>(
      begin: 0.9,
      end: 1.2,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    obtenerDatos();
    obtenerPronostico();
  }

  Color obtenerColorFondo() {
    if (tempNumero <= 0) return const Color(0xff83a4d4); // nieve
    if (tempNumero <= 15) return const Color(0xff757F9A); // frío
    if (tempNumero <= 25) return const Color(0xff4facfe); // normal
    return const Color(0xffff7e5f); // calor
  }

  Future<void> obtenerDatos() async {
    try {
      final response = await ClimaService.obtenerClima(ciudad);
      final data = json.decode(response.body);

      ///VALIDACIÓN
      if (response.statusCode != 200 || data["cod"] != 200) {
        mostrarError("Ciudad no válida");
        return;
      }

      setState(() {
        tempNumero = data["main"]["temp"].toDouble();
        double feels = data["main"]["feels_like"].toDouble();

        temperatura = "${tempNumero.round()}°C";
        sensacion = "Sensación: ${feels.round()}°C";
        descripcion = data["weather"][0]["main"];
        humedad = "${data["main"]["humidity"]}%";
        viento = "${data["wind"]["speed"]} km/h";
      });
    } catch (e) {
      mostrarError("Error de conexión");
    }
  }

  Future<void> obtenerPronostico() async {
    try {
      final response = await ClimaService.obtenerPronostico(ciudad);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        setState(() {
          pronostico = data["list"];
        });
      }
    } catch (e) {
      print(e);
    }
  }

  String obtenerImagen(String clima, double temp) {
    clima = clima.toLowerCase();

    if (temp <= 0) return "assets/images/snow.png";
    if (clima.contains("rain")) return "assets/images/rain.png";
    if (clima.contains("thunderstorm")) return "assets/images/thunderstorm.png";
    if (clima.contains("cloud")) return "assets/images/clouds.png";
    if (temp > 25) return "assets/images/clear.png";

    return "assets/images/clouds.png";
  }

  Future<void> buscarCiudad() async {
    String texto = _searchController.text.trim();

    if (texto.isEmpty) return;

    try {
      final response = await ClimaService.obtenerClima(texto);
      final data = json.decode(response.body);

      ///VALIDACIÓN REAL
      if (response.statusCode == 200 && data["cod"] == 200) {
        setState(() {
          ciudad = texto;
        });

        obtenerDatos();
        obtenerPronostico();
      } else {
        mostrarError("Ciudad no válida");
        _searchController.clear();
      }
    } catch (e) {
      mostrarError("Error de conexión");
      _searchController.clear();
    }
  }

  void mostrarError(String mensaje) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(mensaje), backgroundColor: Colors.red),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: obtenerColorFondo(),

      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Clima Mundial",
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.5,
            color: Colors.white,
          ),
        ),
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: _searchController,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: "Buscar ciudad...",
                  hintStyle: const TextStyle(color: Colors.white70),
                  prefixIcon: const Icon(Icons.search, color: Colors.white),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.send, color: Colors.white),
                    onPressed: buscarCiudad,
                  ),
                  filled: true,
                  fillColor: Colors.white24,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide.none,
                  ),
                ),
                onSubmitted: (_) => buscarCiudad(),
              ),

              const SizedBox(height: 20),

              Text(
                ciudad,
                style: const TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),

              const SizedBox(height: 20),

              AnimatedOpacity(
                duration: const Duration(seconds: 1),
                opacity: temperatura.isEmpty ? 0 : 1,
                child: Container(
                  height: 220,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    gradient: LinearGradient(
                      colors: [obtenerColorFondo(), Colors.blueAccent],
                    ),
                  ),

                  child: Stack(
                    children: [
                      AnimatedBuilder(
                        animation: _animation,
                        builder: (context, child) {
                          return Positioned(
                            top: 50,
                            left: 50,
                            child: Transform.scale(
                              scale: _animation.value,
                              child: Image.asset(
                                obtenerImagen(descripcion, tempNumero),
                                width: 120,
                              ),
                            ),
                          );
                        },
                      ),

                      ///TEMPERATURA
                      Positioned(
                        top: 30,
                        right: 20,
                        child: Text(
                          temperatura,
                          style: const TextStyle(
                            fontSize: 50,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Positioned(
                        top: 90,
                        right: 20,
                        child: Text(
                          sensacion,
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.white70,
                          ),
                        ),
                      ),

                      ///DESCRIPCIÓN
                      Positioned(
                        bottom: 20,
                        left: 20,
                        child: Text(
                          descripcion,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 30),

              ///INFO
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ItemClima(
                    titulo: "Viento",
                    valor: viento,
                    imagen: "assets/images/wind.png",
                  ),
                  ItemClima(
                    titulo: "Humedad",
                    valor: humedad,
                    imagen: "assets/images/humidity.png",
                  ),
                  ItemClima(
                    titulo: "Temp",
                    valor: temperatura,
                    imagen: "assets/images/temp.png",
                  ),
                ],
              ),

              const SizedBox(height: 30),

              /// PRONÓSTICO
              const Text(
                "Próximas horas",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),

              const SizedBox(height: 10),

              SizedBox(
                height: 120,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: pronostico.length > 8 ? 8 : pronostico.length,
                  itemBuilder: (context, index) {
                    final item = pronostico[index];

                    double temp = item["main"]["temp"].toDouble();
                    String clima = item["weather"][0]["main"];
                    String hora24 = item["dt_txt"].substring(11, 16);

                    int hora = int.parse(hora24.substring(0, 2));
                    int minutos = int.parse(hora24.substring(3, 5));

                    String periodo = hora >= 12 ? "PM" : "AM";

                    hora = hora % 12;
                    if (hora == 0) hora = 12;

                    String horaFinal =
                        "${hora}:${minutos.toString().padLeft(2, '0')} $periodo";

                    ///  PROBABILIDAD DE LLUVIA (0.32 → 32%)
                    double probLluvia =
                        ((item["pop"] ?? 0.0) as num).toDouble() * 100;

                    return ItemPronostico(
                      hora: horaFinal,
                      temp: "${temp.round()}°C",
                      imagen: obtenerImagen(clima, temp),

                      ///  NUEVO
                      lluvia: "${probLluvia.toStringAsFixed(0)}%",
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
