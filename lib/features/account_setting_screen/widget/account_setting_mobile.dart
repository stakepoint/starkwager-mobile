part of '../../feature.dart';

class AccountSettingsMobileMode extends StatelessWidget
    implements PreferredSizeWidget {
  const AccountSettingsMobileMode({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 150,
      title: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            verticalSpace(33),
            IconButton(
                onPressed: () => GoRouter.of(context).pop(),
                icon: SvgPicture.asset(AppIcons.arrowBack),
              ),
            verticalSpace(24),
            Text('accountSettings'.tr(),
                style: AppTheme.of(context).titleExtraLarge24),
            verticalSpace(24),
          ],
        ),
      ),
      automaticallyImplyLeading: false,
      backgroundColor: context.primaryBackgroundColor,
      foregroundColor: context.primaryBackgroundColor,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(150);
}
