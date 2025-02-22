
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:starkwager/extensions/build_context_extension.dart';
import 'package:starkwager/features/feature.dart';
import 'package:starkwager/routing/routes.dart';
import 'package:starkwager/theme/app_colors.dart';

class WagerSummaryClaimWin extends StatelessWidget {
  const WagerSummaryClaimWin({
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
            right: 18,
            left: 18,
            child: PrimaryButton(
              buttonText: 'Claim Win'.tr(),
              height: 56,
              isActive: true,
              onPressed: () {
                GoRouter.of(context).push(Routes.wagerCreated);
              },
            ),
          ),
        if (context.isPortrait)
          Positioned(
            bottom: 32,
            right: 300,
            left: 300,
            child: PrimaryButton(
              buttonText: 'Claim Win'.tr(),
              height: 56,
              isActive: true,
              onPressed: () {
                GoRouter.of(context).push(Routes.wagerCreated);
              },
            ),
          ),
        Positioned(
          bottom: 32,
          right: 460,
          left: 460,
          child: PrimaryButton(
            buttonText: 'Claim Win'.tr(),
            height: 56,
            isActive: true,
            onPressed: () {
              GoRouter.of(context).push(Routes.wagerCreated);
            },
          ),
        ),
      ],
    );
  }
}