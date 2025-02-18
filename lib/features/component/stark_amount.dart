part of '../feature.dart';

class StarkAmount extends StatelessWidget {
  final bool isTablet;
  final VoidCallback? onAddMoney;
  final VoidCallback? onWithdraw;

  const StarkAmount({
    super.key,
    this.isTablet = false,
    this.onAddMoney,
    this.onWithdraw,
  });

  @override
  Widget build(BuildContext context) {
    final balanceText =
        Text('\$500.00', style: AppTheme.of(context).headingMobileH1);
    final amountRow = Row(
      children: [
        Image.asset(AppIcons.starknetImage),
        horizontalSpace(4),
        Text('25 Strk', style: AppTheme.of(context).textSmallMedium),
      ],
    );

    if (isTablet) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              balanceText,
              amountRow,
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 30),
            child: Row(
              children: [
                HomeActionButton(
                  text: 'addMoney'.tr(),
                  iconPath: AppIcons.addIcon,
                  onTap: onAddMoney,
                ),
                const SizedBox(width: 16),
                HomeActionButton(
                  text: 'withdraw'.tr(),
                  iconPath: AppIcons.withdrawIcon,
                  onTap: onWithdraw,
                ),
              ],
            ),
          )
        ],
      );
    } else {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          balanceText,
          amountRow,
        ],
      );
    }
  }
}
