import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:starkwager/core/constants/assets.dart';
import 'package:starkwager/extensions/build_context_extension.dart';
import 'package:starkwager/theme/app_colors.dart';
import 'package:starkwager/theme/app_theme.dart';
import 'package:starkwager/utils/ui_widgets.dart';

class WagerSummarySendProof extends StatelessWidget {
  const WagerSummarySendProof({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 172,
          width: MediaQuery.sizeOf(context).width,
          decoration: BoxDecoration(color: AppColors.white),
        ),
        if (context.isMobile)
          Positioned(
            left: 16,
            right: 16,
            top: 32,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Text('@babykeem',
                        style: AppTheme.of(context).textSmallMedium),
                    Text(' disagreed and requested for proof'.tr(),
                        style: AppTheme.of(context).bodyMedium14),
                  ],
                ),
              ],
            ),
          ),
        if (context.isMobile)
          Positioned(
            bottom: 32,
            right: 109,
            left: 109,
            child: Container(
              height: 56,
              decoration: BoxDecoration(
                color: context.primaryButtonColor,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(AppIcons.sendProofPath),
                  horizontalSpace(14),
                  Text('Send Proof'.tr(),
                      style: AppTheme.of(context).textMediumMedium),
                ],
              ),
            ),
          ),
        if (context.isTablet)
          Positioned(
            left: 16,
            right: 16,
            top: 32,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Text('@babykeem',
                        style: AppTheme.of(context).textSmallMedium),
                    Text(' disagreed and requested for proof'.tr(),
                        style: AppTheme.of(context).bodyMedium14),
                  ],
                ),
              ],
            ),
          ),
        if (context.isTablet == context.isPortrait)
          Positioned(
            bottom: 32,
            right: 330,
            left: 330,
            child: Container(
              height: 56,
              decoration: BoxDecoration(
                color: context.primaryButtonColor,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(AppIcons.sendProofPath),
                  horizontalSpace(14),
                  Text('Send Proof'.tr(),
                      style: AppTheme.of(context).textMediumMedium),
                ],
              ),
            ),
          ),
        if (context.isTablet == context.isLandscape)
          Positioned(
            bottom: 32,
            right: 500,
            left: 500,
            child: Container(
              height: 56,
              decoration: BoxDecoration(
                color: context.primaryButtonColor,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(AppIcons.sendProofPath),
                  horizontalSpace(14),
                  Text('Send Proof'.tr(),
                      style: AppTheme.of(context).textMediumMedium),
                ],
              ),
            ),
          ),
      ],
    );
  }
}
