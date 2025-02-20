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
    final balanceText = Text(
      '\$1000.00',
      style: AppTheme.of(context).headingMobileH1,
    );
    
    final amountRow = Row(
      children: [
        Image.asset(
          AppIcons.starknetImage,
          width: 20,
          height: 20,
        ),
        horizontalSpace(4),
        Text(
          '50 Strk',
          style: AppTheme.of(context).textSmallMedium,
        ),
      ],
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        balanceText,
        verticalSpace(4),
        amountRow,
      ],
    );
  }
}
