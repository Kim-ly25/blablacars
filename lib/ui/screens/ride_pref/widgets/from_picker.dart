import 'package:flutter/material.dart';
import '../../../theme/theme.dart';

/// Custom row widget used in form to display icon and text
Widget buildFormRow({
  required IconData leadingIcon,
  required String placeholder,
  String? selectedValue,
  bool enableSwap = false,
  required VoidCallback onPressed,
  VoidCallback? onSwapPressed,
}) {
  final bool hasValue = selectedValue != null;

  return InkWell(
    onTap: onPressed,
    child: Container(
      padding: const EdgeInsets.symmetric(
        horizontal: BlaSpacings.m,
        vertical: BlaSpacings.m,
      ),

      child: Row(
        children: [
          /// Left icon
          Icon(leadingIcon, size: 24, color: hasValue
            ? BlaColors.neutralDark
            : BlaColors.neutralLight,
          ),
          const SizedBox(width: BlaSpacings.m),

          /// Text content
          Expanded(
            child: Text(
              hasValue ? selectedValue : placeholder,
              style: BlaTextStyles.body.copyWith(
                color: hasValue
                    ? BlaColors.neutralDark
                    : BlaColors.neutralLight,
              ),
            ),
          ),

          /// Swap icon (optional)
          if (enableSwap)
            InkWell(
              onTap: onSwapPressed,
              child: Icon(
                Icons.swap_vert,
                size: 24,
                color: BlaColors.primary,
              ),
            ),
        ],
      ),
    ),
  );
}
