import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:starkwager/extensions/build_context_extension.dart';
import 'package:starkwager/features/feature.dart';
import 'package:starkwager/theme/app_theme.dart';

class WagerSummaryViewProof extends ConsumerWidget {
  const WagerSummaryViewProof({super.key});

  void _showCancelClaimDialog(BuildContext context) {
    if (context.isMobile) {
      // Show bottom sheet on mobile devices
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        isDismissible: true,
        enableDrag: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        builder: (context) => Padding(
          padding: const EdgeInsets.only(bottom: 48),
          child: CancelClaimDialog(
            onCancel: () {
              // Handle cancel action
            },
            onClose: () {
              // Handle close action
            },
          ),
        ),
      );
    } else {
      // Show dialog on tablet devices
      showDialog(
        context: context,
        builder: (context) => Dialog(
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
            child: CancelClaimDialog(
              onCancel: () {
                // Handle cancel action
              },
              onClose: () {
                // Handle close action
              },
            ),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      height: 154,
      width: MediaQuery.sizeOf(context).width,
      decoration: BoxDecoration(color: context.primaryBackgroundColor),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 32),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('@babykeem', style: AppTheme.of(context).textSmallMedium),
              Text('sentProof.'.tr(), style: AppTheme.of(context).bodyMedium14),
            ],
          ),
          SizedBox(height: 16),
          if (context.isMobile)
            PrimaryButton(
              buttonTextStyle: AppTheme.of(context).textMediumMedium.copyWith(
                    color: context.primaryBackgroundColor,
                  ),
              width: 119,
              buttonColor: context.primaryTextColor,
              buttonText: 'viewProof'.tr(),
              height: 56,
              isActive: true,
              onPressed: () => _showCancelClaimDialog(context),
            ),
          if (context.isTablet && context.isPortrait)
            PrimaryButton(
              buttonTextStyle: AppTheme.of(context).textMediumMedium.copyWith(
                    color: context.primaryBackgroundColor,
                  ),
              width: 176,
              buttonColor: context.primaryTextColor,
              buttonText: 'viewProof'.tr(),
              height: 56,
              isActive: true,
              onPressed: () => _showCancelClaimDialog(context),
            ),
          if (context.isTablet && context.isLandscape)
            PrimaryButton(
              buttonTextStyle: AppTheme.of(context).textMediumMedium.copyWith(
                    color: context.primaryBackgroundColor,
                  ),
              width: 176,
              buttonColor: context.primaryTextColor,
              buttonText: 'viewProof'.tr(),
              height: 56,
              isActive: true,
              onPressed: () => _showCancelClaimDialog(context),
            ),
        ],
      ),
    );
  }
}
