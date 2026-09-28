import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme.dart';

class SectionHeader extends StatelessWidget {
  final String title;
  final String? action;
  final VoidCallback? onAction;
  const SectionHeader({super.key, required this.title, this.action, this.onAction});

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.fromLTRB(20, 0, 20, 12),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: GoogleFonts.plusJakartaSans(
            fontSize: 15, fontWeight: FontWeight.w800, color: AppColors.navy)),
        if (action != null)
          GestureDetector(onTap: onAction,
            child: Text('$action →', style: GoogleFonts.plusJakartaSans(
                fontSize: 12, fontWeight: FontWeight.w700, color: AppColors.brand))),
      ],
    ),
  );
}

class AppAvatar extends StatelessWidget {
  final String initials;
  final Color color;
  final double size;
  const AppAvatar({super.key, required this.initials, required this.color, this.size = 36});

  @override
  Widget build(BuildContext context) => Container(
    width: size, height: size,
    decoration: BoxDecoration(color: color, shape: BoxShape.circle),
    alignment: Alignment.center,
    child: Text(initials, style: GoogleFonts.plusJakartaSans(
        fontSize: size * 0.3, fontWeight: FontWeight.w900, color: Colors.white)),
  );
}

class PillBadge extends StatelessWidget {
  final String label;
  final Color color, bg;
  const PillBadge({super.key, required this.label, required this.color, required this.bg});

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
    decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(20)),
    child: Text(label, style: GoogleFonts.jetBrainsMono(
        fontSize: 9, fontWeight: FontWeight.w700, color: color, letterSpacing: 0.4)),
  );
}

class AppCard extends StatelessWidget {
  final Widget child;
  final EdgeInsets? padding;
  final Color? borderColor;
  final double radius;
  const AppCard({super.key, required this.child, this.padding, this.borderColor, this.radius = 18});

  @override
  Widget build(BuildContext context) => Container(
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(radius),
      border: Border.all(color: borderColor ?? AppColors.border),
    ),
    child: padding != null ? Padding(padding: padding!, child: child) : child,
  );
}

class AppToggle extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onChanged;
  const AppToggle({super.key, required this.value, required this.onChanged});

  @override
  Widget build(BuildContext context) => GestureDetector(
    onTap: () => onChanged(!value),
    child: AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      width: 44, height: 26,
      padding: const EdgeInsets.all(3),
      decoration: BoxDecoration(
        color: value ? AppColors.brand : AppColors.grayLight,
        borderRadius: BorderRadius.circular(13),
      ),
      alignment: value ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        width: 20, height: 20,
        decoration: BoxDecoration(
          color: Colors.white, shape: BoxShape.circle,
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.15), blurRadius: 4)],
        ),
      ),
    ),
  );
}

class BrandButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  const BrandButton({super.key, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) => GestureDetector(
    onTap: onTap,
    child: Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 15),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppColors.brand, AppColors.brandDark],
          begin: Alignment.topLeft, end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(14),
        boxShadow: [BoxShadow(
          color: AppColors.brand.withOpacity(0.35),
          blurRadius: 20, offset: const Offset(0, 6))],
      ),
      alignment: Alignment.center,
      child: Text(label, style: GoogleFonts.plusJakartaSans(
          fontSize: 15, fontWeight: FontWeight.w800, color: Colors.white)),
    ),
  );
}

class DualTabBar extends StatelessWidget {
  final int selected;
  final List<String> labels;
  final ValueChanged<int> onChanged;
  const DualTabBar({super.key, required this.selected, required this.labels, required this.onChanged});

  @override
  Widget build(BuildContext context) => AppCard(
    radius: 14,
    child: Padding(
      padding: const EdgeInsets.all(4),
      child: Row(
        children: List.generate(labels.length, (i) {
          final active = selected == i;
          return Expanded(
            child: GestureDetector(
              onTap: () => onChanged(i),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 150),
                padding: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  gradient: active ? const LinearGradient(
                    colors: [AppColors.brand, AppColors.brandDark],
                    begin: Alignment.topLeft, end: Alignment.bottomRight,
                  ) : null,
                  borderRadius: BorderRadius.circular(11),
                ),
                alignment: Alignment.center,
                child: Text(labels[i], style: GoogleFonts.plusJakartaSans(
                    fontSize: 12, fontWeight: FontWeight.w800,
                    color: active ? Colors.white : AppColors.gray)),
              ),
            ),
          );
        }),
      ),
    ),
  );
}
