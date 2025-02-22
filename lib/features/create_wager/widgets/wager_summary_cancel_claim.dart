import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:starkwager/extensions/build_context_extension.dart';
import 'package:starkwager/features/feature.dart';
import 'package:starkwager/theme/app_colors.dart';
import 'package:starkwager/theme/app_theme.dart';

class WagerSummaryCancelClaim extends StatelessWidget {
  const WagerSummaryCancelClaim({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 172,
          width: MediaQuery.sizeOf(context).width,
          decoration: BoxDecoration(color: AppColors.white, boxShadow: []),
        ),
        if (context.isMobile)
          Positioned(
            left: 16,
            right: 16,
            top: 32,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'You claimed this wager win, your opponent has'
                            .tr(),
                        style: AppTheme.of(context).bodyMedium14,
                      ),
                      TextSpan(
                        text: ' 23 hrs 58\n',
                        style: AppTheme.of(context).textSmallMedium,
                      ),
                      TextSpan(
                        text: 'mins',
                        style: AppTheme.of(context).textSmallMedium,
                      ),
                      TextSpan(
                        text: ' to accept or disagree with it.'.tr(),
                        style: AppTheme.of(context).bodyMedium14,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        if (context.isMobile)
          Positioned(
            bottom: 32,
            right: 118,
            left: 118,
            child: PrimaryButton(
              buttonTextStyle: AppTheme.of(context).textMediumMedium.copyWith(
                    color: context.primaryBackgroundColor,
                  ),
              buttonColor: context.primaryTextColor,
              buttonText: 'Cancel Claim'.tr(),
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
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'You claimed this wager win, your opponent has'
                            .tr(),
                        style: AppTheme.of(context).bodyMedium14,
                      ),
                      TextSpan(
                        text: ' 23 hrs\n',
                        style: AppTheme.of(context).textSmallMedium,
                      ),
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
              buttonText: 'Cancel Claim'.tr(),
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
              buttonText: 'Cancel Claim'.tr(),
              height: 56,
              isActive: true,
              onPressed: () {},
            ),
          ),
      ],
    );
  }
}
