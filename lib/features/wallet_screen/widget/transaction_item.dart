part of '../../feature.dart';

class TransactionItem extends StatelessWidget {
  final String description;
  final String date;
  final String amount;
  final Color? iconBgColor;
  final bool isWithdrawal;
  final bool showGreenAmount;

  const TransactionItem({
    super.key,
    required this.description,
    required this.date,
    required this.amount,
    this.iconBgColor,
    required this.isWithdrawal,
    this.showGreenAmount = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: context.containerColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: iconBgColor,
              borderRadius: BorderRadius.circular(16),
            ),
            child: SvgPicture.asset(
              isWithdrawal ? AppIcons.upwardArrow : AppIcons.downwardArrow,
              colorFilter: ColorFilter.mode(
                isWithdrawal ? context.iconColor : AppColors.success500,
                BlendMode.srcIn,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  description,
                  style: AppTheme.of(context)
                      .bodyExtraLarge18
                      .copyWith(fontWeight: FontWeight.w500),
                  overflow: TextOverflow.ellipsis,
                ),
                Text(date, style: AppTheme.of(context).bodyMedium14),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Row(
            children: [
              Container(
                width: 16,
                height: 16,
                margin: const EdgeInsets.only(right: 4),
                child: Image.asset(AppIcons.starknetImage),
              ),
              const SizedBox(width: 4),
              Text(
                amount,
                style: AppTheme.of(context).bodyLarge16.copyWith(
                    color: showGreenAmount ? context.successColor : null,
                    fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
