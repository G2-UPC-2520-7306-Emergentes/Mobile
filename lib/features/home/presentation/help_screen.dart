import 'package:flutter/material.dart';

class HelpScreen extends StatelessWidget {
  const HelpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // AppBar
              Container(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Text(
                  'Ayuda',
                  style: theme.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              // ¿Qué es FoodChain?
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.info_outline, color: colorScheme.primary, size: 20),
                        const SizedBox(width: 8),
                        Text(
                          '¿Qué es FoodChain?',
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'FoodChain es una aplicación de trazabilidad que te permite conocer el historial completo de un producto alimenticio, desde su origen hasta su destino final. Utilizando tecnología blockchain, garantizamos que la información es verificable y confiable.',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: Colors.grey[700],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              // Cómo usar la app
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.help_outline, color: colorScheme.primary, size: 20),
                        const SizedBox(width: 8),
                        Text(
                          'Cómo usar la aplicación',
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    _HelpStep(
                      number: '1',
                      title: 'Escanea el código QR',
                      description:
                          'Usa el botón "Scan QR Code" en la pantalla principal para escanear el código QR del producto.',
                      icon: Icons.qr_code_scanner_rounded,
                      color: colorScheme.primary,
                    ),
                    const SizedBox(height: 16),
                    _HelpStep(
                      number: '2',
                      title: 'Visualiza el historial',
                      description:
                          'Una vez escaneado, verás la línea de tiempo completa del producto con todos sus eventos.',
                      icon: Icons.history_rounded,
                      color: colorScheme.primary,
                    ),
                    const SizedBox(height: 16),
                    _HelpStep(
                      number: '3',
                      title: 'Explora detalles',
                      description:
                          'Usa las pestañas para ver el mapa, las empresas participantes y más información.',
                      icon: Icons.explore_rounded,
                      color: colorScheme.primary,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              // Preguntas frecuentes
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.question_answer, color: colorScheme.primary, size: 20),
                        const SizedBox(width: 8),
                        Text(
                          'Preguntas frecuentes',
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    _FAQItem(
                      question: '¿Es segura la información?',
                      answer:
                          'Sí, toda la información está verificada y almacenada en blockchain, lo que garantiza que no puede ser modificada.',
                    ),
                    const Divider(height: 24),
                    _FAQItem(
                      question: '¿Qué significa "verificado"?',
                      answer:
                          'Significa que el evento ha sido registrado en blockchain y ha pasado por un proceso de validación.',
                    ),
                    const Divider(height: 24),
                    _FAQItem(
                      question: '¿Puedo ver productos sin escanear?',
                      answer:
                          'No, necesitas escanear el código QR del producto para acceder a su información específica.',
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              // Contacto
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.contact_support, color: colorScheme.primary, size: 20),
                        const SizedBox(width: 8),
                        Text(
                          'Contacto',
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Text(
                      '¿Tienes más preguntas? Contáctanos:',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: Colors.grey[700],
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Email: support@foodchain.com',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: colorScheme.primary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}

class _HelpStep extends StatelessWidget {
  final String number;
  final String title;
  final String description;
  final IconData icon;
  final Color color;

  const _HelpStep({
    required this.number,
    required this.title,
    required this.description,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text(
              number,
              style: TextStyle(
                color: color,
                fontWeight: FontWeight.w700,
                fontSize: 18,
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                description,
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _FAQItem extends StatelessWidget {
  final String question;
  final String answer;

  const _FAQItem({
    required this.question,
    required this.answer,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          question,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 15,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          answer,
          style: TextStyle(
            color: Colors.grey[600],
            fontSize: 14,
          ),
        ),
      ],
    );
  }
}
