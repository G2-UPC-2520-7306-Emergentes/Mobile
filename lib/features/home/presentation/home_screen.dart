import 'package:flutter/material.dart';
import 'package:flutter_application_1/features/home/presentation/qr_scanner_screen.dart';

import '../../../core/widgets/primary_button.dart';
import '../domain/home_nav_item.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _pulseController = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1800),
    lowerBound: 0,
    upperBound: 1,
  )..repeat(reverse: true);

  late final Animation<double> _pulseAnimation = Tween(
    begin: 0.97,
    end: 1.04,
  ).animate(CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut));

  HomeNavItem _selectedNavItem = HomeNavItem.history;

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  void _onScanPressed() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const QRScannerScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            _buildAppBar(colorScheme),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Spacer(flex: 2),
                    _buildTitle(theme),
                    const SizedBox(height: 12),
                    _buildSubtitle(theme, colorScheme),
                    const SizedBox(height: 48),
                    _buildScanButton(),
                    const SizedBox(height: 20),
                    _buildCameraAccessText(theme, colorScheme),
                    const Spacer(flex: 2),
                    _buildVerifiedInfo(theme, colorScheme),
                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ),
            _buildBottomNavigation(),
          ],
        ),
      ),
    );
  }

  Widget _buildAppBar(ColorScheme colorScheme) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const _BrandingPill(),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.settings_rounded, color: Colors.grey[700], size: 24),
            splashRadius: 24,
          ),
        ],
      ),
    );
  }

  Widget _buildTitle(ThemeData theme) {
    return Text(
      'Scan your product\'s QR code.',
      textAlign: TextAlign.center,
      style: theme.textTheme.headlineMedium?.copyWith(
        fontWeight: FontWeight.w700,
        fontSize: 24,
        color: Colors.black,
        height: 1.3,
      ),
    );
  }

  Widget _buildSubtitle(ThemeData theme, ColorScheme colorScheme) {
    return Text(
      'View its verified history in seconds.',
      textAlign: TextAlign.center,
      style: theme.textTheme.bodyMedium?.copyWith(
        color: Colors.grey[600],
        fontSize: 15,
      ),
    );
  }

  Widget _buildScanButton() {
    return ScaleTransition(
      scale: _pulseAnimation,
      child: SizedBox(
        width: double.infinity,
        child: PrimaryButton(
          label: 'Scan QR Code',
          onPressed: _onScanPressed,
          icon: const Icon(Icons.qr_code_scanner_rounded, size: 22),
        ),
      ),
    );
  }

  Widget _buildCameraAccessText(ThemeData theme, ColorScheme colorScheme) {
    return Text(
      'Camera access required.',
      style: theme.textTheme.bodySmall?.copyWith(
        color: Colors.grey[500],
        fontSize: 13,
      ),
    );
  }

  Widget _buildVerifiedInfo(ThemeData theme, ColorScheme colorScheme) {
    return Column(
      children: [
        _AnimatedAccentIcon(color: colorScheme.primary),
        const SizedBox(height: 16),
        Text(
          'Verified with blockchain and signed QR.',
          textAlign: TextAlign.center,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: colorScheme.primary,
            fontWeight: FontWeight.w600,
            fontSize: 13,
          ),
        ),
      ],
    );
  }

  Widget _buildBottomNavigation() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: HomeNavItem.values.map((item) {
              final isSelected = item == _selectedNavItem;
              return _NavBarItem(
                item: item,
                isSelected: isSelected,
                onTap: () => setState(() => _selectedNavItem = item),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}

class _BrandingPill extends StatelessWidget {
  const _BrandingPill();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            colorScheme.primary.withOpacity(0.12),
            colorScheme.primary.withOpacity(0.05),
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: colorScheme.primary.withOpacity(0.2),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.link_rounded, color: colorScheme.primary, size: 18),
          const SizedBox(width: 8),
          Text(
            'FoodChain',
            style: Theme.of(context)
                .textTheme
                .titleMedium
                ?.copyWith(fontWeight: FontWeight.w700),
          ),
        ],
      ),
    );
  }
}

class _AnimatedAccentIcon extends StatefulWidget {
  const _AnimatedAccentIcon({required this.color});

  final Color color;

  @override
  State<_AnimatedAccentIcon> createState() => _AnimatedAccentIconState();
}

class _AnimatedAccentIconState extends State<_AnimatedAccentIcon>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1800),
  )..repeat(reverse: true);

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        final scale = 1 + (_controller.value * 0.08);
        final blur = 12 + (_controller.value * 12);
        return Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: 54,
              height: 54,
              decoration: BoxDecoration(
                color: widget.color.withOpacity(0.12),
                shape: BoxShape.circle,
              ),
            ),
            Container(
              width: 54,
              height: 54,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: widget.color.withOpacity(0.32),
                    blurRadius: blur,
                    spreadRadius: 4,
                  ),
                ],
              ),
            ),
            Transform.scale(
              scale: scale,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: widget.color,
                  shape: BoxShape.circle,
                ),
                child: const Padding(
                  padding: EdgeInsets.all(14),
                  child: Icon(
                    Icons.verified_rounded,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _NavBarItem extends StatelessWidget {
  const _NavBarItem({
    required this.item,
    required this.isSelected,
    required this.onTap,
  });

  final HomeNavItem item;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              item.icon,
              size: 24,
              color: isSelected ? colorScheme.primary : Colors.grey[600],
            ),
            const SizedBox(height: 4),
            Text(
              item.label,
              style: theme.textTheme.labelSmall?.copyWith(
                color: isSelected ? colorScheme.primary : Colors.grey[600],
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
