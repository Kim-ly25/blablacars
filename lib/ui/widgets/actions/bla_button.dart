import 'package:flutter/material.dart';
import '../../theme/theme.dart';

class BlaButton extends StatelessWidget {
  final String text;
  final bool isPrimary;
  final VoidCallback? onPressed;
  final IconData? icon;
  final bool isIconOnRight;

  const BlaButton({
    super.key,
    required this.text,
    this.isPrimary = true,
    this.onPressed,
    this.icon,
    this.isIconOnRight = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: isPrimary ? BlaColors.primary : Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          side: BorderSide(
            color: isPrimary ? BlaColors.primary : BlaColors.greyLight,
            width: 1,
          ),
          shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(24),
          ),
          elevation: 0,
        ),

        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [ _buildContent(),],
        ),
      ),
    );
  }

  Widget _buildContent() {
    if (icon == null) {
      return Text(text);
    }

    final widgets = isIconOnRight
        ? [Text(text), const SizedBox(width: 8), Icon(icon, size: 20)]
        : [Icon(icon, size: 20), const SizedBox(width: 8), Text(text)];

    return Row(mainAxisSize: MainAxisSize.min, children: widgets);
  }
}
