import 'package:flutter/material.dart';
import 'package:clima/screens/inicio.dart';

class Welcome extends StatelessWidget {
  const Welcome({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        width: size.width,
        height: size.height,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xff90B2F9), Color(0xff5A8DEE)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/images/welcome.png",
              height: 200,
              errorBuilder: (context, error, stackTrace) {
                return const Icon(Icons.cloud, size: 120, color: Colors.white);
              },
            ),

            const SizedBox(height: 40),

            ///  TEXTO
            const Text(
              "Clima El Salvador",
              style: TextStyle(
                fontSize: 28,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            const Text(
              "Consulta el clima en tiempo real",
              style: TextStyle(fontSize: 16, color: Colors.white70),
            ),

            const SizedBox(height: 50),

            GestureDetector(
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => const Inicio()),
                );
              },
              child: Container(
                width: size.width * 0.7,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: const Center(
                  child: Text(
                    "Empezar",
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
