import 'package:flutter/material.dart';
// Asegúrate de importar la nueva pantalla
import 'package:flutter_application_1/features/home/presentation/qr_scanner_screen.dart'; 

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: const Center(
        child: Text('Presiona el botón para escanear un QR'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const QRScannerScreen(),
            ),
          );
        },
        child: const Icon(Icons.qr_code_scanner),
      ),
    );
  }
}
