import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:provider/provider.dart';
import '../../../core/providers/app_state_provider.dart';
import '../../../core/models/enterprise_detail.dart';

class CompanyDetailScreen extends StatefulWidget {
  final String companyId;
  final String companyName;

  const CompanyDetailScreen({
    super.key,
    required this.companyId,
    required this.companyName,
  });

  @override
  State<CompanyDetailScreen> createState() => _CompanyDetailScreenState();
}

class _CompanyDetailScreenState extends State<CompanyDetailScreen>
    with SingleTickerProviderStateMixin {
  EnterpriseDetail? _enterprise;
  bool _isLoading = true;
  String? _error;
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    _loadCompanyData();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Future<void> _loadCompanyData() async {
    try {
      final provider = Provider.of<AppStateProvider>(context, listen: false);
      final enterprise = await provider.apiService.getEnterpriseById(
        widget.companyId,
      );

      if (mounted) {
        setState(() {
          _enterprise = enterprise;
          _isLoading = false;
        });
        _animationController.forward();
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _error = e.toString();
          _isLoading = false;
        });
      }
    }
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
    } else if (name.contains('ecovida') || name.contains('alimentos') || name.contains('organic')) {
      return PhosphorIcons.leaf(PhosphorIconsStyle.fill);
    } else if (name.contains('tech') || name.contains('global') || name.contains('innovacion')) {
      return PhosphorIcons.circuitry(PhosphorIconsStyle.fill);
    } else if (name.contains('constructora') || name.contains('águila')) {
      return PhosphorIcons.hardHat(PhosphorIconsStyle.fill);
    } else if (name.contains('beta') || name.contains('soluciones')) {
      return PhosphorIcons.briefcase(PhosphorIconsStyle.fill);
    } else if (name.contains('acme') || name.contains('corp')) {
      return PhosphorIcons.buildings(PhosphorIconsStyle.fill);
    }
    return PhosphorIcons.buildings(PhosphorIconsStyle.fill);
  }

  Color _getCompanyColor(String companyName) {
    final name = companyName.toLowerCase();
    if (name.contains('finca') || name.contains('farm') || name.contains('agro')) {
      return const Color(0xFF16A34A);
    } else if (name.contains('empacadora') || name.contains('packer') || name.contains('pack')) {
      return const Color(0xFF0891B2);
    } else if (name.contains('distributor') || name.contains('logistics') || name.contains('transport')) {
      return const Color(0xFFEA580C);
    } else if (name.contains('ecovida') || name.contains('alimentos') || name.contains('organic')) {
      return const Color(0xFF22C55E);
    } else if (name.contains('tech') || name.contains('global') || name.contains('innovacion')) {
      return const Color(0xFF6366F1);
    } else if (name.contains('constructora') || name.contains('águila')) {
      return const Color(0xFFDC2626);
    } else if (name.contains('beta') || name.contains('soluciones')) {
      return const Color(0xFF0891B2);
    } else if (name.contains('acme') || name.contains('corp')) {
      return const Color(0xFF7C3AED);
    }
    return const Color(0xFF22C55E);
  }

  @override
  Widget build(BuildContext context) {
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
        title: const Text(
          'Detalle de Empresa',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w700,
            fontSize: 18,
            letterSpacing: -0.2,
          ),
        ),
      ),
      body: _isLoading
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CircularProgressIndicator(
                    color: Color(0xFF22C55E),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Cargando información...',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            )
          : _error != null
              ? Center(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        PhosphorIcon(
                          PhosphorIcons.warningCircle(PhosphorIconsStyle.fill),
                          color: Colors.orange,
                          size: 48,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'No se pudo cargar la información',
                          style: TextStyle(
                            color: Colors.grey[800],
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          _error!,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 13,
                          ),
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              _isLoading = true;
                              _error = null;
                            });
                            _loadCompanyData();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF22C55E),
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: const Text('Reintentar'),
                        ),
                      ],
                    ),
                  ),
                )
              : FadeTransition(
                  opacity: _animationController,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Banner con logo
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(vertical: 32),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                _getCompanyColor(_enterprise?.name ?? widget.companyName),
                                _getCompanyColor(_enterprise?.name ?? widget.companyName).withValues(alpha: 0.7),
                              ],
                            ),
                          ),
                          child: Column(
                            children: [
                              Container(
                                width: 100,
                                height: 100,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withValues(alpha: 0.2),
                                      blurRadius: 20,
                                      offset: const Offset(0, 8),
                                    ),
                                  ],
                                ),
                                child: _enterprise?.logoUrl != null
                                    ? ClipRRect(
                                        borderRadius: BorderRadius.circular(20),
                                        child: Image.network(
                                          _enterprise!.logoUrl!,
                                          fit: BoxFit.cover,
                                          errorBuilder: (context, error, stackTrace) => Center(
                                            child: PhosphorIcon(
                                              _getCompanyIcon(_enterprise?.name ?? widget.companyName),
                                              color: _getCompanyColor(_enterprise?.name ?? widget.companyName),
                                              size: 48,
                                            ),
                                          ),
                                        ),
                                      )
                                    : Center(
                                        child: PhosphorIcon(
                                          _getCompanyIcon(_enterprise?.name ?? widget.companyName),
                                          color: _getCompanyColor(_enterprise?.name ?? widget.companyName),
                                          size: 48,
                                        ),
                                      ),
                              ),
                              const SizedBox(height: 16),
                              Text(
                                _enterprise?.name ?? widget.companyName,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 22,
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: -0.3,
                                ),
                              ),
                              if (_enterprise?.country != null) ...[
                                const SizedBox(height: 8),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withValues(alpha: 0.2),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      PhosphorIcon(
                                        PhosphorIcons.mapPin(PhosphorIconsStyle.fill),
                                        color: Colors.white,
                                        size: 14,
                                      ),
                                      const SizedBox(width: 6),
                                      Text(
                                        _enterprise!.country!,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 13,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ),
                        // Descripción
                        Container(
                          width: double.infinity,
                          margin: const EdgeInsets.all(16),
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.04),
                                blurRadius: 10,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFF22C55E).withValues(alpha: 0.1),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: PhosphorIcon(
                                      PhosphorIcons.info(PhosphorIconsStyle.fill),
                                      color: const Color(0xFF22C55E),
                                      size: 20,
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  const Text(
                                    'Acerca de',
                                    style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w700,
                                      letterSpacing: -0.2,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 16),
                              Text(
                                _enterprise?.description ?? 'No hay descripción disponible.',
                                style: TextStyle(
                                  color: Colors.grey[700],
                                  fontSize: 14,
                                  height: 1.6,
                                ),
                              ),
                            ],
                          ),
                        ),
                        // Certificaciones
                        if (_enterprise?.certifications.isNotEmpty ?? false)
                          Container(
                            width: double.infinity,
                            margin: const EdgeInsets.symmetric(horizontal: 16),
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: 0.04),
                                  blurRadius: 10,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        color: Colors.amber.withValues(alpha: 0.1),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: PhosphorIcon(
                                        PhosphorIcons.certificate(PhosphorIconsStyle.fill),
                                        color: Colors.amber[700],
                                        size: 20,
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    const Text(
                                      'Certificaciones',
                                      style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.w700,
                                        letterSpacing: -0.2,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 16),
                                ..._enterprise!.certifications.map(
                                  (cert) => _CertificationItem(certification: cert),
                                ),
                              ],
                            ),
                          ),
                        const SizedBox(height: 16),
                        // Información adicional
                        if (_enterprise?.website != null || _enterprise?.foundationYear != null)
                          Container(
                            width: double.infinity,
                            margin: const EdgeInsets.symmetric(horizontal: 16),
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: 0.04),
                                  blurRadius: 10,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        color: Colors.blue.withValues(alpha: 0.1),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: PhosphorIcon(
                                        PhosphorIcons.buildings(PhosphorIconsStyle.fill),
                                        color: Colors.blue[700],
                                        size: 20,
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    const Text(
                                      'Información',
                                      style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.w700,
                                        letterSpacing: -0.2,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 16),
                                if (_enterprise?.website != null)
                                  _InfoRow(
                                    icon: PhosphorIcons.globe(PhosphorIconsStyle.fill),
                                    label: 'Sitio web',
                                    value: _enterprise!.website!,
                                    color: Colors.blue,
                                  ),
                                if (_enterprise?.foundationYear != null) ...[
                                  if (_enterprise?.website != null) const SizedBox(height: 12),
                                  _InfoRow(
                                    icon: PhosphorIcons.calendar(PhosphorIconsStyle.fill),
                                    label: 'Fundación',
                                    value: '${_enterprise!.foundationYear}',
                                    color: Colors.purple,
                                  ),
                                ],
                              ],
                            ),
                          ),
                        const SizedBox(height: 16),
                        // Botón de blockchain
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: SizedBox(
                            width: double.infinity,
                            height: 52,
                            child: ElevatedButton(
                              onPressed: () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Row(
                                      children: [
                                        PhosphorIcon(
                                          PhosphorIcons.link(PhosphorIconsStyle.bold),
                                          color: Colors.white,
                                          size: 20,
                                        ),
                                        const SizedBox(width: 12),
                                        const Text('Verificando en blockchain...'),
                                      ],
                                    ),
                                    backgroundColor: const Color(0xFF22C55E),
                                    behavior: SnackBarBehavior.floating,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                );
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
                                    PhosphorIcons.link(PhosphorIconsStyle.bold),
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                  const SizedBox(width: 10),
                                  const Text(
                                    'Ver en Blockchain',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 15,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 24),
                      ],
                    ),
                  ),
                ),
    );
  }
}

class _CertificationItem extends StatelessWidget {
  final String certification;

  const _CertificationItem({required this.certification});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color(0xFF22C55E).withValues(alpha: 0.2),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: const Color(0xFF22C55E).withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: PhosphorIcon(
                PhosphorIcons.sealCheck(PhosphorIconsStyle.fill),
                color: const Color(0xFF22C55E),
                size: 22,
              ),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  certification,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    letterSpacing: -0.2,
                  ),
                ),
                const SizedBox(height: 2),
                Row(
                  children: [
                    PhosphorIcon(
                      PhosphorIcons.checkCircle(PhosphorIconsStyle.fill),
                      color: const Color(0xFF22C55E),
                      size: 12,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      'Verificado',
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final PhosphorIconData icon;
  final String label;
  final String value;
  final Color color;

  const _InfoRow({
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(
            child: PhosphorIcon(
              icon,
              color: color,
              size: 18,
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  color: Colors.grey[500],
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
