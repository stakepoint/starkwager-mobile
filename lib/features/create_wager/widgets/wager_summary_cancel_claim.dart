import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:starkwager/extensions/build_context_extension.dart';
import 'package:starkwager/features/feature.dart';
import 'package:starkwager/theme/app_theme.dart';

class WagerSummaryCancelClaim extends StatelessWidget {
  const WagerSummaryCancelClaim({super.key});

  void _showCancelClaimDialog(BuildContext context) {
    if (context.isMobile) {
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        isDismissible: true,
        enableDrag: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        builder: (context) => Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: CancelClaimDialog(
            onCancel: () {
              Navigator.pop(context);
            },
            onClose: () {
              Navigator.pop(context);
            },
          ),
        ),
      );
    } else {
      showDialog(
        context: context,
        builder: (context) => Dialog(
          backgroundColor: context.isDarkMode
              ? context.dialogDarkBackground
              : context.containerColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Container(
            width: 400,
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.8,
            ),
            child: CancelClaimDialog(
              onCancel: () {
                Navigator.pop(context);
              },
              onClose: () {
                Navigator.pop(context);
              },
            ),
          ),
        ),
      );
    }
  }

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
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              children: [
                TextSpan(
                  text: 'youClaimedThisWagerWin'.tr(),
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
                    text: ' 58 mins ',
                    style: AppTheme.of(context).textSmallMedium,
                  ),
                TextSpan(
                  text: 'toAcceptOrDisagreeWithIt'.tr(),
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
              buttonText: 'cancelClaim'.tr(),
              height: 56,
              isActive: true,
              onPressed: () => _showCancelClaimDialog(context),
            ),
          if (context.isTablet && context.isPortrait)
            PrimaryButton(
              buttonTextStyle: AppTheme.of(context).textMediumMedium.copyWith(
                    color: context.primaryBackgroundColor,
                  ),
              buttonColor: context.primaryTextColor,
              buttonText: 'cancelClaim'.tr(),
              height: 56,
              width: 176,
              isActive: true,
              onPressed: () => _showCancelClaimDialog(context),
            ),
          if (context.isTablet && context.isLandscape)
            PrimaryButton(
              buttonTextStyle: AppTheme.of(context).textMediumMedium.copyWith(
                    color: context.primaryBackgroundColor,
                  ),
              width: 176,
              buttonColor: context.primaryTextColor,
              buttonText: 'cancelClaim'.tr(),
              height: 56,
              isActive: true,
              onPressed: () => _showCancelClaimDialog(context),
            ),
        ],
      ),
    );
  }
}
