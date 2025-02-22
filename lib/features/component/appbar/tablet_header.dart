part of '../../feature.dart';

class TabletHeader extends StatelessWidget {
  final String title;
  final VoidCallback? onProfileTap;
  final double horizontalSpaceHeader;
  const TabletHeader({
    super.key,
    required this.title,
    this.onProfileTap,
    this.horizontalSpaceHeader=0
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: AppTheme.of(context).headLineLarge32),
        horizontalSpace(horizontalSpaceHeader),
        Row(
          children: [
            GestureDetector(
              onTap: onProfileTap,
              child: const ProfileMenu(),
            ),
            horizontalSpace(24),
            SvgPicture.asset(
              AppIcons.notificationIcon,
              width: 20,
              height: 20,
            ),
          ],
        ),
      ],
    );
  }
}
