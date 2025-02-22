import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:starkwager/extensions/build_context_extension.dart';
import 'package:starkwager/features/feature.dart';
import 'package:starkwager/routing/routes.dart';
import 'package:starkwager/theme/app_colors.dart';
import 'package:starkwager/theme/app_theme.dart';

class WagerSummaryDisagreeAndAgree extends StatelessWidget {
  const WagerSummaryDisagreeAndAgree({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      width: MediaQuery.sizeOf(context).width,
      decoration: BoxDecoration(color: AppColors.white),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (context.isMobile)
            SizedBox(
              width: 200,
              child: Padding(
                padding: const EdgeInsets.only(left: 16, right: 4),
                child: PrimaryButton(
                  buttonTextStyle:
                      AppTheme.of(context).textMediumMedium.copyWith(
                            color: context.primaryBackgroundColor,
                          ),
                  buttonColor: context.primaryTextColor,
                  buttonText: 'disagree'.tr(),
                  height: 56,
                  isActive: true,
                  onPressed: () {},
                ),
              ),
            ),
          if (context.isMobile)
            SizedBox(
              width: 200,
              child: Padding(
                padding: const EdgeInsets.only(right: 16, left: 4),
                child: PrimaryButton(
                  buttonText: 'agree'.tr(),
                  height: 56,
                  isActive: true,
                  onPressed: () {
                    GoRouter.of(context).push(Routes.wagerCreated);
                  },
                ),
              ),
            ),
          if (context.isTablet == context.isPortrait)
            Expanded(
              child: Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 120, right: 4),
                  child: PrimaryButton(
                    buttonTextStyle:
                        AppTheme.of(context).textMediumMedium.copyWith(
                              color: context.primaryBackgroundColor,
                            ),
                    buttonColor: context.primaryTextColor,
                    buttonText: 'disagree'.tr(),
                    height: 56,
                    isActive: true,
                    onPressed: () {},
                  ),
                ),
              ),
            ),
          if (context.isTablet == context.isPortrait)
            Expanded(
              child: Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.only(right: 120, left: 4),
                  child: PrimaryButton(
                    buttonText: 'agree'.tr(),
                    height: 56,
                    isActive: true,
                    onPressed: () {
                      GoRouter.of(context).push(Routes.wagerCreated);
                    },
                  ),
                ),
              ),
            ),
          if (context.isTablet == context.isLandscape)
            Expanded(
              child: Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 350, right: 4),
                  child: PrimaryButton(
                    buttonTextStyle:
                        AppTheme.of(context).textMediumMedium.copyWith(
                              color: context.primaryBackgroundColor,
                            ),
                    buttonColor: context.primaryTextColor,
                    buttonText: 'disagree'.tr(),
                    height: 56,
                    isActive: true,
                    onPressed: () {},
                  ),
                ),
              ),
            ),
          if (context.isTablet == context.isLandscape)
            Expanded(
              child: Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.only(right: 350, left: 4),
                  child: PrimaryButton(
                    buttonText: 'agree'.tr(),
                    height: 56,
                    isActive: true,
                    onPressed: () {
                      GoRouter.of(context).push(Routes.wagerCreated);
                    },
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
