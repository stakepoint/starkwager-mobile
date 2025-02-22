import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:starkwager/extensions/build_context_extension.dart';
import 'package:starkwager/features/feature.dart';
import 'package:starkwager/routing/routes.dart';
import 'package:starkwager/theme/app_colors.dart';
import 'package:starkwager/theme/app_theme.dart';

class WagerSummaryDisagreeAndAgree extends StatelessWidget {
  const WagerSummaryDisagreeAndAgree({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 120,
          width: MediaQuery.sizeOf(context).width,
          decoration: BoxDecoration(color: AppColors.white, boxShadow: []),
        ),
        if (context.isMobile)
          Positioned(
            bottom: 32,
            right: 16,
            left: 205,
            child: PrimaryButton(
              buttonText: 'Agree'.tr(),
              height: 56,
              isActive: true,
              onPressed: () {
                GoRouter.of(context).push(Routes.wagerCreated);
              },
            ),
          ),
        if (context.isMobile)
          Positioned(
            bottom: 32,
            right: 205,
            left: 16,
            child: PrimaryButton(
              buttonTextStyle: AppTheme.of(context).textMediumMedium.copyWith(
                    color: context.primaryBackgroundColor,
                  ),
              buttonColor: context.primaryTextColor,
              buttonText: 'Disagree'.tr(),
              height: 56,
              isActive: true,
              onPressed: () {},
            ),
          ),
        if (context.isTablet == context.isPortrait)
          Positioned(
            bottom: 32,
            right: 16,
            left: 420,
            child: PrimaryButton(
              buttonText: 'Agree'.tr(),
              height: 56,
              isActive: true,
              onPressed: () {
                GoRouter.of(context).push(Routes.wagerCreated);
              },
            ),
          ),
        if (context.isTablet == context.isPortrait)
          Positioned(
            bottom: 32,
            right: 420,
            left: 16,
            child: PrimaryButton(
              buttonTextStyle: AppTheme.of(context).textMediumMedium.copyWith(
                    color: context.primaryBackgroundColor,
                  ),
              buttonColor: context.primaryTextColor,
              buttonText: 'Disagree'.tr(),
              height: 56,
              isActive: true,
              onPressed: () {},
            ),
          ),
        if (context.isTablet == context.isLandscape)
          Positioned(
            bottom: 32,
            right: 350,
            left: 610,
            child: PrimaryButton(
              buttonText: 'Agree'.tr(),
              height: 56,
              isActive: true,
              onPressed: () {
                GoRouter.of(context).push(Routes.wagerCreated);
              },
            ),
          ),
        if (context.isTablet == context.isLandscape)
          Positioned(
            bottom: 32,
            right: 610,
            left: 350,
            child: PrimaryButton(
              buttonTextStyle: AppTheme.of(context).textMediumMedium.copyWith(
                    color: context.primaryBackgroundColor,
                  ),
              buttonColor: context.primaryTextColor,
              buttonText: 'Disagree'.tr(),
              height: 56,
              isActive: true,
              onPressed: () {},
            ),
          ),
      ],
    );
  }
}
