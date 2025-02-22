part of '../../feature.dart';

class AccountSettingsTabletMode extends ConsumerWidget
    implements PreferredSizeWidget {
  const AccountSettingsTabletMode({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    double leftSpace = getResponsiveWidth(context, 80);
    double spaceBetween = getResponsiveWidth(context, 250);
    double iconSpace = getResponsiveWidth(context, 20);
    double tabSize = getResponsiveWidth(context, 1400);

    return SingleChildScrollView(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        verticalSpace(32),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            horizontalSpace(leftSpace),
            IconButton(
              onPressed: () => GoRouter.of(context).pop(),
              icon: SvgPicture.asset(AppIcons.arrowBack),
            ),
            horizontalSpace(iconSpace),
            SizedBox(
              height: 64,
              width: tabSize,
              child: TabletHeader(
                title: 'accountSettings'.tr(),
                onProfileTap: () =>
                    GoRouter.of(context).go(Routes.profileSetup),
                horizontalSpaceHeader: spaceBetween,
              ),
            ),
          ],
        ),
        verticalSpace(80),
      ],
    ));
  }

  @override
  Size get preferredSize => const Size.fromHeight(120);
}

double getResponsiveWidth(BuildContext context, double originalWidth,
    {double referenceScreenWidth = 1800}) {
  double screenWidth = MediaQuery.of(context).size.width;

  // Maintain the ratio of original width to reference screen width
  double scaledWidth = (originalWidth / referenceScreenWidth) * screenWidth;

  // Large screens: Maintain full proportion
  scaledWidth = (originalWidth / referenceScreenWidth) * screenWidth;

  return scaledWidth;
}
