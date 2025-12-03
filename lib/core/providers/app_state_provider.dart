import 'package:flutter/foundation.dart';
import '../models/batch.dart';
import '../models/step.dart';
import '../models/user.dart';
import '../services/api_service.dart';
import '../models/traceability_event.dart';

class AppStateProvider extends ChangeNotifier {
  final ApiService _apiService = ApiService();

  // Estado actual
  Batch? _currentBatch;
  List<Step> _currentSteps = [];
  List<CompanyInfo> _companies = [];
  List<User> _allUsers = [];
  int _selectedNavIndex = 0;

  BlockchainStatus _parseBlockchainStatus(String? status) {
    switch (status?.toUpperCase()) {
      case 'CONFIRMED':
        return BlockchainStatus.confirmed;
      case 'FAILED':
        return BlockchainStatus.failed;
      case 'PENDING':
      default:
        return BlockchainStatus.pending;
    }
  }

  // Getters
  Batch? get currentBatch => _currentBatch;
  List<Step> get currentSteps => _currentSteps;
  List<CompanyInfo> get companies => _companies;
  List<User> get allUsers => _allUsers;
  int get selectedNavIndex => _selectedNavIndex;
  ApiService get apiService => _apiService;

  // Setters
  void setSelectedNavIndex(int index) {
    _selectedNavIndex = index;
    notifyListeners();
  }

  // Cargar datos del lote
  Future<void> loadBatchData(String lotId) async {
    try {
      // Cargar eventos públicos
      final events = await _apiService.getPublicEvents(lotId);

      // Mapear eventos a Steps
      _currentSteps =
          events.map((e) {
            final dateTime = DateTime.tryParse(e.eventDate) ?? DateTime.now();
            return Step(
              id: e.eventId,
              lotId: lotId,
              userId: e.actorName ?? 'Desconocido',
              stepType: e.eventType,
              stepDate: dateTime.toIso8601String().split('T')[0],
              stepTime: '${dateTime.hour}:${dateTime.minute.toString().padLeft(2, '0')}',
              location: e.location?.toString() ?? 'Ubicación no disponible',
              latitude: e.location?.latitude,
              longitude: e.location?.longitude,
              observations: e.description ?? '',
              hash: e.txHash ?? '',
              blockchainStatus: _parseBlockchainStatus(e.blockchainStatus),
            );
          }).toList();

      // Extraer empresas únicas
      final uniqueCompanies = <String, CompanyInfo>{};
      for (var e in events) {
        if (e.enterpriseId != null && e.enterpriseName != null) {
          uniqueCompanies[e.enterpriseId!] = CompanyInfo(
            id: e.enterpriseId!,
            name: e.enterpriseName!,
            logoUrl: e.enterpriseLogoUrl,
          );
        }
      }
      _companies = uniqueCompanies.values.toList();

      // Crear un Batch dummy con la información disponible
      // En una implementación real, deberíamos tener un endpoint para obtener detalles del lote público
      _currentBatch = Batch(
        id: lotId,
        lotName: 'Lote $lotId', // Placeholder
        farmName:
            _currentSteps.isNotEmpty
                ? _currentSteps.first.userId
                : 'Desconocido',
        variety: 'N/A',
        harvestDate:
            _currentSteps.isNotEmpty ? _currentSteps.first.stepDate : '',
        createdDate:
            _currentSteps.isNotEmpty ? _currentSteps.first.stepDate : '',
        state: 'Activo', // Asumimos activo si podemos ver el historial
        imageUrl: '',
        producerId: '',
      );

      notifyListeners();
    } catch (e) {
      debugPrint('Error loading batch data: $e');
      rethrow;
    }
  }

  // Limpiar datos actuales
  void clearCurrentBatch() {
    _currentBatch = null;
    _currentSteps = [];
    _companies = [];
    notifyListeners();
  }

  // Obtener usuario por ID
  User? getUserById(String userId) {
    try {
      return _allUsers.firstWhere((u) => u.id == userId);
    } catch (e) {
      return null;
    }
  }

  // Navegar a la pestaña de Timeline
  void navigateToTimeline() {
    _selectedNavIndex = 0;
    notifyListeners();
  }

  // Navegar a la pestaña de Mapa
  void navigateToMap() {
    _selectedNavIndex = 1;
    notifyListeners();
  }

  // Navegar a la pestaña de Empresas
  void navigateToCompanies() {
    _selectedNavIndex = 2;
    notifyListeners();
  }
}

class CompanyInfo {
  final String id;
  final String name;
  final String? logoUrl;

  CompanyInfo({required this.id, required this.name, this.logoUrl});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CompanyInfo &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;
}
