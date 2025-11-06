import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import '../../../core/providers/app_state_provider.dart';
import '../../../core/models/step.dart' as model;

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  String _selectedFilter = 'Todos';
  final MapController _mapController = MapController();
  double _currentZoom = 12.0;
  String _searchQuery = '';

  List<model.Step> _getFilteredSteps(List<model.Step> steps) {
    var filtered = steps;

    // Aplicar filtro por tipo
    if (_selectedFilter == 'Movimientos') {
      filtered = filtered.where((s) => s.location.contains(',')).toList();
    } else if (_selectedFilter == 'Procesos fijos') {
      filtered = filtered.where((s) => !s.location.contains(',') && s.location.isNotEmpty).toList();
    }

    // Aplicar búsqueda
    if (_searchQuery.isNotEmpty) {
      filtered = filtered.where((s) =>
        s.stepType.toLowerCase().contains(_searchQuery.toLowerCase()) ||
        s.location.toLowerCase().contains(_searchQuery.toLowerCase()) ||
        s.observations.toLowerCase().contains(_searchQuery.toLowerCase())
      ).toList();
    }

    return filtered;
  }

  LatLng? _parseLocation(String location) {
    if (location.contains(',')) {
      final parts = location.split(',');
      if (parts.length == 2) {
        try {
          final lat = double.parse(parts[0].trim());
          final lng = double.parse(parts[1].trim());
          return LatLng(lat, lng);
        } catch (e) {
          return null;
        }
      }
    }
    return null;
  }

  void _zoomIn() {
    setState(() {
      _currentZoom = (_currentZoom + 1).clamp(3.0, 18.0);
    });
    _mapController.move(_mapController.camera.center, _currentZoom);
  }

  void _zoomOut() {
    setState(() {
      _currentZoom = (_currentZoom - 1).clamp(3.0, 18.0);
    });
    _mapController.move(_mapController.camera.center, _currentZoom);
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AppStateProvider>(context);
    final batch = provider.currentBatch;
    final steps = provider.currentSteps;

    if (batch == null) {
      return const Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Text('No hay datos disponibles'),
        ),
      );
    }

    final filteredSteps = _getFilteredSteps(steps);
    final stepsWithLocation = filteredSteps.where((s) => s.location.isNotEmpty).toList();
    final markers = <Marker>[];

    for (final step in filteredSteps) {
      final latLng = _parseLocation(step.location);
      if (latLng != null) {
        markers.add(
          Marker(
            point: latLng,
            width: 40,
            height: 40,
            child: const Icon(
              Icons.location_on,
              color: Colors.pink,
              size: 40,
            ),
          ),
        );
      }
    }

    LatLng center = const LatLng(-12.0464, -77.0428);

    if (markers.isNotEmpty) {
      center = markers[0].point;
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Recorrido del lote',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w600,
                fontSize: 18,
              ),
            ),
            Text(
              'Lote ID • ${batch.state}',
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            color: Colors.white,
            child: Column(
              children: [
                Row(
                  children: [
                    _FilterChip(
                      label: 'Todos',
                      isSelected: _selectedFilter == 'Todos',
                      onTap: () => setState(() => _selectedFilter = 'Todos'),
                    ),
                    const SizedBox(width: 8),
                    _FilterChip(
                      label: 'Movimientos',
                      isSelected: _selectedFilter == 'Movimientos',
                      onTap: () => setState(() => _selectedFilter = 'Movimientos'),
                    ),
                    const SizedBox(width: 8),
                    _FilterChip(
                      label: 'Procesos fijos',
                      isSelected: _selectedFilter == 'Procesos fijos',
                      onTap: () => setState(() => _selectedFilter = 'Procesos fijos'),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Container(
                  height: 48,
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      const SizedBox(width: 16),
                      Icon(Icons.search, color: Colors.grey[600]),
                      const SizedBox(width: 8),
                      Expanded(
                        child: TextField(
                          onChanged: (value) {
                            setState(() {
                              _searchQuery = value;
                            });
                          },
                          decoration: InputDecoration(
                            hintText: 'Buscar',
                            hintStyle: TextStyle(color: Colors.grey[600]),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Stack(
              children: [
                FlutterMap(
                  mapController: _mapController,
                  options: MapOptions(
                    initialCenter: center,
                    initialZoom: _currentZoom,
                  ),
                  children: [
                    TileLayer(
                      urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                      userAgentPackageName: 'com.example.flutter_application_1',
                    ),
                    MarkerLayer(markers: markers),
                  ],
                ),
                Positioned(
                  right: 16,
                  bottom: 180,
                  child: Column(
                    children: [
                      FloatingActionButton(
                        mini: true,
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.black,
                        onPressed: _zoomIn,
                        heroTag: 'zoom_in',
                        child: const Icon(Icons.add),
                      ),
                      const SizedBox(height: 8),
                      FloatingActionButton(
                        mini: true,
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.black,
                        onPressed: _zoomOut,
                        heroTag: 'zoom_out',
                        child: const Icon(Icons.remove),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  right: 16,
                  bottom: 100,
                  child: FloatingActionButton(
                    mini: true,
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                    heroTag: 'my_location',
                    onPressed: () {
                      if (markers.isNotEmpty) {
                        _mapController.move(markers[0].point, 14.0);
                      }
                    },
                    child: const Icon(Icons.my_location),
                  ),
                ),
                DraggableScrollableSheet(
                  initialChildSize: 0.25,
                  minChildSize: 0.15,
                  maxChildSize: 0.6,
                  builder: (context, scrollController) {
                    return Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 10,
                            offset: const Offset(0, -2),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Container(
                            margin: const EdgeInsets.symmetric(vertical: 8),
                            width: 40,
                            height: 4,
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(2),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Text(
                              'Eventos con ubicación',
                              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                    fontWeight: FontWeight.w600,
                                  ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          Expanded(
                            child: ListView.builder(
                              controller: scrollController,
                              padding: const EdgeInsets.symmetric(horizontal: 20),
                              itemCount: stepsWithLocation.length,
                              itemBuilder: (context, index) {
                                final step = stepsWithLocation[index];
                                return Container(
                                  margin: const EdgeInsets.only(bottom: 12),
                                  child: Row(
                                    children: [
                                      Icon(Icons.local_shipping, color: Colors.grey[600]),
                                      const SizedBox(width: 12),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              step.stepType,
                                              style: const TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 15,
                                              ),
                                            ),
                                            Text(
                                              '${step.stepDate} ${step.stepTime}',
                                              style: TextStyle(
                                                color: Colors.teal[600],
                                                fontSize: 13,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      TextButton(
                                        onPressed: () => provider.navigateToTimeline(),
                                        child: const Text('Ver en timeline'),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _FilterChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _FilterChip({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? Colors.teal[700] : Colors.grey[200],
          borderRadius: BorderRadius.circular(16),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black,
            fontWeight: FontWeight.w500,
            fontSize: 13,
          ),
        ),
      ),
    );
  }
}
