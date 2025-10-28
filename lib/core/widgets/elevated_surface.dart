import 'package:flutter/material.dart';

/// Contenedor reutilizable con sombra y bordes redondeados.
class ElevatedSurface extends StatelessWidget {
  const ElevatedSurface({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(20),
    this.margin = EdgeInsets.zero,
    this.borderRadius = const BorderRadius.all(Radius.circular(24)),
  });

  final Widget child;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry margin;
  final BorderRadiusGeometry borderRadius;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      margin: margin,
      padding: padding,
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: borderRadius,
        boxShadow: [
          BoxShadow(
            color: colorScheme.primary.withValues(alpha: 0.08),
            offset: const Offset(0, 16),
            blurRadius: 48,
            spreadRadius: -24,
          ),
        ],
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.9),
          width: 1,
        ),
      ),
      child: child,
    );
  }
}
