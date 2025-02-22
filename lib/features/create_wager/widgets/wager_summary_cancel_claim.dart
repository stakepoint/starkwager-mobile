import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:starkwager/extensions/build_context_extension.dart';
import 'package:starkwager/features/feature.dart';
import 'package:starkwager/theme/app_colors.dart';
import 'package:starkwager/theme/app_theme.dart';

class WagerSummaryCancelClaim extends StatelessWidget {
  const WagerSummaryCancelClaim({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 172,
      width: MediaQuery.sizeOf(context).width,
      decoration: BoxDecoration(color: AppColors.white, boxShadow: []),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 32),
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              children: [
                TextSpan(
                  text: 'You claimed this wager win, your opponent has'.tr(),
                  style: AppTheme.of(context).bodyMedium14,
                ),
                if (context.isMobile)
                  TextSpan(
                    text: ' 23 hrs 58\n',
                    style: AppTheme.of(context).textSmallMedium,
                  ),
                if (context.isMobile)
                  TextSpan(
                    text: 'mins',
                    style: AppTheme.of(context).textSmallMedium,
                  ),
                if (context.isTablet)
                  TextSpan(
                    text: ' 23 hrs\n',
                    style: AppTheme.of(context).textSmallMedium,
                  ),
                if (context.isTablet)
                  TextSpan(
                    text: ' 58 mins',
                    style: AppTheme.of(context).textSmallMedium,
                  ),
                TextSpan(
                  text: ' to accept or disagree with it.'.tr(),
                  style: AppTheme.of(context).bodyMedium14,
                ),
              ],
            ),
          ),
          SizedBox(height: 16),
          if (context.isMobile)
            PrimaryButton(
              buttonTextStyle: AppTheme.of(context).textMediumMedium.copyWith(
                    color: context.primaryBackgroundColor,
                  ),
              width: 140,
              buttonColor: context.primaryTextColor,
              buttonText: 'Cancel Claim'.tr(),
              height: 56,
              isActive: true,
              onPressed: () {},
            ),
          if (context.isTablet && context.isPortrait)
            PrimaryButton(
              buttonTextStyle: AppTheme.of(context).textMediumMedium.copyWith(
                    color: context.primaryBackgroundColor,
                  ),
              buttonColor: context.primaryTextColor,
              buttonText: 'Cancel Claim'.tr(),
              height: 56,
              width: 176,
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
              buttonText: 'Cancel Claim'.tr(),
              height: 56,
              isActive: true,
              onPressed: () {},
            ),
        ],
      ),
    );
  }
}
