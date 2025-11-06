import 'package:flutter/foundation.dart';
import '../models/batch.dart';
import '../models/step.dart';
import '../models/user.dart';
import '../services/fake_api_service.dart';

class AppStateProvider extends ChangeNotifier {
  final FakeApiService _apiService = FakeApiService();

  // Estado actual
  Batch? _currentBatch;
  List<Step> _currentSteps = [];
  List<User> _allUsers = [];
  int _selectedNavIndex = 0;

  // Getters
  Batch? get currentBatch => _currentBatch;
  List<Step> get currentSteps => _currentSteps;
  List<User> get allUsers => _allUsers;
  int get selectedNavIndex => _selectedNavIndex;
  FakeApiService get apiService => _apiService;

  // Setters
  void setSelectedNavIndex(int index) {
    _selectedNavIndex = index;
    notifyListeners();
  }

  // Cargar datos del lote
  Future<void> loadBatchData(String lotId) async {
    try {
      // Cargar batch y steps en paralelo
      final results = await Future.wait([
        _apiService.getBatchById(lotId),
        _apiService.getStepsForLot(lotId),
      ]);

      _currentBatch = results[0] as Batch;
      _currentSteps = results[1] as List<Step>;

      // Cargar todos los usuarios si no están cargados
      if (_allUsers.isEmpty) {
        _allUsers = await _apiService.getAllUsers();
      }

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
