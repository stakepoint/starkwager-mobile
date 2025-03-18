part of '../../feature.dart';

class RecentTransactions extends StatelessWidget {
  final bool isTablet;
  const RecentTransactions({super.key, this.isTablet = false});

  @override
  Widget build(BuildContext context) {
    final double titleSpacing = isTablet ? 24.0 : 16.0;
    final double itemSpacing = 8.0;

    Widget content = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'recentTransactions'.tr(),
          style: AppTheme.of(context)
              .bodyLarge16
              .copyWith(fontWeight: FontWeight.w500),
        ),
        SizedBox(height: titleSpacing),
        TransactionItem(
          description:
              'Created Wager: Will Bitcoin Hit \$100k Before January 31, 2025?',
          date: 'November 24, 2024',
          amount: '5 Strk',
          iconBgColor: context.secondaryBackgroundColor,
          isWithdrawal: true,
        ),
        SizedBox(height: itemSpacing),
        TransactionItem(
          description:
              'Created Wager: Will Bitcoin Hit \$100k Before January 31, 2025?',
          date: 'November 24, 2024',
          amount: '5 Strk',
          iconBgColor: context.secondaryBackgroundColor,
          isWithdrawal: true,
        ),
        SizedBox(height: itemSpacing),
        TransactionItem(
          description:
              'Created Wager: Will Bitcoin Hit \$100k Before January 31, 2025?',
          date: 'November 24, 2024',
          amount: '5 Strk',
          iconBgColor: context.secondaryBackgroundColor,
          isWithdrawal: false,
          showGreenAmount: true,
        ),
      ],
    );

    return isTablet ? SizedBox(width: 696, child: content) : content;
  }
}
