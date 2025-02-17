part of '../../feature.dart';

class RecentTransactions extends StatelessWidget {
  final bool isTablet;
  const RecentTransactions({Key? key, this.isTablet = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double titleSpacing = isTablet ? 24.0 : 16.0;
    final double itemSpacing = 8.0;

    Widget content = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'recentTransactions'.tr(),
          style: AppTheme.of(context).bodyLarge16,
        ),
        SizedBox(height: titleSpacing),
        TransactionItem(
          description:
              'Created Wager: Will Bitcoin Hit \$100k Before January 31, 2025?',
          date: 'November 24, 2024',
          amount: '5 Strk',
          iconBgColor: AppColors.grayCool100,
          isWithdrawal: true,
        ),
        SizedBox(height: itemSpacing),
        TransactionItem(
          description:
              'Created Wager: Will Bitcoin Hit \$100k Before January 31, 2025?',
          date: 'November 24, 2024',
          amount: '5 Strk',
          iconBgColor: AppColors.grayCool100,
          isWithdrawal: true,
        ),
        SizedBox(height: itemSpacing),
        TransactionItem(
          description:
              'Created Wager: Will Bitcoin Hit \$100k Before January 31, 2025?',
          date: 'November 24, 2024',
          amount: '5 Strk',
          iconBgColor: AppColors.grayCool100,
          isWithdrawal: false,
          showGreenAmount: true,
        ),
      ],
    );

    return isTablet ? Container(width: 696, child: content) : content;
  }
}

