import 'package:flutter/material.dart';
import 'package:userapp/core/core.dart';

class CustomButton extends StatelessWidget {
  const CustomButton.whiteOutlined({
    required this.text,
    required this.state,
    super.key,
    this.onTap,
    this.textColor = Colors.white,
  }) : borderColor = Colors.white,
       backgroundColor = Colors.transparent;

  CustomButton.blue({
    required this.text,
    required this.state,
    super.key,
    this.onTap,
    this.textColor = Colors.white,
  }) : borderColor = null,
       backgroundColor = state == ButtonState.enabled
           ? Colors.blue
           : Colors.blue.withValues(alpha: 0.2);

  final String text;
  final Color textColor;
  final Color? borderColor;
  final Color? backgroundColor;

  final ButtonState state;
  final VoidCallback? onTap;

  @override
  Widget build(final BuildContext context) => SizedBox(
    width: double.maxFinite,
    height: context.screenOrientation == Orientation.portrait
        ? context.screenHeight * 0.05
        : context.screenHeight * 0.06,
    child: ElevatedButton(
      onPressed: state == ButtonState.enabled ? onTap : null,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        shadowColor: backgroundColor,
        surfaceTintColor: backgroundColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        side: BorderSide(
          color: state == ButtonState.enabled
              ? borderColor ?? Colors.transparent
              : borderColor?.withValues(alpha: 0.1) ?? Colors.transparent,
        ),
      ),
      child: state == ButtonState.loading
          ? const SizedBox(
              height: 16,
              width: 16,
              child: CircularProgressIndicator.adaptive(strokeWidth: 3),
            )
          : Text(text, style: Theme.of(context).textTheme.titleMedium?.copyWith(color: textColor)),
    ),
  );
}
