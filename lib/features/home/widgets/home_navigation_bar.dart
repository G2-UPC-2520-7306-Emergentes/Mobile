import 'package:flutter/material.dart';

import '../../../core/widgets/elevated_surface.dart';
import '../domain/home_nav_item.dart';

class HomeNavigationBar extends StatelessWidget {
  const HomeNavigationBar({
    super.key,
    required this.selected,
    required this.onItemSelected,
  });

  final HomeNavItem selected;
  final ValueChanged<HomeNavItem> onItemSelected;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
      child: ElevatedSurface(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: HomeNavItem.values
              .map(
                (item) => _AnimatedNavigationItem(
                  item: item,
                  isSelected: item == selected,
                  onTap: () => onItemSelected(item),
                  highlightColor: colorScheme.primary,
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}

class _AnimatedNavigationItem extends StatefulWidget {
  const _AnimatedNavigationItem({
    required this.item,
    required this.isSelected,
    required this.onTap,
    required this.highlightColor,
  });

  final HomeNavItem item;
  final bool isSelected;
  final VoidCallback onTap;
  final Color highlightColor;

  @override
  State<_AnimatedNavigationItem> createState() =>
      _AnimatedNavigationItemState();
}

class _AnimatedNavigationItemState extends State<_AnimatedNavigationItem>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 320),
  );

  @override
  void initState() {
    super.initState();
    if (widget.isSelected) {
      _controller.value = 1;
    }
  }

  @override
  void didUpdateWidget(covariant _AnimatedNavigationItem oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isSelected != oldWidget.isSelected) {
      if (widget.isSelected) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return GestureDetector(
      onTap: widget.onTap,
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 320),
        curve: Curves.easeOutExpo,
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          color: widget.isSelected
              ? widget.highlightColor.withValues(alpha: 0.18)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(18),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ScaleTransition(
              scale: Tween(begin: 0.92, end: 1.12).animate(
                CurvedAnimation(parent: _controller, curve: Curves.elasticOut),
              ),
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Icon(
                    widget.item.icon,
                    size: 26,
                    color: widget.isSelected
                        ? widget.highlightColor
                        : colorScheme.onSurfaceVariant,
                  ),
                  Positioned(
                    right: -2,
                    top: -6,
                    child: FadeTransition(
                      opacity: Tween<double>(begin: 0, end: 1).animate(
                        CurvedAnimation(
                          parent: _controller,
                          curve: const Interval(0.4, 1),
                        ),
                      ),
                      child: AnimatedScale(
                        scale: widget.isSelected ? 1 : 0,
                        duration: const Duration(milliseconds: 280),
                        curve: Curves.easeOutBack,
                        child: Icon(
                          Icons.circle,
                          size: 6,
                          color: widget.highlightColor,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 6),
            AnimatedDefaultTextStyle(
              duration: const Duration(milliseconds: 250),
              curve: Curves.easeOut,
              style: theme.textTheme.labelMedium!.copyWith(
                color: widget.isSelected
                    ? widget.highlightColor
                    : colorScheme.onSurfaceVariant,
                fontWeight: widget.isSelected
                    ? FontWeight.w700
                    : FontWeight.w500,
                letterSpacing: widget.isSelected ? 0.2 : 0,
              ),
              child: Text(widget.item.label),
            ),
          ],
        ),
      ),
    );
  }
}
