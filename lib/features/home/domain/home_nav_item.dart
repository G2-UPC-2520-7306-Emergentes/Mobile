import 'package:flutter/material.dart';

enum HomeNavItem {
  history,
  map,
  companies,
  help;

  String get label {
    switch (this) {
      case HomeNavItem.history:
        return 'History';
      case HomeNavItem.map:
        return 'Map';
      case HomeNavItem.companies:
        return 'Companies';
      case HomeNavItem.help:
        return 'Help';
    }
  }

  IconData get icon {
    switch (this) {
      case HomeNavItem.history:
        return Icons.receipt_long_rounded;
      case HomeNavItem.map:
        return Icons.map_rounded;
      case HomeNavItem.companies:
        return Icons.apartment_rounded;
      case HomeNavItem.help:
        return Icons.help_center_rounded;
    }
  }
}
