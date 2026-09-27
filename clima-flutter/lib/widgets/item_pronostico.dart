import 'package:flutter/material.dart';

class ItemPronostico extends StatelessWidget {
  final String hora;
  final String temp;
  final String imagen;
  final String lluvia; // 👈 NUEVO

  const ItemPronostico({
    super.key,
    required this.hora,
    required this.temp,
    required this.imagen,
    required this.lluvia,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 90,
      margin: const EdgeInsets.only(right: 10),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white24,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          /// HORA
          Flexible(
            child: Text(
              hora,
              style: const TextStyle(color: Colors.white, fontSize: 12),
              overflow: TextOverflow.ellipsis,
            ),
          ),

          const SizedBox(height: 5),

          /// IMAGEN
          Image.asset(imagen, width: 35),

          const SizedBox(height: 5),

          /// TEMPERATURA
          Flexible(
            child: Text(
              temp,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),

          const SizedBox(height: 3),

          /// LLUVIA
          Flexible(
            child: Text(
              "🌧 $lluvia",
              style: const TextStyle(color: Colors.white70, fontSize: 11),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
