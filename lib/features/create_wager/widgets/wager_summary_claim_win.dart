import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:starkwager/extensions/build_context_extension.dart';
import 'package:starkwager/features/feature.dart';
import 'package:starkwager/routing/routes.dart';

class WagerSummaryClaimWin extends StatelessWidget {
  const WagerSummaryClaimWin({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      width: MediaQuery.sizeOf(context).width,
      decoration: BoxDecoration(color: context.primaryBackgroundColor),
      child: Center(
        child: PrimaryButton(
          buttonText: 'claimWin'.tr(),
          height: 56,
          width: 343,
          isActive: true,
          onPressed: () {
            GoRouter.of(context).push(Routes.wagerCreated);
          },
        ),
      ),
    );
  }
}
