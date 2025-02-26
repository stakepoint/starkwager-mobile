part of '../../feature.dart';

class AccountSettingsTabletMode extends ConsumerWidget
    implements PreferredSizeWidget {
  const AccountSettingsTabletMode({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.only(left: 120, right: 80),
      child: SingleChildScrollView(
        child: Column(
          children: [
            verticalSpace(32),
            // Row to include Back Arrow and Title
            Row(
              children: [
                IconButton(
                  onPressed: () => GoRouter.of(context).pop(), // Navigate back
                  icon: SvgPicture.asset(AppIcons.arrowBack),
                ),
                horizontalSpace(20),
                Expanded(
                  child: TabletHeader(
                    title: 'accountSettings'.tr().toUpperCaseString,
                    onProfileTap: () =>
                        GoRouter.of(context).go(Routes.profileSetup),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(120);
}
