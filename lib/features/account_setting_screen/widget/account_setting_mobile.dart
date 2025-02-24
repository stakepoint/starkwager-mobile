part of '../../feature.dart';

class AccountSettingsMobileMode extends StatelessWidget
    implements PreferredSizeWidget {
  const AccountSettingsMobileMode({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 150,
      automaticallyImplyLeading: false,
      backgroundColor: context.primaryBackgroundColor,
      foregroundColor: context.primaryBackgroundColor,
      title: Padding(
        padding:
            const EdgeInsets.symmetric(horizontal: 16.0), // Consistent spacing
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 33), // Instead of verticalSpace(33)
            Row(
              children: [
                IconButton(
                  onPressed: () => GoRouter.of(context).pop(),
                  icon: SvgPicture.asset(AppIcons.arrowBack),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Text(
              'accountSettings'.tr(),
              style: AppTheme.of(context).titleExtraLarge24,
              textAlign: TextAlign.left,
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(150);
}
