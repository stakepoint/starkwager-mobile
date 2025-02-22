import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:starkwager/extensions/build_context_extension.dart';
import 'package:starkwager/features/feature.dart';
import 'package:starkwager/theme/app_colors.dart';
import 'package:starkwager/theme/app_theme.dart';

class WagerSummaryViewProof extends StatelessWidget {
  const WagerSummaryViewProof({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 154,
      width: MediaQuery.sizeOf(context).width,
      decoration: BoxDecoration(color: AppColors.white),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 32),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('@babykeem', style: AppTheme.of(context).textSmallMedium),
              Text(' sent proof.'.tr(),
                  style: AppTheme.of(context).bodyMedium14),
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
              buttonText: 'View Proof'.tr(),
              height: 56,
              isActive: true,
              onPressed: () {},
            ),
          if (context.isTablet && context.isPortrait)
            PrimaryButton(
              buttonTextStyle: AppTheme.of(context).textMediumMedium.copyWith(
                    color: context.primaryBackgroundColor,
                  ),
              width: 176,
              buttonColor: context.primaryTextColor,
              buttonText: 'View Proof'.tr(),
              height: 56,
              isActive: true,
              onPressed: () {},
            ),
          if (context.isTablet && context.isLandscape)
            PrimaryButton(
              buttonTextStyle: AppTheme.of(context).textMediumMedium.copyWith(
                    color: context.primaryBackgroundColor,
                  ),
              width: 176,
              buttonColor: context.primaryTextColor,
              buttonText: 'View Proof'.tr(),
              height: 56,
              isActive: true,
              onPressed: () {},
            ),
        ],
      ),
    );
  }
}
