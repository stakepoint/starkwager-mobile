import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:starkwager/core/constants/assets.dart';
import 'package:starkwager/extensions/build_context_extension.dart';
import 'package:starkwager/theme/app_theme.dart';
import 'package:starkwager/utils/ui_widgets.dart';

class WagerSummarySendProof extends StatelessWidget {
  const WagerSummarySendProof({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 172,
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
              Text('disagreedAndRequestedForProof'.tr(),
                  style: AppTheme.of(context).bodyMedium14),
            ],
          ),
          SizedBox(height: 16),
          if (context.isMobile)
            Container(
              height: 56,
              width: 158,
              decoration: BoxDecoration(
                color: context.primaryButtonColor,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(AppIcons.sendProofPath),
                  horizontalSpace(14),
                  Text('sendProof'.tr(),
                      style: AppTheme.of(context).textMediumMedium.copyWith(
                        color: context.buttonTextColor
                      )),
                ],
              ),
            ),
          if (context.isTablet && context.isPortrait)
            Container(
              height: 56,
              width: 176,
              decoration: BoxDecoration(
                color: context.primaryButtonColor,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(AppIcons.sendProofPath),
                  horizontalSpace(14),
                  Text('sendProof'.tr(),
                      style: AppTheme.of(context).textMediumMedium),
                ],
              ),
            ),
          if (context.isTablet && context.isLandscape)
            Container(
              height: 56,
              width: 176,
              decoration: BoxDecoration(
                color: context.primaryButtonColor,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(AppIcons.sendProofPath),
                  horizontalSpace(14),
                  Text('sendProof'.tr(),
                      style: AppTheme.of(context).textMediumMedium),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
