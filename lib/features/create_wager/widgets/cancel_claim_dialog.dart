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

class CancelClaimDialog extends StatefulWidget {
  final VoidCallback? onCancel;
  final VoidCallback? onClose;

  const CancelClaimDialog({
    super.key,
    this.onCancel,
    this.onClose,
  });

  @override
  State<CancelClaimDialog> createState() => _CancelClaimDialogState();
}

class _CancelClaimDialogState extends State<CancelClaimDialog> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (context.isMobile) {
        _showBottomSheet(context);
      } else {
        _showDialog(context);
      }
    });
  }

  Future<void> _showBottomSheet(BuildContext context) async {
    final response = await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      isDismissible: true,
      enableDrag: true,
      constraints: BoxConstraints(
        maxWidth:
            MediaQuery.of(context).size.width - 32, // 16px padding on each side
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      builder: (BuildContext context) => _buildBottomSheetContent(context),
    );
    _handleResponse(response);
  }

  Future<void> _showDialog(BuildContext context) async {
    final response = await showDialog(
      context: context,
      builder: (BuildContext context) => _buildDialogContent(context),
    );
    _handleResponse(response);
  }

  void _handleResponse(dynamic response) {
    if (response == null && context.mounted) {
      Navigator.of(context).pop();
    }
  }

  Widget _buildContent(BuildContext context) {
    return Column(
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
                    widget.onCancel?.call();
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
    );
  }

  Widget _buildBottomSheetContent(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 48),
      child: Container(
        decoration: BoxDecoration(
          color: context.isDarkMode
              ? context.dialogDarkBackground
              : context.containerColor,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: context.shadowColor,
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 32, 24, 16),
          child: _buildContent(context),
        ),
      ),
    );
  }

  Widget _buildDialogContent(BuildContext context) {
    return Dialog(
      backgroundColor: context.isDarkMode
          ? context.dialogDarkBackground
          : context.containerColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Container(
        width: 400, // Fixed width for tablet mode
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.8,
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 32, 24, 16),
          child: _buildContent(context),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return const SizedBox.shrink();
  }
}
