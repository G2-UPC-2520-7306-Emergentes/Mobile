import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:url_launcher/url_launcher.dart';

class QRScannerScreen extends StatefulWidget {
  const QRScannerScreen({super.key});

  @override
  State<QRScannerScreen> createState() => _QRScannerScreenState();
}

class _QRScannerScreenState extends State<QRScannerScreen> {
  final MobileScannerController _controller = MobileScannerController();
  bool _isProcessing = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Escanear Código QR'),
      ),
      body: MobileScanner(
        controller: _controller,
        onDetect: (capture) async {
          if (_isProcessing) return;

          final List<Barcode> barcodes = capture.barcodes;
          if (barcodes.isNotEmpty) {
            final String? code = barcodes.first.rawValue;
            if (code != null) {
              setState(() {
                _isProcessing = true;
              });

              final Uri? url = Uri.tryParse(code);
              if (url != null && await canLaunchUrl(url)) {
                await launchUrl(url);
                // Vuelve a la pantalla anterior después de lanzar la URL
                if (mounted) {
                  Navigator.of(context).pop();
                }
              } else {
                // Si no es una URL válida, muestra un mensaje y reanuda el escaneo
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Código QR no válido')),
                );
                setState(() {
                  _isProcessing = false;
                });
              }
            }
          }
        },
      ),
    );
  }
}
