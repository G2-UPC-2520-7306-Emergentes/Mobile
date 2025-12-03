import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:provider/provider.dart';
import '../../../core/providers/app_state_provider.dart';

class BlockchainVerificationScreen extends StatefulWidget {
  const BlockchainVerificationScreen({super.key});

  @override
  State<BlockchainVerificationScreen> createState() => _BlockchainVerificationScreenState();
}

class _BlockchainVerificationScreenState extends State<BlockchainVerificationScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;

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

    _scaleAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOutBack,
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AppStateProvider>(context);
    final batch = provider.currentBatch;
    final steps = provider.currentSteps;

    if (batch == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Verificación en blockchain')),
        body: const Center(child: Text('No hay datos disponibles')),
      );
    }

    // Determinar estado
    final hasEmptyHashes = steps.any((s) => s.hash.isEmpty);
    final allHaveHashes = steps.every((s) => s.hash.isNotEmpty);

    VerificationState state;
    if (allHaveHashes && steps.isNotEmpty) {
      state = VerificationState.verified;
    } else if (hasEmptyHashes) {
      state = VerificationState.pending;
    } else {
      state = VerificationState.inconsistent;
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
          'Verificación',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w700,
            fontSize: 18,
            letterSpacing: -0.2,
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 20),
                  // Estado con animación
                  FadeTransition(
                    opacity: _fadeAnimation,
                    child: ScaleTransition(
                      scale: _scaleAnimation,
                      child: _buildStateWidget(state),
                    ),
                  ),
                  const SizedBox(height: 24),
                  // Descripción
                  Text(
                    _getStateDescription(state),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 32),
                  // Hash y Transaction ID
                  if (state == VerificationState.verified) ...[
                    _buildHashRow('#', '0×8f12...ab...'),
                    const SizedBox(height: 16),
                    _buildHashRow('#', 'tx_0×9c4...'),
                  ] else if (state == VerificationState.pending) ...[
                    _buildHashRow('#', '0×8f12...ab...'),
                    const SizedBox(height: 16),
                    _buildHashRow('#', 'tx_0×9c4.....'),
                  ] else ...[
                    _buildHashRow('[#]', 'Hash'),
                    const SizedBox(height: 16),
                    _buildHashRow('[#]', 'Transaction ID'),
                  ],
                  const SizedBox(height: 24),
                  // Red info
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    decoration: BoxDecoration(
                      color: Colors.grey[50],
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.grey[200]!),
                    ),
                    child: Row(
                      children: [
                        PhosphorIcon(
                          PhosphorIcons.globe(PhosphorIconsStyle.fill),
                          size: 18,
                          color: Colors.grey[600],
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            'Polygon Amoy Testnet',
                            style: TextStyle(
                              color: Colors.grey[800],
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: const Color(0xFF22C55E).withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                width: 6,
                                height: 6,
                                decoration: const BoxDecoration(
                                  color: Color(0xFF22C55E),
                                  shape: BoxShape.circle,
                                ),
                              ),
                              const SizedBox(width: 6),
                              const Text(
                                'Activo',
                                style: TextStyle(
                                  color: Color(0xFF22C55E),
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 32),
                  // Botones
                  if (state == VerificationState.verified)
                    SizedBox(
                      width: double.infinity,
                      height: 52,
                      child: ElevatedButton(
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Abriendo explorador blockchain...'),
                              duration: Duration(seconds: 2),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF22C55E),
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 2,
                          shadowColor: const Color(0xFF22C55E).withValues(alpha: 0.4),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            PhosphorIcon(
                              PhosphorIcons.arrowSquareOut(PhosphorIconsStyle.bold),
                              color: Colors.white,
                              size: 20,
                            ),
                            const SizedBox(width: 10),
                            const Text(
                              'Ver en explorador',
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 15,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  else if (state == VerificationState.pending)
                    Container(
                      width: double.infinity,
                      height: 56,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Color(0xFFF59E0B),
                            Color(0xFFD97706),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFFF59E0B).withValues(alpha: 0.5),
                            blurRadius: 16,
                            offset: const Offset(0, 6),
                            spreadRadius: 0,
                          ),
                        ],
                      ),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          borderRadius: BorderRadius.circular(16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: Colors.white.withValues(alpha: 0.2),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: PhosphorIcon(
                                  PhosphorIcons.clockCountdown(PhosphorIconsStyle.fill),
                                  color: Colors.white,
                                  size: 22,
                                ),
                              ),
                              const SizedBox(width: 14),
                              const Text(
                                'Revisar más tarde',
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 17,
                                  color: Colors.white,
                                  letterSpacing: -0.3,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  else
                    Column(
                      children: [
                        SizedBox(
                          width: double.infinity,
                          height: 48,
                          child: ElevatedButton(
                            onPressed: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Abriendo explorador blockchain...'),
                                  duration: Duration(seconds: 2),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: const Text(
                              'Ver en explorador',
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        SizedBox(
                          width: double.infinity,
                          height: 48,
                          child: OutlinedButton(
                            onPressed: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Reintentando verificación...'),
                                  duration: Duration(seconds: 2),
                                ),
                              );
                            },
                            style: OutlinedButton.styleFrom(
                              foregroundColor: Colors.black,
                              side: const BorderSide(color: Colors.grey),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: const Text(
                              'Reintentar verificación',
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                      ],
                    ),
                  const SizedBox(height: 24),
                  // Nota adicional
                  if (state == VerificationState.verified)
                    Text(
                      'Información confirmada en la blockchain.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 13,
                      ),
                    )
                  else if (state == VerificationState.pending)
                    Text(
                      'El sistema actualizará automáticamente el estado cuando la verificación se complete.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 13,
                      ),
                    )
                  else
                    Text(
                      'El sistema continuará intentando la verificación.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 13,
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

  Widget _buildStateWidget(VerificationState state) {
    PhosphorIconData icon;
    Color color;
    String text;

    switch (state) {
      case VerificationState.verified:
        icon = PhosphorIcons.sealCheck(PhosphorIconsStyle.fill);
        color = const Color(0xFF22C55E);
        text = 'Verificado';
        break;
      case VerificationState.pending:
        icon = PhosphorIcons.clock(PhosphorIconsStyle.fill);
        color = Colors.amber[700]!;
        text = 'En verificación';
        break;
      case VerificationState.inconsistent:
        icon = PhosphorIcons.warningCircle(PhosphorIconsStyle.fill);
        color = Colors.red[600]!;
        text = 'Inconsistencia detectada';
        break;
    }

    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: PhosphorIcon(icon, size: 64, color: color),
          ),
          const SizedBox(height: 20),
          Text(
            text,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w700,
              color: color,
              letterSpacing: -0.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHashRow(String prefix, String hash) {
    return Builder(
      builder: (context) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.grey[50],
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.grey[200]!),
        ),
        child: Row(
          children: [
            PhosphorIcon(
              PhosphorIcons.hash(PhosphorIconsStyle.bold),
              size: 18,
              color: Colors.grey[600],
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                hash,
                style: TextStyle(
                  fontSize: 14,
                  fontFamily: 'monospace',
                  color: Colors.grey[800],
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                Clipboard.setData(ClipboardData(text: hash));
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Row(
                      children: [
                        PhosphorIcon(
                          PhosphorIcons.checkCircle(PhosphorIconsStyle.fill),
                          color: Colors.white,
                          size: 18,
                        ),
                        const SizedBox(width: 8),
                        const Text('Hash copiado al portapapeles'),
                      ],
                    ),
                    backgroundColor: const Color(0xFF22C55E),
                    duration: const Duration(seconds: 2),
                    behavior: SnackBarBehavior.floating,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                );
              },
              style: TextButton.styleFrom(
                foregroundColor: const Color(0xFF22C55E),
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              ),
              child: const Text(
                'Copiar',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getStateDescription(VerificationState state) {
    switch (state) {
      case VerificationState.verified:
        return 'Toda la trazabilidad está registrada en la blockchain y no ha sido alterada.';
      case VerificationState.pending:
        return 'Algunos pasos de la trazabilidad de este lote todavía están siendo confirmados en la blockchain.';
      case VerificationState.inconsistent:
        return 'Se detectó una diferencia con la blockchain. Nuestro equipo ya fue notificado.';
    }
  }
}

enum VerificationState {
  verified,
  pending,
  inconsistent,
}
