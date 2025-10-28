import 'package:flutter/material.dart';

/// Boton adaptable reutilizable para las acciones primarias de la app.
class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    super.key,
    required this.label,
    this.onPressed,
    this.icon,
  });

  final String label;
  final VoidCallback? onPressed;
  final Widget? icon;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return ElevatedButton(
      onPressed: onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[icon!, const SizedBox(width: 10)],
          Text(
            label,
            style: textTheme.labelLarge?.copyWith(letterSpacing: 0.3),
          ),
        ],
      ),
    );
  }
}
