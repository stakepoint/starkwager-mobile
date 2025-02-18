part of '../../feature.dart';

Widget NewWagerButton(BuildContext context) {
    return GestureDetector(
      onTap: () {
        GoRouter.of(context).push(Routes.createWager);
      },
      child: Container(
        height: 56,
        width: 160,
        decoration: BoxDecoration(
          color: context.primaryButtonColor,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.2),
              blurRadius: 8,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(AppIcons.handshakeIcon),
            SizedBox(width: 12),
            Text('newWager'.tr(), style: AppTheme.of(context).textMediumMedium),
          ],
        ),
      ),
    );
  }