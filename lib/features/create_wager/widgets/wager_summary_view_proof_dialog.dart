// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/material.dart';
// import 'package:starkwager/features/feature.dart';
// import 'package:starkwager/theme/app_theme.dart';
part of '../../feature.dart';

class WagerSummaryViewProofDialog extends StatefulWidget {
  const WagerSummaryViewProofDialog({super.key});

  @override
  State<WagerSummaryViewProofDialog> createState() =>
      _WagerSummaryViewProofDialogState();
}

class _WagerSummaryViewProofDialogState
    extends State<WagerSummaryViewProofDialog> {
  String get _dialogText => 'thinkCoinIsOnTrack'.tr();

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
      backgroundColor: AppColors.grayNeutral800,
      builder: (context) => _buildBottomSheetContent(),
    );
    _handleResponse(response);
  }

  Future<void> _showDialog(BuildContext context) async {
    final response = await showDialog(
      context: context,
      builder: (context) => _buildDialogContent(),
    );
    _handleResponse(response);
  }

  void _handleResponse(dynamic response) {
    if (response == null && context.mounted) {
      Navigator.of(context).pop();
    }
  }

  Widget _buildDialogContent() {
    return Dialog(
      backgroundColor: context.containerColor,
      insetPadding: const EdgeInsets.symmetric(horizontal: 24),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minWidth: 420,
          maxWidth: 420,
        ),
        child: ClipRect(
          child: StatefulBuilder(
            builder: (BuildContext context, StateSetter setModalState) {
              return _buildContent(setModalState);
            },
          ),
        ),
      ),
    );
  }

  Widget _buildContent(StateSetter setModalState) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            verticalSpace(AppValues.height15),
            _buildHeader(),
            verticalSpace(AppValues.height15),
            _buildImage(),
            verticalSpace(AppValues.height20),
            _buildDescription(),
            verticalSpace(AppValues.height20),
            _buildActionButton(setModalState),
            verticalSpace(AppValues.height32),
          ],
        ),
      ),
    );
  }

  Widget _buildDescription() {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      decoration: BoxDecoration(
        color: context.textBoxTextColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(
        _dialogText,
        textAlign: TextAlign.start,
        style: AppTheme.of(context).bodyLarge16.copyWith(
              color: context.subTitleTextColor,
              fontWeight: FontWeight.w500,
            ),
      ),
    );
  }

  void _showFullScreenImage(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: EdgeInsets.zero,
        child: Stack(
          children: [
            Align(
              alignment: Alignment.center,
              child: GestureDetector(
                onTap: () => Navigator.of(context).pop(),
                child: InteractiveViewer(
                  panEnabled: true,
                  minScale: 0.5,
                  maxScale: 3.0,
                  child: Image.asset(
                    AppIcons.proofImage,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.topRight,
              child: IconButton(
                icon: SvgPicture.asset(
                  AppIcons.close,
                  colorFilter: ColorFilter.mode(
                    Colors.white,
                    BlendMode.srcIn,
                  ),
                ),
                onPressed: () => Navigator.pop(context),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImage() {
    return GestureDetector(
      onTap: () => _showFullScreenImage(context),
      child: Hero(
        tag: 'proofImage',
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Container(
            height: 235,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
            ),
            child: CustomPaint(
              foregroundPainter: BorderPainter(
                color: context.primaryBackgroundColor,
                dashSpace: 7,
                borderRadius: 16,
              ),
              child: Image.asset(
                AppIcons.proofImage,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildActionButton(StateSetter setModalState) {
    return Flex(
      spacing: 15,
      direction: Axis.horizontal,
      children: [
        Flexible(
          child: PrimaryButton(
            buttonColor: context.secondaryTextColor,
            buttonText: 'disagree'.tr(),
            buttonTextStyle: AppTheme.of(context).textMediumMedium.copyWith(
                  color: AppColors.grayCool900,
                ),
            onPressed: () {},
            isActive: true,
          ),
        ),
        Flexible(
          child: PrimaryButton(
            buttonText: 'agree'.tr(),
            onPressed: () {},
            isActive: true,
          ),
        ),
      ],
    );
  }

  Widget _buildBottomSheetContent() {
    return StatefulBuilder(
      builder: (BuildContext context, StateSetter setModalState) {
        return Container(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          decoration: BoxDecoration(
            color: context.containerColor,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
          ),
          child: _buildContent(setModalState),
        );
      },
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Expanded(child: SizedBox()),
        Text('viewProof'.tr(),
            textAlign: TextAlign.center,
            style: AppTheme.of(context).titleExtraLarge24),
        Expanded(
          child: Align(
            alignment: Alignment.centerRight,
            child: IconButton(
              icon: SvgPicture.asset(
                AppIcons.close,
                colorFilter: ColorFilter.mode(
                  Colors.white,
                  BlendMode.srcIn,
                ),
              ),
              onPressed: () => Navigator.pop(context),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return const SizedBox.shrink();
  }
}
