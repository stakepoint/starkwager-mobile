part of '../../feature.dart';

class ProfileSettingBody extends ConsumerWidget {
  const ProfileSettingBody({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () {
        if (context.isMobile) {
          GoRouter.of(context).push(Routes.accountSettings);
        } else {
          GoRouter.of(context).push(Routes.accountSettingsTablet);
        }
      },
      child: Column(
        children: [
          Container(
            height: !context.isMobile ? 81 : null,
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: context.containerColor,
            ),
            child: Row(
              spacing: 16,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                    height: 48,
                    width: 48,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: context.textBoxTextColor),
                    child: SvgPicture.asset(AppIcons.profileIcon2,
                        height: 24,
                        width: 24,
                        colorFilter: ColorFilter.mode(
                          context.iconColor,
                          BlendMode.srcIn,
                        ))),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('accountSettings'.tr(),
                        style: AppTheme.of(context).bodyLarge16.copyWith(
                            color: context.primaryTextColor,
                            fontWeight: FontWeight.w500)),
                    Text(
                      context.isMobile
                          ? 'changeYourProfilepictureUsername...'.tr()
                          : 'changeYourProfilepictureUsername...'
                              .tr()
                              .replaceAll('\n', ''),
                      style: AppTheme.of(context).bodySmall12.copyWith(
                          color: context.subTitleTextColor,
                          fontWeight: FontWeight.w400),
                    )
                  ],
                ),
                Spacer(),
                GestureDetector(
                  onTap: () {
                    if (context.isMobile) {
                      GoRouter.of(context).push(Routes.accountSettings);
                    } else {
                      GoRouter.of(context).push(Routes.accountSettingsTablet);
                    }
                  },
                  child: SvgPicture.asset(AppIcons.nextArrow,
                      height: 16,
                      width: 16,
                      colorFilter: ColorFilter.mode(
                        context.iconColor,
                        BlendMode.srcIn,
                      )),
                ),
              ],
            ),
          ),
          verticalSpace(16),
          context.isMobile
              ? GestureDetector(
                  onTap: () {
                    _showThemeBottomSheet(context);
                  },
                  child: Container(
                    height: !context.isMobile ? 81 : null,
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: context.containerColor,
                    ),
                    child: Row(
                      spacing: 16,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                            height: 48,
                            width: 48,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: context.textBoxTextColor,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: SvgPicture.asset(AppIcons.sunlight,
                                height: 24,
                                width: 24,
                                colorFilter: ColorFilter.mode(
                                  context.iconColor,
                                  BlendMode.srcIn,
                                ))),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'theme'.tr(),
                              style: AppTheme.of(context).bodyLarge16.copyWith(
                                  color: context.primaryTextColor,
                                  fontWeight: FontWeight.w500),
                            ),
                            Text(
                              context.isMobile
                                  ? 'changethemeOfApp...'.tr()
                                  : 'changethemeOfApp...'
                                      .tr()
                                      .replaceAll('\n', ''),
                              style: AppTheme.of(context).bodySmall12.copyWith(
                                  color: context.subTitleTextColor,
                                  fontWeight: FontWeight.w400),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                )
              : Column(
                  children: [
                    verticalSpace(24),
                    verticalDivider(height: 1, color: context.dividerColor),
                    verticalSpace(32),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'theme'.tr(),
                          style: AppTheme.of(context).textMediumMedium.copyWith(
                                color: context.primaryTextColor,
                              ),
                        ),
                        GestureDetector(
                          onTap: () {
                            _showThemeBottomSheet(context);
                          },
                          child: Container(
                            height: 56,
                            width: 172,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              color: context.textBoxTextColor,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'system'.tr(),
                                  style: AppTheme.of(context)
                                      .textMediumMedium
                                      .copyWith(
                                        color: context.primaryTextColor,
                                      ),
                                ),
                                horizontalSpace(12),
                                SvgPicture.asset(AppIcons.downWardArrowIos)
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                )
        ],
      ),
    );
  }

  void _showThemeBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => ThemeSelectionBottomSheet(),
    );
  }

  void _showThemeDiologue(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        child: ThemeSelectionBottomSheet(),
      ),
    );
  }
}
