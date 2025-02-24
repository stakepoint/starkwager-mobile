part of '../../feature.dart';

class NotificationCard extends StatelessWidget {
  final String title, name, subTitle, time, iconPath;

  const NotificationCard({
    super.key,
    required this.subTitle,
    required this.name,
    required this.title,
    required this.time,
    required this.iconPath,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.all(12),
          height: 90,
          width: !context.isMobile ? 500 : null,
          decoration: BoxDecoration(
            color: context.containerColor,
            borderRadius: BorderRadius.circular(16),
          ),
          child: buildNotificationIcon(context, title, name, subTitle, time),
        ),
        verticalSpace(20),
      ],
    );
  }

  Row buildNotificationIcon(BuildContext context, String title, String name,
      String subTitle, String time) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.all(12),
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: context.secondaryTextColor,
          ),
          child: SvgPicture.asset(iconPath),
        ),
        horizontalSpace(10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: context.isMobile
                  ? MediaQuery.sizeOf(context).width * 0.68
                  : null,
              child: Text(
                title,
                overflow: TextOverflow.ellipsis,
                style: AppTheme.of(context).textSmallMedium,
              ),
            ),
            verticalSpace(5),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                      text: "$name ",
                      style: AppTheme.of(context).textSmallMedium),
                  TextSpan(
                    text: subTitle,
                    style: AppTheme.of(context).bodySmall12.copyWith(
                          color: context.textHintColor,
                        ),
                  ),
                ],
              ),
            ),
            verticalSpace(5),
            Text(
              time,
              style: AppTheme.of(context).bodySmall12.copyWith(
                    color: context.textHintColor,
                  ),
            ),
          ],
        )
      ],
    );
  }
}
