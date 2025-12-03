import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../../../core/providers/app_state_provider.dart';
import '../../../core/models/step.dart' as model;
import 'blockchain_verification_screen.dart';

class TimelineScreen extends StatefulWidget {
  const TimelineScreen({super.key});

  @override
  State<TimelineScreen> createState() => _TimelineScreenState();
}

class _TimelineScreenState extends State<TimelineScreen> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  PhosphorIconData _getIconForStepType(String stepType) {
    final type = stepType.toLowerCase();

    // Siembra y cultivo
    if (type.contains('siembra') || type.contains('plantación') || type.contains('cultivo')) {
      return PhosphorIcons.plant(PhosphorIconsStyle.fill);
    }
    // Cosecha
    if (type.contains('cosecha') || type.contains('recolección') || type.contains('harvest')) {
      return PhosphorIcons.leaf(PhosphorIconsStyle.fill);
    }
    // Empaquetado
    if (type.contains('empaque') || type.contains('empaquetado') || type.contains('pack')) {
      return PhosphorIcons.package(PhosphorIconsStyle.fill);
    }
    // Transporte
    if (type.contains('transporte') || type.contains('envío') || type.contains('transport') || type.contains('delivery')) {
      return PhosphorIcons.truck(PhosphorIconsStyle.fill);
    }
    // Almacenamiento
    if (type.contains('almacen') || type.contains('bodega') || type.contains('storage') || type.contains('warehouse')) {
      return PhosphorIcons.warehouse(PhosphorIconsStyle.fill);
    }
    // Tienda/retail
    if (type.contains('tienda') || type.contains('retail') || type.contains('store') || type.contains('llegada')) {
      return PhosphorIcons.storefront(PhosphorIconsStyle.fill);
    }
    // Venta
    if (type.contains('venta') || type.contains('disponible') || type.contains('sale')) {
      return PhosphorIcons.shoppingCart(PhosphorIconsStyle.fill);
    }
    // Inspección/calidad
    if (type.contains('inspección') || type.contains('calidad') || type.contains('quality') || type.contains('inspection')) {
      return PhosphorIcons.magnifyingGlass(PhosphorIconsStyle.fill);
    }
    // Certificación
    if (type.contains('certificación') || type.contains('certificado') || type.contains('certification')) {
      return PhosphorIcons.sealCheck(PhosphorIconsStyle.fill);
    }
    // Procesamiento
    if (type.contains('procesamiento') || type.contains('process')) {
      return PhosphorIcons.gear(PhosphorIconsStyle.fill);
    }
    // Completado
    if (type.contains('completado') || type.contains('finalizado') || type.contains('completed')) {
      return PhosphorIcons.checkCircle(PhosphorIconsStyle.fill);
    }

    return PhosphorIcons.circleDashed(PhosphorIconsStyle.regular);
  }

  String _formatDate(String date) {
    try {
      final dt = DateTime.parse(date);
      return DateFormat('yyyy-MM-dd').format(dt);
    } catch (e) {
      return date;
    }
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

    return Scaffold(
      backgroundColor: const Color(0xFFF8FBF9),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: PhosphorIcon(
            PhosphorIcons.caretLeft(PhosphorIconsStyle.bold),
            color: Colors.black,
            size: 28,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          batch.lotName,
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w700,
            fontSize: 18,
            letterSpacing: -0.2,
          ),
        ),
        actions: [
          IconButton(
            icon: PhosphorIcon(
              PhosphorIcons.link(PhosphorIconsStyle.bold),
              color: const Color(0xFF22C55E),
              size: 24,
            ),
            onPressed: () {
              Navigator.of(context).push(
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) =>
                      const BlockchainVerificationScreen(),
                  transitionsBuilder: (context, animation, secondaryAnimation, child) {
                    return FadeTransition(
                      opacity: animation,
                      child: SlideTransition(
                        position: Tween<Offset>(
                          begin: const Offset(0.1, 0),
                          end: Offset.zero,
                        ).animate(CurvedAnimation(
                          parent: animation,
                          curve: Curves.easeOut,
                        )),
                        child: child,
                      ),
                    );
                  },
                  transitionDuration: const Duration(milliseconds: 300),
                ),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Header con información del lote (compacto)
          FadeTransition(
            opacity: _animationController,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.03),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                children: [
                  PhosphorIcon(
                    PhosphorIcons.package(PhosphorIconsStyle.fill),
                    color: Colors.grey[400],
                    size: 14,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Lote ${batch.id} • ${_formatDate(batch.createdDate.split('T')[0])}',
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: batch.state == 'Activo' || batch.state == 'Vigente'
                          ? const Color(0xFF22C55E).withValues(alpha: 0.1)
                          : Colors.orange.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 5,
                          height: 5,
                          decoration: BoxDecoration(
                            color: batch.state == 'Activo' || batch.state == 'Vigente'
                                ? const Color(0xFF22C55E)
                                : Colors.orange,
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 6),
                        Text(
                          batch.state,
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 12,
                            color: batch.state == 'Activo' || batch.state == 'Vigente'
                                ? const Color(0xFF22C55E)
                                : Colors.orange[700],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Timeline
          Expanded(
            child: steps.isEmpty
                ? const Center(child: Text('No hay eventos registrados'))
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                    itemCount: steps.length,
                    itemBuilder: (context, index) {
                      final step = steps[index];
                      return TweenAnimationBuilder<double>(
                        duration: Duration(milliseconds: 300 + (index * 50)),
                        tween: Tween(begin: 0.0, end: 1.0),
                        curve: Curves.easeOut,
                        builder: (context, value, child) {
                          return Opacity(
                            opacity: value,
                            child: Transform.translate(
                              offset: Offset(0, 20 * (1 - value)),
                              child: child,
                            ),
                          );
                        },
                        child: _TimelineItem(
                          step: step,
                          icon: _getIconForStepType(step.stepType),
                          isLast: index == steps.length - 1,
                        ),
                      );
                    },
                  ),
          ),
          // Footer con botones
          FadeTransition(
            opacity: _animationController,
            child: Container(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.08),
                    blurRadius: 12,
                    offset: const Offset(0, -4),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton(
                      onPressed: () {
                        provider.navigateToMap();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF22C55E),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 0,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          PhosphorIcon(
                            PhosphorIcons.mapTrifold(PhosphorIconsStyle.fill),
                            color: Colors.white,
                            size: 20,
                          ),
                          const SizedBox(width: 10),
                          const Text(
                            'Ver recorrido en mapa',
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: OutlinedButton(
                      onPressed: () {
                        provider.navigateToCompanies();
                      },
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.grey[800],
                        side: BorderSide(color: Colors.grey[300]!, width: 1.5),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          PhosphorIcon(
                            PhosphorIcons.buildings(PhosphorIconsStyle.fill),
                            color: Colors.grey[700],
                            size: 20,
                          ),
                          const SizedBox(width: 10),
                          Text(
                            'Empresas participantes',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 15,
                              color: Colors.grey[800],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _TimelineItem extends StatelessWidget {
  final model.Step step;
  final PhosphorIconData icon;
  final bool isLast;

  const _TimelineItem({
    required this.step,
    required this.icon,
    required this.isLast,
  });

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Línea e ícono
          Column(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: const Color(0xFF22C55E).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: const Color(0xFF22C55E).withValues(alpha: 0.2),
                    width: 1.5,
                  ),
                ),
                child: Center(
                  child: PhosphorIcon(
                    icon,
                    size: 22,
                    color: const Color(0xFF22C55E),
                  ),
                ),
              ),
              if (!isLast)
                Expanded(
                  child: Container(
                    width: 2,
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          const Color(0xFF22C55E).withValues(alpha: 0.3),
                          const Color(0xFF22C55E).withValues(alpha: 0.1),
                        ],
                      ),
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(width: 16),
          // Contenido
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 24),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: Colors.grey[200]!,
                    width: 1,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.02),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            step.stepType,
                            style: const TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 15,
                              color: Colors.black,
                              letterSpacing: -0.2,
                            ),
                          ),
                        ),
                        _BlockchainStatusBadge(status: step.blockchainStatus),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        PhosphorIcon(
                          PhosphorIcons.clock(),
                          size: 14,
                          color: Colors.grey[500],
                        ),
                        const SizedBox(width: 6),
                        Text(
                          '${step.stepDate} ${step.stepTime}',
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        PhosphorIcon(
                          PhosphorIcons.mapPin(),
                          size: 14,
                          color: Colors.grey[500],
                        ),
                        const SizedBox(width: 6),
                        Expanded(
                          child: Text(
                            step.location,
                            style: TextStyle(
                              color: const Color(0xFF22C55E),
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    if (step.observations.isNotEmpty) ...[
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.grey[50],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            PhosphorIcon(
                              PhosphorIcons.noteBlank(),
                              size: 16,
                              color: Colors.grey[600],
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                step.observations,
                                style: TextStyle(
                                  color: Colors.grey[700],
                                  fontSize: 13,
                                  height: 1.4,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _BlockchainStatusBadge extends StatelessWidget {
  final model.BlockchainStatus status;

  const _BlockchainStatusBadge({required this.status});

  @override
  Widget build(BuildContext context) {
    Color backgroundColor;
    Color textColor;
    Color iconColor;
    String text;
    PhosphorIconData icon;

    switch (status) {
      case model.BlockchainStatus.confirmed:
        backgroundColor = const Color(0xFF22C55E).withValues(alpha: 0.1);
        textColor = const Color(0xFF22C55E);
        iconColor = const Color(0xFF22C55E);
        text = 'Confirmado';
        icon = PhosphorIcons.checkCircle(PhosphorIconsStyle.fill);
        break;
      case model.BlockchainStatus.pending:
        backgroundColor = Colors.orange.withValues(alpha: 0.1);
        textColor = Colors.orange[700]!;
        iconColor = Colors.orange[600]!;
        text = 'Pendiente';
        icon = PhosphorIcons.clock(PhosphorIconsStyle.fill);
        break;
      case model.BlockchainStatus.failed:
        backgroundColor = Colors.red.withValues(alpha: 0.1);
        textColor = Colors.red[700]!;
        iconColor = Colors.red[600]!;
        text = 'Fallido';
        icon = PhosphorIcons.xCircle(PhosphorIconsStyle.fill);
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          PhosphorIcon(
            icon,
            size: 12,
            color: iconColor,
          ),
          const SizedBox(width: 4),
          Text(
            text,
            style: TextStyle(
              color: textColor,
              fontSize: 11,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
