import 'package:flutter/material.dart';

class ItemClima extends StatelessWidget {
  final String titulo;
  final String valor;
  final String imagen;

  const ItemClima({
    super.key,
    required this.titulo,
    required this.valor,
    required this.imagen,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(titulo, style: const TextStyle(color: Colors.black54)),

        const SizedBox(height: 8),

        Container(
          height: 60,
          width: 60,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: const Color(0xffE0E8FB),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Image.asset(imagen),
        ),

        const SizedBox(height: 8),

        Text(valor, style: const TextStyle(fontWeight: FontWeight.bold)),
      ],
    );
  }
}
