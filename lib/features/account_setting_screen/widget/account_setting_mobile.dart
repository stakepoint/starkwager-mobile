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
      title: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          horizontalSpace(6),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 33), // Instead of verticalSpace(33)

              GestureDetector(
                  onTap: () {
                     if (context.isMobile) {
                              GoRouter.of(context).go(Routes.home);
                            } else {
                              GoRouter.of(context).go(Routes.homeTablet);
                            }
                  }, // Navigate back
                  child: SvgPicture.asset(AppIcons.arrowBack)),

              const SizedBox(height: 24),
              Text(
                'accountSettings'.tr().toUpperCaseString,
               style: AppTheme.of(context).headLineLarge32,
                textAlign: TextAlign.left,
              ),
              const SizedBox(height: 24),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(150);
}
