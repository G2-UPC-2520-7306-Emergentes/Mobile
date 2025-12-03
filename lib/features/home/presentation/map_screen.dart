import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import '../../../core/providers/app_state_provider.dart';
import '../../../core/models/step.dart' as model;

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> with TickerProviderStateMixin {
  String _selectedFilter = 'Movimientos';
  GoogleMapController? _mapController;
  double _currentZoom = 12.0;
  String _searchQuery = '';
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  List<model.Step> _getFilteredSteps(List<model.Step> steps) {
    // Solo mostrar pasos que tienen ubicación
    var filtered = steps.where((s) => s.latitude != null && s.longitude != null).toList();

    // Aplicar búsqueda por nombre de evento, ubicación u observaciones
    if (_searchQuery.isNotEmpty) {
      filtered = filtered.where((s) =>
        s.stepType.toLowerCase().contains(_searchQuery.toLowerCase()) ||
        s.location.toLowerCase().contains(_searchQuery.toLowerCase()) ||
        s.observations.toLowerCase().contains(_searchQuery.toLowerCase())
      ).toList();
    }

    return filtered;
  }

  LatLng? _getLatLng(model.Step step) {
    if (step.latitude != null && step.longitude != null) {
      return LatLng(step.latitude!, step.longitude!);
    }
    return null;
  }

  void _zoomIn() {
    setState(() {
      _currentZoom = (_currentZoom + 1).clamp(3.0, 18.0);
    });
    _mapController?.animateCamera(CameraUpdate.zoomTo(_currentZoom));
  }

  void _zoomOut() {
    setState(() {
      _currentZoom = (_currentZoom - 1).clamp(3.0, 18.0);
    });
    _mapController?.animateCamera(CameraUpdate.zoomTo(_currentZoom));
  }

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    _fadeAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOut,
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _mapController?.dispose();
    super.dispose();
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
    final stepsWithLocation = filteredSteps.where((s) => s.latitude != null && s.longitude != null).toList();
    final markers = <Marker>{};
    final polylinePoints = <LatLng>[];

    for (var i = 0; i < filteredSteps.length; i++) {
      final step = filteredSteps[i];
      final latLng = _getLatLng(step);
      if (latLng != null) {
        polylinePoints.add(latLng);
        markers.add(
          Marker(
            markerId: MarkerId('marker_$i'),
            position: latLng,
            infoWindow: InfoWindow(
              title: step.stepType,
              snippet: '${step.stepDate} ${step.stepTime}',
            ),
            icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
          ),
        );
      }
    }

    // Crear la polyline para el trazo de ruta (solo si NO es "Procesos fijos")
    final polylines = <Polyline>{};
    if (polylinePoints.length > 1 && _selectedFilter != 'Procesos fijos') {
      polylines.add(
        Polyline(
          polylineId: const PolylineId('route'),
          points: polylinePoints,
          color: const Color(0xFF22C55E),
          width: 4,
          patterns: [PatternItem.dash(20), PatternItem.gap(10)],
        ),
      );
    }

    LatLng center = const LatLng(-12.0464, -77.0428);

    if (markers.isNotEmpty) {
      center = markers.first.position;
    }

    return Scaffold(
      backgroundColor: const Color(0xFFF8FBF9),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        toolbarHeight: 56,
        leading: IconButton(
          icon: PhosphorIcon(
            PhosphorIcons.caretLeft(PhosphorIconsStyle.bold),
            color: Colors.black,
            size: 28,
          ),
          onPressed: () => provider.navigateToTimeline(),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Recorrido del lote',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w700,
                fontSize: 16,
                letterSpacing: -0.2,
              ),
            ),
            Text(
              'Lote ID • ${batch.state}',
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 11,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            color: Colors.white,
            child: Column(
              children: [
                Row(
                  children: [
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
                const SizedBox(height: 10),
                Container(
                  height: 42,
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      const SizedBox(width: 12),
                      PhosphorIcon(
                        PhosphorIcons.magnifyingGlass(),
                        color: Colors.grey[600],
                        size: 18,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: TextField(
                          onChanged: (value) {
                            setState(() {
                              _searchQuery = value;
                            });
                          },
                          decoration: InputDecoration(
                            hintText: 'Buscar eventos...',
                            hintStyle: TextStyle(color: Colors.grey[600], fontSize: 14),
                            border: InputBorder.none,
                          ),
                          style: const TextStyle(fontSize: 14),
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
                GoogleMap(
                  initialCameraPosition: CameraPosition(
                    target: center,
                    zoom: _currentZoom,
                  ),
                  markers: markers,
                  polylines: polylines,
                  onMapCreated: (controller) {
                    _mapController = controller;
                  },
                  onCameraMove: (position) {
                    _currentZoom = position.zoom;
                  },
                  myLocationButtonEnabled: false,
                  zoomControlsEnabled: false,
                ),
                Positioned(
                  right: 16,
                  bottom: 120,
                  child: Column(
                    children: [
                      Material(
                        elevation: 4,
                        borderRadius: BorderRadius.circular(12),
                        child: InkWell(
                          onTap: _zoomIn,
                          borderRadius: BorderRadius.circular(12),
                          child: Container(
                            width: 44,
                            height: 44,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Center(
                              child: PhosphorIcon(
                                PhosphorIcons.plus(PhosphorIconsStyle.bold),
                                color: Colors.black,
                                size: 20,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Material(
                        elevation: 4,
                        borderRadius: BorderRadius.circular(12),
                        child: InkWell(
                          onTap: _zoomOut,
                          borderRadius: BorderRadius.circular(12),
                          child: Container(
                            width: 44,
                            height: 44,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Center(
                              child: PhosphorIcon(
                                PhosphorIcons.minus(PhosphorIconsStyle.bold),
                                color: Colors.black,
                                size: 20,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  right: 16,
                  bottom: 50,
                  child: Material(
                    elevation: 4,
                    borderRadius: BorderRadius.circular(12),
                    child: InkWell(
                      onTap: () {
                        if (markers.isNotEmpty) {
                          setState(() {
                            _currentZoom = 14.0;
                          });
                          _mapController?.animateCamera(
                            CameraUpdate.newLatLngZoom(markers.first.position, 14.0),
                          );
                        }
                      },
                      borderRadius: BorderRadius.circular(12),
                      child: Container(
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Center(
                          child: PhosphorIcon(
                            PhosphorIcons.navigationArrow(PhosphorIconsStyle.fill),
                            color: const Color(0xFF22C55E),
                            size: 20,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                DraggableScrollableSheet(
                  initialChildSize: 0.18,
                  minChildSize: 0.12,
                  maxChildSize: 0.6,
                  snap: true,
                  snapSizes: const [0.18, 0.4, 0.6],
                  builder: (context, scrollController) {
                    return Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.1),
                            blurRadius: 10,
                            offset: const Offset(0, -2),
                          ),
                        ],
                      ),
                      child: CustomScrollView(
                        controller: scrollController,
                        slivers: [
                          SliverToBoxAdapter(
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
                                  padding: const EdgeInsets.symmetric(horizontal: 16),
                                  child: Row(
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.all(6),
                                        decoration: BoxDecoration(
                                          color: const Color(0xFF22C55E).withValues(alpha: 0.1),
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                        child: PhosphorIcon(
                                          PhosphorIcons.mapTrifold(PhosphorIconsStyle.fill),
                                          color: const Color(0xFF22C55E),
                                          size: 18,
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      Text(
                                        'Eventos con ubicación',
                                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                              fontWeight: FontWeight.w700,
                                              fontSize: 15,
                                              letterSpacing: -0.3,
                                            ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 12),
                              ],
                            ),
                          ),
                          SliverPadding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            sliver: SliverList(
                              delegate: SliverChildBuilderDelegate(
                                (context, index) {
                                  final step = stepsWithLocation[index];
                                  return GestureDetector(
                                    onTap: () {
                                      final latLng = _getLatLng(step);
                                      if (latLng != null) {
                                        _mapController?.animateCamera(
                                          CameraUpdate.newLatLngZoom(latLng, 15.0),
                                        );
                                      }
                                    },
                                    child: Container(
                                      margin: const EdgeInsets.only(bottom: 10),
                                      padding: const EdgeInsets.all(14),
                                      decoration: BoxDecoration(
                                        color: Colors.grey[50],
                                        borderRadius: BorderRadius.circular(12),
                                        border: Border.all(
                                          color: const Color(0xFF22C55E).withValues(alpha: 0.1),
                                          width: 1,
                                        ),
                                      ),
                                      child: Row(
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.all(8),
                                            decoration: BoxDecoration(
                                              color: const Color(0xFF22C55E).withValues(alpha: 0.1),
                                              borderRadius: BorderRadius.circular(10),
                                            ),
                                            child: PhosphorIcon(
                                              PhosphorIcons.mapPin(PhosphorIconsStyle.fill),
                                              color: const Color(0xFF22C55E),
                                              size: 18,
                                            ),
                                          ),
                                          const SizedBox(width: 12),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  step.stepType,
                                                  style: const TextStyle(
                                                    fontWeight: FontWeight.w700,
                                                    fontSize: 14,
                                                    letterSpacing: -0.2,
                                                  ),
                                                ),
                                                const SizedBox(height: 3),
                                                Row(
                                                  children: [
                                                    PhosphorIcon(
                                                      PhosphorIcons.clock(),
                                                      color: const Color(0xFF22C55E),
                                                      size: 13,
                                                    ),
                                                    const SizedBox(width: 4),
                                                    Text(
                                                      '${step.stepDate} ${step.stepTime}',
                                                      style: const TextStyle(
                                                        color: Color(0xFF22C55E),
                                                        fontSize: 12,
                                                        fontWeight: FontWeight.w500,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                          IconButton(
                                            onPressed: () => provider.navigateToTimeline(),
                                            icon: PhosphorIcon(
                                              PhosphorIcons.arrowRight(PhosphorIconsStyle.bold),
                                              color: const Color(0xFF22C55E),
                                              size: 18,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                                childCount: stepsWithLocation.length,
                              ),
                            ),
                          ),
                          const SliverToBoxAdapter(
                            child: SizedBox(height: 20),
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
      borderRadius: BorderRadius.circular(14),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF22C55E) : Colors.grey[200],
          borderRadius: BorderRadius.circular(14),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black,
            fontWeight: FontWeight.w600,
            fontSize: 12,
          ),
        ),
      ),
    );
  }
}
