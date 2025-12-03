import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:provider/provider.dart';
import '../../../core/providers/app_state_provider.dart';
import 'company_detail_screen.dart';

class CompaniesScreen extends StatefulWidget {
  const CompaniesScreen({super.key});

  @override
  State<CompaniesScreen> createState() => _CompaniesScreenState();
}

class _CompaniesScreenState extends State<CompaniesScreen>
    with SingleTickerProviderStateMixin {
  List<CompanyInfo> _companies = [];
  bool _isLoading = true;
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
    _loadCompanies();
  }

  Future<void> _loadCompanies() async {
    final provider = Provider.of<AppStateProvider>(context, listen: false);

    setState(() {
      _companies = provider.companies;
      _isLoading = false;
    });
    _animationController.forward();
  }

  String _getRole(String companyName) {
    if (companyName.toLowerCase().contains('finca') ||
        companyName.toLowerCase().contains('farm')) {
      return 'Productor';
    } else if (companyName.toLowerCase().contains('empacadora') ||
        companyName.toLowerCase().contains('packer')) {
      return 'Empacador';
    } else if (companyName.toLowerCase().contains('distributor') ||
        companyName.toLowerCase().contains('logistics')) {
      return 'Distribuidor';
    }
    return 'Socio';
  }

  PhosphorIconData _getCompanyIcon(String companyName) {
    final name = companyName.toLowerCase();
    if (name.contains('finca') ||
        name.contains('farm') ||
        name.contains('agro')) {
      return PhosphorIcons.plant(PhosphorIconsStyle.fill);
    } else if (name.contains('empacadora') ||
        name.contains('packer') ||
        name.contains('pack')) {
      return PhosphorIcons.package(PhosphorIconsStyle.fill);
    } else if (name.contains('distributor') ||
        name.contains('logistics') ||
        name.contains('transport')) {
      return PhosphorIcons.truck(PhosphorIconsStyle.fill);
    } else if (name.contains('store') ||
        name.contains('tienda') ||
        name.contains('market')) {
      return PhosphorIcons.storefront(PhosphorIconsStyle.fill);
    } else if (name.contains('fresh') || name.contains('organic')) {
      return PhosphorIcons.leaf(PhosphorIconsStyle.fill);
    }
    return PhosphorIcons.buildings(PhosphorIconsStyle.fill);
  }

  Color _getCompanyColor(String companyName) {
    final name = companyName.toLowerCase();
    if (name.contains('finca') ||
        name.contains('farm') ||
        name.contains('agro')) {
      return const Color(0xFF16A34A); // Green
    } else if (name.contains('empacadora') ||
        name.contains('packer') ||
        name.contains('pack')) {
      return const Color(0xFF0891B2); // Cyan
    } else if (name.contains('distributor') ||
        name.contains('logistics') ||
        name.contains('transport')) {
      return const Color(0xFFEA580C); // Orange
    } else if (name.contains('store') ||
        name.contains('tienda') ||
        name.contains('market')) {
      return const Color(0xFF7C3AED); // Purple
    } else if (name.contains('fresh') || name.contains('organic')) {
      return const Color(0xFF22C55E); // Primary green
    }
    return const Color(0xFF22C55E); // Default
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        backgroundColor: Colors.white,
        body: Center(child: CircularProgressIndicator()),
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
        itemCount: _companies.length,
        itemBuilder: (context, index) {
          final company = _companies[index];
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
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              _getCompanyColor(company.name),
                              _getCompanyColor(
                                company.name,
                              ).withValues(alpha: 0.7),
                            ],
                          ),
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: _getCompanyColor(
                                company.name,
                              ).withValues(alpha: 0.3),
                              blurRadius: 8,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child:
                            company.logoUrl != null &&
                                    company.logoUrl!.isNotEmpty
                                ? ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: Image.network(
                                    company.logoUrl!,
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) {
                                      return Center(
                                        child: PhosphorIcon(
                                          _getCompanyIcon(company.name),
                                          color: Colors.white,
                                          size: 32,
                                        ),
                                      );
                                    },
                                  ),
                                )
                                : Center(
                                  child: PhosphorIcon(
                                    _getCompanyIcon(company.name),
                                    color: Colors.white,
                                    size: 32,
                                  ),
                                ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              company.name,
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
                                Text(
                                  _getRole(company.name),
                                  style: TextStyle(
                                    color: Colors.grey[600],
                                    fontSize: 14,
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
                  const SizedBox(height: 16),
                  // Tags
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      if (company.name.toLowerCase().contains('organic'))
                        _buildTag('Orgánico', PhosphorIcons.leaf()),
                      if (company.name.toLowerCase().contains('fair'))
                        _buildTag('Comercio Justo', PhosphorIcons.handshake()),
                      _buildTag('ISO 22000', PhosphorIcons.certificate()),
                    ],
                  ),
                  const SizedBox(height: 16),
                  // Botones
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {
                            Navigator.of(context).push(
                              PageRouteBuilder(
                                pageBuilder:
                                    (context, animation, secondaryAnimation) =>
                                        CompanyDetailScreen(
                                          companyId: company.id,
                                          companyName: company.name,
                                        ),
                                transitionsBuilder: (
                                  context,
                                  animation,
                                  secondaryAnimation,
                                  child,
                                ) {
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
                                transitionDuration: const Duration(
                                  milliseconds: 300,
                                ),
                              ),
                            );
                          },
                          style: OutlinedButton.styleFrom(
                            foregroundColor: Colors.black,
                            side: BorderSide(
                              color: Colors.grey[300]!,
                              width: 1.5,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 12),
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
                                PhosphorIcons.arrowRight(
                                  PhosphorIconsStyle.bold,
                                ),
                                size: 16,
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      IconButton(
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Row(
                                children: [
                                  PhosphorIcon(
                                    PhosphorIcons.link(),
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                  const SizedBox(width: 12),
                                  Text(
                                    'Abriendo blockchain para ${company.name}',
                                  ),
                                ],
                              ),
                              behavior: SnackBarBehavior.floating,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          );
                        },
                        style: IconButton.styleFrom(
                          backgroundColor: const Color(
                            0xFF22C55E,
                          ).withValues(alpha: 0.1),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        icon: PhosphorIcon(
                          PhosphorIcons.link(PhosphorIconsStyle.bold),
                          color: const Color(0xFF22C55E),
                          size: 20,
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
          Text(
            label,
            style: const TextStyle(
              color: Color(0xFF22C55E),
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
