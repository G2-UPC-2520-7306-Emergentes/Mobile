import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:provider/provider.dart';
import '../../../core/providers/app_state_provider.dart';
import '../../../core/models/user.dart';

class CompanyDetailScreen extends StatefulWidget {
  final String companyName;

  const CompanyDetailScreen({super.key, required this.companyName});

  @override
  State<CompanyDetailScreen> createState() => _CompanyDetailScreenState();
}

class _CompanyDetailScreenState extends State<CompanyDetailScreen> with SingleTickerProviderStateMixin {
  List<User> _companyUsers = [];
  String _taxId = '';
  bool _isLoading = true;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

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
    _loadCompanyData();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Future<void> _loadCompanyData() async {
    final provider = Provider.of<AppStateProvider>(context, listen: false);
    final users = await provider.apiService.getUsersByCompany(widget.companyName);
    final taxId = await provider.apiService.getCompanyTaxId(widget.companyName);

    setState(() {
      _companyUsers = users;
      _taxId = taxId;
      _isLoading = false;
    });
  }

  PhosphorIconData _getCompanyIcon(String companyName) {
    final name = companyName.toLowerCase();
    if (name.contains('finca') || name.contains('farm') || name.contains('agro')) {
      return PhosphorIcons.plant(PhosphorIconsStyle.fill);
    } else if (name.contains('empacadora') || name.contains('packer') || name.contains('pack')) {
      return PhosphorIcons.package(PhosphorIconsStyle.fill);
    } else if (name.contains('distributor') || name.contains('logistics') || name.contains('transport')) {
      return PhosphorIcons.truck(PhosphorIconsStyle.fill);
    } else if (name.contains('store') || name.contains('tienda') || name.contains('market')) {
      return PhosphorIcons.storefront(PhosphorIconsStyle.fill);
    } else if (name.contains('fresh') || name.contains('organic')) {
      return PhosphorIcons.leaf(PhosphorIconsStyle.fill);
    }
    return PhosphorIcons.buildings(PhosphorIconsStyle.fill);
  }

  Color _getCompanyColor(String companyName) {
    final name = companyName.toLowerCase();
    if (name.contains('finca') || name.contains('farm') || name.contains('agro')) {
      return const Color(0xFF16A34A); // Green
    } else if (name.contains('empacadora') || name.contains('packer') || name.contains('pack')) {
      return const Color(0xFF0891B2); // Cyan
    } else if (name.contains('distributor') || name.contains('logistics') || name.contains('transport')) {
      return const Color(0xFFEA580C); // Orange
    } else if (name.contains('store') || name.contains('tienda') || name.contains('market')) {
      return const Color(0xFF7C3AED); // Purple
    } else if (name.contains('fresh') || name.contains('organic')) {
      return const Color(0xFF22C55E); // Primary green
    }
    return const Color(0xFF22C55E); // Default
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
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
        title: const Text(
          'Empresa participante',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
        ),
        actions: [
          IconButton(
            icon: PhosphorIcon(
              PhosphorIcons.gear(),
              color: Colors.black,
              size: 24,
            ),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Configuración próximamente'),
                  duration: Duration(seconds: 2),
                ),
              );
            },
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : FadeTransition(
              opacity: _fadeAnimation,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Banner con logo
                    Container(
                    width: double.infinity,
                    height: 220,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [const Color(0xFF16A34A), const Color(0xFF22C55E)],
                      ),
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  _getCompanyColor(widget.companyName),
                                  _getCompanyColor(widget.companyName).withValues(alpha: 0.7),
                                ],
                              ),
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: 0.2),
                                  blurRadius: 20,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Center(
                              child: PhosphorIcon(
                                _getCompanyIcon(widget.companyName),
                                color: Colors.white,
                                size: 48,
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            widget.companyName,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Colors.white70,
                              fontSize: 12,
                              letterSpacing: 2,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Nombre de la empresa
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.companyName,
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Proveedor líder de soluciones innovadoras post-cosecha para la industria de productos frescos, dedicado a reducir el desperdicio de alimentos y mejorar la calidad.',
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 14,
                            height: 1.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  // Certificaciones
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    color: Colors.white,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Certificaciones de calidad',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 16),
                        _AnimatedCertificationItem(
                          delay: 0,
                          title: 'Gestión de Calidad',
                          subtitle: 'ISO 9001',
                        ),
                        _AnimatedCertificationItem(
                          delay: 100,
                          title: 'Buenas Prácticas Agrícolas',
                          subtitle: 'GlobalG.A.P.',
                        ),
                        _AnimatedCertificationItem(
                          delay: 200,
                          title: 'Análisis de Peligros y Puntos Críticos',
                          subtitle: 'HACCP',
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Información básica
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    color: Colors.white,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Información básica',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 16),
                        _InfoRow(
                          label: 'www.agrofresh.com',
                          icon: PhosphorIcons.globe(),
                        ),
                        const SizedBox(height: 12),
                        _InfoRow(
                          label: 'Fundación: 1995',
                          icon: PhosphorIcons.calendar(),
                        ),
                        const SizedBox(height: 12),
                        _InfoRow(
                          label: 'País de origen: España',
                          icon: PhosphorIcons.flag(),
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

class _AnimatedCertificationItem extends StatelessWidget {
  final int delay;
  final String title;
  final String subtitle;

  const _AnimatedCertificationItem({
    required this.delay,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      duration: Duration(milliseconds: 400 + delay),
      tween: Tween(begin: 0.0, end: 1.0),
      curve: Curves.easeOut,
      builder: (context, value, child) {
        return Opacity(
          opacity: value,
          child: Transform.translate(
            offset: Offset(20 * (1 - value), 0),
            child: child,
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
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
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: const Color(0xFF22C55E).withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: PhosphorIcon(
                PhosphorIcons.sealCheck(PhosphorIconsStyle.fill),
                color: const Color(0xFF22C55E),
                size: 24,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 15,
                      letterSpacing: -0.2,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            TextButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    title: Row(
                      children: [
                        PhosphorIcon(
                          PhosphorIcons.sealCheck(PhosphorIconsStyle.fill),
                          color: const Color(0xFF22C55E),
                          size: 24,
                        ),
                        const SizedBox(width: 12),
                        Text('Certificación $subtitle'),
                      ],
                    ),
                    content: const Text('Esta certificación ha sido verificada correctamente.'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: const Text(
                          'Cerrar',
                          style: TextStyle(color: Color(0xFF22C55E)),
                        ),
                      ),
                    ],
                  ),
                );
              },
              child: const Text(
                'Verificar',
                style: TextStyle(
                  color: Color(0xFF22C55E),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final String label;
  final PhosphorIconData icon;

  const _InfoRow({
    required this.label,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: const Color(0xFF22C55E).withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: PhosphorIcon(
              icon,
              color: const Color(0xFF22C55E),
              size: 18,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                letterSpacing: -0.1,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
