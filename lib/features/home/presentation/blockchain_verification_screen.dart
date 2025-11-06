import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../../../core/providers/app_state_provider.dart';

class BlockchainVerificationScreen extends StatelessWidget {
  const BlockchainVerificationScreen({super.key});

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
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Verificación en blockchain',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings, color: Colors.black),
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
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Lock icon
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey[300]!),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(Icons.lock_outline, size: 20),
                      ),
                      const SizedBox(width: 12),
                      const Text(
                        'LockSimple',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),
                  // Estado
                  _buildStateWidget(state),
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
                  if (state == VerificationState.verified)
                    Row(
                      children: [
                        Icon(Icons.wifi, size: 16, color: Colors.grey[600]),
                        const SizedBox(width: 8),
                        Text(
                          'Ethereum mainnet',
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 14,
                          ),
                        ),
                        const Spacer(),
                        Container(
                          width: 8,
                          height: 8,
                          decoration: const BoxDecoration(
                            color: Colors.green,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ],
                    )
                  else if (state == VerificationState.pending)
                    Row(
                      children: [
                        Icon(Icons.wifi, size: 16, color: Colors.grey[600]),
                        const SizedBox(width: 8),
                        Text(
                          'Ethereum mainn...',
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 14,
                          ),
                        ),
                        const Spacer(),
                        Container(
                          width: 8,
                          height: 8,
                          decoration: const BoxDecoration(
                            color: Colors.green,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ],
                    )
                  else
                    Row(
                      children: [
                        Text(
                          '[ud83d\udd17] Network',
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 14,
                          ),
                        ),
                        const Spacer(),
                        Container(
                          width: 8,
                          height: 8,
                          decoration: const BoxDecoration(
                            color: Colors.green,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ],
                    ),
                  const SizedBox(height: 32),
                  // Botones
                  if (state == VerificationState.verified)
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
                          backgroundColor: const Color(0xFF4ADE80),
                          foregroundColor: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text(
                          'Ver en explorador',
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                      ),
                    )
                  else if (state == VerificationState.pending)
                    SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.amber,
                          foregroundColor: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text(
                          'Revisar más tarde',
                          style: TextStyle(fontWeight: FontWeight.w600),
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
    IconData icon;
    Color color;
    String text;

    switch (state) {
      case VerificationState.verified:
        icon = Icons.check_circle;
        color = Colors.green;
        text = 'Verificado';
        break;
      case VerificationState.pending:
        icon = Icons.warning;
        color = Colors.amber;
        text = 'En verificación';
        break;
      case VerificationState.inconsistent:
        icon = Icons.close;
        color = Colors.red;
        text = 'Inconsistencia detectada';
        break;
    }

    return Column(
      children: [
        Icon(icon, size: 64, color: color),
        const SizedBox(height: 16),
        Text(
          text,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w700,
            color: color,
          ),
        ),
      ],
    );
  }

  Widget _buildHashRow(String prefix, String hash) {
    return Builder(
      builder: (context) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Text(
                prefix,
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(width: 8),
              Text(
                hash,
                style: const TextStyle(
                  fontSize: 14,
                  fontFamily: 'monospace',
                ),
              ),
            ],
          ),
          TextButton(
            onPressed: () {
              Clipboard.setData(ClipboardData(text: hash));
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Hash copiado al portapapeles'),
                  duration: Duration(seconds: 2),
                ),
              );
            },
            child: const Text('Copiar'),
          ),
        ],
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
