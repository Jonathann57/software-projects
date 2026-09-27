import 'package:flutter/material.dart';

class TarjetaClima extends StatelessWidget {
  final String ciudad;
  final String temperatura;
  final String descripcion;
  final String imagen;

  const TarjetaClima({
    super.key,
    required this.ciudad,
    required this.temperatura,
    required this.descripcion,
    required this.imagen,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 220,
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xff90B2F9),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.withOpacity(0.5),
            blurRadius: 10,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Stack(
        children: [
          /// Imagen del clima
          Positioned(
            top: -30,
            left: 10,
            child: Image.asset(imagen, width: 140),
          ),

          /// Temperatura
          Positioned(
            top: 20,
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

          /// Descripción
          Positioned(
            bottom: 20,
            left: 20,
            child: Text(
              descripcion,
              style: const TextStyle(color: Colors.white, fontSize: 18),
            ),
          ),

          /// 📍 Ciudad
          Positioned(
            bottom: 50,
            left: 20,
            child: Text(
              ciudad,
              style: const TextStyle(color: Colors.white70, fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
