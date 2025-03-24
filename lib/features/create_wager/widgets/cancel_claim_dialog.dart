part of '../../feature.dart';

class DashedLinePainter extends CustomPainter {
  final Color color;
  final double dashWidth;
  final double dashSpace;

  DashedLinePainter({
    required this.color,
    required this.dashWidth,
    required this.dashSpace,
  });

  @override
  void paint(Canvas canvas, Size size) {
    double startX = 0;
    final paint = Paint()
      ..color = color
      ..strokeWidth = size.height;

    while (startX < size.width) {
      canvas.drawLine(
        Offset(startX, 0),
        Offset(startX + dashWidth, 0),
        paint,
      );
      startX += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

// Dialog content that can be shown either in a bottom sheet or a dialog
class CancelClaimDialog extends StatelessWidget {
  final VoidCallback? onCancel;
  final VoidCallback? onClose;

  const CancelClaimDialog({
    super.key,
    this.onCancel,
    this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.isDarkMode
            ? context.dialogDarkBackground
            : context.containerColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      padding: const EdgeInsets.fromLTRB(24, 32, 24, 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'importantDisclaimer'.tr(),
            style: AppTheme.of(context).titleExtraLarge24.copyWith(
                  fontWeight: FontWeight.w600,
                ),
          ),
          verticalSpace(24),
          Text(
            'winningsCreditedAfterConfirmation'.tr(),
            textAlign: TextAlign.center,
            style: AppTheme.of(context).bodyLarge16.copyWith(
                  color: context.subTitleTextColor,
                ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: SizedBox(
              width: double.infinity,
              height: 1,
              child: CustomPaint(
                painter: DashedLinePainter(
                  color: context.dividerColor,
                  dashWidth: 5,
                  dashSpace: 3,
                ),
              ),
            ),
          ),
          Text(
            'avoidClaimingWithoutProof'.tr(),
            textAlign: TextAlign.center,
            style: AppTheme.of(context).bodyLarge16.copyWith(
                  color: context.subTitleTextColor,
                ),
          ),
          verticalSpace(32),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 96,
                height: 56,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: context.isDarkMode
                        ? Colors.white
                        : context.cancelButtonLight,
                    foregroundColor: context.isDarkMode
                        ? Colors.black
                        : context.primaryTextColor,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    padding: EdgeInsets.zero,
                  ),
                  child: Text(
                    'cancel'.tr(),
                    style: AppTheme.of(context).textMediumMedium.copyWith(
                          color: context.isDarkMode
                              ? Colors.black
                              : context.primaryTextColor,
                        ),
                  ),
                ),
              ),
              horizontalSpace(12),
              Expanded(
                child: SizedBox(
                  height: 56,
                  child: PrimaryButton(
                    buttonText: 'proceedWithClaim'.tr(),
                    buttonColor: context.primaryButtonColor,
                    onPressed: () {
                      onCancel?.call();
                      Navigator.pop(context);
                    },
                    isActive: true,
                    height: 56,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
