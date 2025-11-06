import 'package:flutter/material.dart';

enum HomeNavItem {
  history,
  map,
  companies,
  help;

  String get label {
    switch (this) {
      case HomeNavItem.history:
        return 'Historial';
      case HomeNavItem.map:
        return 'Mapa';
      case HomeNavItem.companies:
        return 'Empresas';
      case HomeNavItem.help:
        return 'Ayuda';
    }
  }

  IconData get icon {
    switch (this) {
      case HomeNavItem.history:
        return Icons.history;
      case HomeNavItem.map:
        return Icons.map;
      case HomeNavItem.companies:
        return Icons.business;
      case HomeNavItem.help:
        return Icons.help_outline;
    }
  }
}
