import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:starkwager/extensions/build_context_extension.dart';
import 'package:starkwager/features/feature.dart';
import 'package:starkwager/theme/app_colors.dart';
import 'package:starkwager/theme/app_theme.dart';

class WagerSummaryViewProof extends StatelessWidget {
  const WagerSummaryViewProof({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 154,
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
                    Text(' sent proof.'.tr(),
                        style: AppTheme.of(context).bodyMedium14),
                  ],
                ),
              ],
            ),
          ),
        if (context.isMobile)
          Positioned(
            bottom: 32,
            right: 128,
            left: 128,
            child: PrimaryButton(
              buttonTextStyle: AppTheme.of(context).textMediumMedium.copyWith(
                    color: context.primaryBackgroundColor,
                  ),
              buttonColor: context.primaryTextColor,
              buttonText: 'View Proof'.tr(),
              height: 56,
              isActive: true,
              onPressed: () {},
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
                    Text(' sent proof.'.tr(),
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
            child: PrimaryButton(
              buttonTextStyle: AppTheme.of(context).textMediumMedium.copyWith(
                    color: context.primaryBackgroundColor,
                  ),
              buttonColor: context.primaryTextColor,
              buttonText: 'View Proof'.tr(),
              height: 56,
              isActive: true,
              onPressed: () {},
            ),
          ),
        if (context.isTablet == context.isLandscape)
          Positioned(
            bottom: 32,
            right: 500,
            left: 500,
            child: PrimaryButton(
              buttonTextStyle: AppTheme.of(context).textMediumMedium.copyWith(
                    color: context.primaryBackgroundColor,
                  ),
              buttonColor: context.primaryTextColor,
              buttonText: 'View Proof'.tr(),
              height: 56,
              isActive: true,
              onPressed: () {},
            ),
          ),
      ],
    );
  }
}
