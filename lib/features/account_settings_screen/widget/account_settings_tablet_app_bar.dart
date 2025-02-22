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

    return SingleChildScrollView(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        verticalSpace(32),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () => Navigator.pop(context),
            ),
            TabletHeader(
              title: 'ACCOUNT SETTINGS'.tr(),
              onProfileTap: () => GoRouter.of(context).go(Routes.profileSetup),
              horizontalSpaceHeader: spaceBetween,
            ),
          ],
        ),
        verticalSpace(80),
      ],
    ));
  }

  @override
  Size get preferredSize => const Size.fromHeight(80);
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
