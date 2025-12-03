import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:provider/provider.dart';
import '../../../core/providers/app_state_provider.dart';
import '../../../core/models/enterprise_detail.dart';
import 'company_detail_screen.dart';

class CompaniesScreen extends StatefulWidget {
  const CompaniesScreen({super.key});

  @override
  State<CompaniesScreen> createState() => _CompaniesScreenState();
}

class _CompaniesScreenState extends State<CompaniesScreen>
    with SingleTickerProviderStateMixin {
  List<EnterpriseDetail> _enterprises = [];
  bool _isLoading = true;
  String? _error;
  late AnimationController _animationController;

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    _loadEnterprises();
  }

  Future<void> _loadEnterprises() async {
    try {
      final provider = Provider.of<AppStateProvider>(context, listen: false);
      final enterprises = await provider.apiService.getAllEnterprises();

      if (mounted) {
        setState(() {
          _enterprises = enterprises;
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

  String _getRole(String companyName) {
    final name = companyName.toLowerCase();
    if (name.contains('finca') || name.contains('farm') || name.contains('agro')) {
      return 'Productor';
    } else if (name.contains('empacadora') || name.contains('packer') || name.contains('pack')) {
      return 'Empacador';
    } else if (name.contains('distributor') || name.contains('logistics') || name.contains('transport')) {
      return 'Distribuidor';
    } else if (name.contains('ecovida') || name.contains('alimentos')) {
      return 'Productor de Alimentos';
    } else if (name.contains('tech') || name.contains('global') || name.contains('innovacion')) {
      return 'Tecnología';
    } else if (name.contains('constructora') || name.contains('águila')) {
      return 'Construcción';
    } else if (name.contains('beta') || name.contains('soluciones')) {
      return 'Soluciones Empresariales';
    } else if (name.contains('acme') || name.contains('corp')) {
      return 'Corporativo';
    }
    return 'Socio';
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
    if (_isLoading) {
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
            'Empresas Participantes',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w700,
              fontSize: 18,
              letterSpacing: -0.2,
            ),
          ),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircularProgressIndicator(
                color: Color(0xFF22C55E),
              ),
              const SizedBox(height: 16),
              Text(
                'Cargando empresas...',
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      );
    }

    if (_error != null) {
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
            'Empresas Participantes',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w700,
              fontSize: 18,
              letterSpacing: -0.2,
            ),
          ),
        ),
        body: Center(
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
                  'No se pudieron cargar las empresas',
                  style: TextStyle(
                    color: Colors.grey[800],
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _isLoading = true;
                      _error = null;
                    });
                    _loadEnterprises();
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
        title: const Text(
          'Empresas Participantes',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w700,
            fontSize: 18,
            letterSpacing: -0.2,
          ),
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _enterprises.length,
        itemBuilder: (context, index) {
          final enterprise = _enterprises[index];
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
            child: Container(
              margin: const EdgeInsets.only(bottom: 16),
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
                  // Nombre y logo
                  Row(
                    children: [
                      Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: Colors.grey[200]!,
                            width: 1,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: _getCompanyColor(enterprise.name).withValues(alpha: 0.2),
                              blurRadius: 8,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: enterprise.logoUrl != null && enterprise.logoUrl!.isNotEmpty
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(11),
                                child: Image.network(
                                  enterprise.logoUrl!,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Container(
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                          colors: [
                                            _getCompanyColor(enterprise.name),
                                            _getCompanyColor(enterprise.name).withValues(alpha: 0.7),
                                          ],
                                        ),
                                        borderRadius: BorderRadius.circular(11),
                                      ),
                                      child: Center(
                                        child: PhosphorIcon(
                                          _getCompanyIcon(enterprise.name),
                                          color: Colors.white,
                                          size: 28,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              )
                            : Container(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                    colors: [
                                      _getCompanyColor(enterprise.name),
                                      _getCompanyColor(enterprise.name).withValues(alpha: 0.7),
                                    ],
                                  ),
                                  borderRadius: BorderRadius.circular(11),
                                ),
                                child: Center(
                                  child: PhosphorIcon(
                                    _getCompanyIcon(enterprise.name),
                                    color: Colors.white,
                                    size: 28,
                                  ),
                                ),
                              ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              enterprise.name,
                              style: const TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 16,
                                letterSpacing: -0.2,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                PhosphorIcon(
                                  PhosphorIcons.briefcase(),
                                  size: 14,
                                  color: Colors.grey[500],
                                ),
                                const SizedBox(width: 6),
                                Expanded(
                                  child: Text(
                                    _getRole(enterprise.name),
                                    style: TextStyle(
                                      color: Colors.grey[600],
                                      fontSize: 13,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  // Certificaciones como tags
                  if (enterprise.certifications.isNotEmpty)
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: enterprise.certifications.take(2).map((cert) {
                        return _buildTag(cert, PhosphorIcons.certificate());
                      }).toList(),
                    ),
                  const SizedBox(height: 16),
                  // Botones
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).push(
                              PageRouteBuilder(
                                pageBuilder: (context, animation, secondaryAnimation) =>
                                    CompanyDetailScreen(
                                      companyId: enterprise.id,
                                      companyName: enterprise.name,
                                    ),
                                transitionsBuilder: (context, animation, secondaryAnimation, child) {
                                  return FadeTransition(
                                    opacity: animation,
                                    child: SlideTransition(
                                      position: Tween<Offset>(
                                        begin: const Offset(0.1, 0),
                                        end: Offset.zero,
                                      ).animate(
                                        CurvedAnimation(
                                          parent: animation,
                                          curve: Curves.easeOut,
                                        ),
                                      ),
                                      child: child,
                                    ),
                                  );
                                },
                                transitionDuration: const Duration(milliseconds: 300),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF22C55E),
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            elevation: 0,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                'Ver Detalles',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                ),
                              ),
                              const SizedBox(width: 8),
                              PhosphorIcon(
                                PhosphorIcons.arrowRight(PhosphorIconsStyle.bold),
                                size: 16,
                                color: Colors.white,
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFF22C55E).withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: IconButton(
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
                                    Expanded(
                                      child: Text(
                                        'Verificando ${enterprise.name} en blockchain...',
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
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
                          icon: PhosphorIcon(
                            PhosphorIcons.link(PhosphorIconsStyle.bold),
                            color: const Color(0xFF22C55E),
                            size: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildTag(String label, PhosphorIconData icon) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xFF22C55E).withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: const Color(0xFF22C55E).withValues(alpha: 0.2),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          PhosphorIcon(icon, size: 14, color: const Color(0xFF22C55E)),
          const SizedBox(width: 6),
          Flexible(
            child: Text(
              label,
              style: const TextStyle(
                color: Color(0xFF22C55E),
                fontSize: 11,
                fontWeight: FontWeight.w600,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
