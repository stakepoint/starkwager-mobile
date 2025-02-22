part of '../../feature.dart';

class AccountSettingsMobileMode extends StatelessWidget
    implements PreferredSizeWidget {
  const AccountSettingsMobileMode({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 150,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          verticalSpace(33),
          IconButton(
              onPressed: () => GoRouter.of(context).pop(),
              icon: SvgPicture.asset(AppIcons.arrowBack),
            ),
          verticalSpace(24),
          Text("ACCOUNT SETTINGS".tr(),
              style: AppTheme.of(context).titleExtraLarge24),
          verticalSpace(24),
        ],
      ),
      automaticallyImplyLeading: false,
      backgroundColor: context.primaryBackgroundColor,
      foregroundColor: context.primaryBackgroundColor,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(150);
}
