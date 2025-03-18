part of '../../feature.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    super.key,
    required this.buttonText,
    required this.onPressed,
    required this.isActive,
    this.height,
    this.buttonColor,
    this.buttonInactiveColor,
    this.buttonTextStyle,
    this.width,
  });

  final String buttonText;
  final Function() onPressed;
  final bool isActive;
  final double? height;
  final Color? buttonColor;
  final Color? buttonInactiveColor;
  final TextStyle? buttonTextStyle;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height ?? AppValues.height56,
      width: width ?? screenSize(context).width,
      child: TextButton(
        onPressed: () => isActive ? onPressed() : () {},
        style: TextButton.styleFrom(
          backgroundColor: isActive
              ? buttonColor ?? context.primaryButtonColor
              : buttonInactiveColor ??
                  context.primaryButtonColor.withValues(alpha: 0.32),
          padding: EdgeInsets.symmetric(vertical: AppValues.padding16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
        ),
        child: Text(
          buttonText,
          style: buttonTextStyle ??
              AppTheme.of(context).bodyExtraLarge18.copyWith(
                  fontWeight: FontWeight.w500, color: context.buttonTextColor),
        ),
      ),
    );
  }
}
