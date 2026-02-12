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

  Color get _background => isPrimary ? BlaColors.primary : BlaColors.greyLight;
  Color get _foreground => isPrimary ? BlaColors.white : BlaColors.primary;
  BorderSide get _border => isPrimary
      ? BorderSide.none
      : BorderSide(color: BlaColors.neutralLight, width: 1);

  Widget _buildContent() {
    if (icon == null) {
      return Text(text);
    }

    final iconWidget = Icon(icon, size: 20);
    final textWidget = Text(text);
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: isIconOnRight
          ? [textWidget, const SizedBox(width: 8), iconWidget]
          : [iconWidget, const SizedBox(width: 8), textWidget],
    );
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: _background,
        foregroundColor: _foreground,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20), side: _border,
        ),
      ),

      child: _buildContent(),
    );
  }
}
