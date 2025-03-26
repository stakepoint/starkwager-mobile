part of '../../feature.dart';

class ProfileSettingBody extends ConsumerStatefulWidget {
  const ProfileSettingBody({super.key});

  @override
  ConsumerState<ProfileSettingBody> createState() => _ProfileSettingBodyState();
}

class _ProfileSettingBodyState extends ConsumerState<ProfileSettingBody> {
  bool themeDropdownVisible = false;

  @override
  Widget build(BuildContext context) {
    final currentThemeAsync = ref.watch(appThemeModeProvider);

    return Column(
      children: [
        GestureDetector(
          onTap: () {
            if (context.isMobile) {
              GoRouter.of(context).go(Routes.accountSettings);
            } else {
              GoRouter.of(context).go(Routes.accountSettingsTablet);
            }
          },
          child: Container(
            height: !context.isMobile ? 81 : null,
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: context.containerColor,
            ),
            child: Row(
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
                horizontalSpace(16),
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
        ),
        verticalSpace(16),
        context.isMobile
            ? _buildMobileThemeSection(context, currentThemeAsync)
            : _buildTabletThemeSection(context, currentThemeAsync)
      ],
    );
  }

  Widget _buildMobileThemeSection(
      BuildContext context, AsyncValue<ThemeMode> currentThemeAsync) {
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          backgroundColor: Colors.transparent,
          builder: (context) => ThemeSelectionBottomSheet(),
        );
      },
      child: Container(
        height: !context.isMobile ? 81 : null,
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: context.containerColor,
        ),
        child: Row(
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
            horizontalSpace(16),
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
                      : 'changethemeOfApp...'.tr().replaceAll('\n', ''),
                  style: AppTheme.of(context).bodySmall12.copyWith(
                      color: context.subTitleTextColor,
                      fontWeight: FontWeight.w400),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabletThemeSection(
      BuildContext context, AsyncValue<ThemeMode> currentThemeAsync) {
    return Column(
      children: [
        verticalSpace(24),
        verticalDivider(height: 1, color: context.dividerColor),
        verticalSpace(32),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'theme'.tr(),
              style: AppTheme.of(context).textMediumMedium.copyWith(
                    color: context.primaryTextColor,
                  ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      themeDropdownVisible = !themeDropdownVisible;
                    });
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
                        currentThemeAsync.when(
                            loading: () => SizedBox(
                                  width: 16,
                                  height: 16,
                                  child:
                                      CircularProgressIndicator(strokeWidth: 2),
                                ),
                            error: (_, __) => Text(
                                  'error'.tr(),
                                  style: AppTheme.of(context)
                                      .textMediumMedium
                                      .copyWith(
                                        color: context.primaryTextColor,
                                      ),
                                ),
                            data: (theme) {
                              String themeName = _getThemeModeName(theme);
                              return Text(
                                themeName.tr(),
                                style: AppTheme.of(context)
                                    .textMediumMedium
                                    .copyWith(
                                      color: context.primaryTextColor,
                                    ),
                              );
                            }),
                        horizontalSpace(12),
                        SvgPicture.asset(themeDropdownVisible
                            ? AppIcons.checked
                            : AppIcons.downWardArrowIos),
                      ],
                    ),
                  ),
                ),
                if (themeDropdownVisible)
                  Container(
                    width: 172,
                    margin: EdgeInsets.only(top: 8),
                    decoration: BoxDecoration(
                      color: context.primaryBackgroundColor,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: context.shadowColor,
                          blurRadius: 10,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _buildThemeOption(
                          context,
                          'system',
                          isSelected:
                              currentThemeAsync.valueOrNull == ThemeMode.system,
                          onTap: () async {
                            await ref
                                .read(appThemeModeProvider.notifier)
                                .updateMode(ThemeMode.system);
                            setState(() {
                              themeDropdownVisible = false;
                            });
                          },
                        ),
                        _buildOptionDivider(context),
                        _buildThemeOption(
                          context,
                          'dark',
                          isSelected:
                              currentThemeAsync.valueOrNull == ThemeMode.dark,
                          onTap: () async {
                            await ref
                                .read(appThemeModeProvider.notifier)
                                .updateMode(ThemeMode.dark);
                            setState(() {
                              themeDropdownVisible = false;
                            });
                          },
                        ),
                        _buildOptionDivider(context),
                        _buildThemeOption(
                          context,
                          'light',
                          isSelected:
                              currentThemeAsync.valueOrNull == ThemeMode.light,
                          onTap: () async {
                            await ref
                                .read(appThemeModeProvider.notifier)
                                .updateMode(ThemeMode.light);
                            setState(() {
                              themeDropdownVisible = false;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildThemeOption(BuildContext context, String themeName,
      {bool isSelected = false, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              themeName.tr(),
              style: AppTheme.of(context).textSmallMedium.copyWith(
                    color: context.primaryTextColor,
                  ),
            ),
            if (isSelected)
              SvgPicture.asset(
                AppIcons.checked,
                width: 16,
                height: 16,
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildOptionDivider(BuildContext context) {
    return Container(
      height: 1,
      color: context.dividerColor,
    );
  }

  String _getThemeModeName(ThemeMode mode) {
    switch (mode) {
      case ThemeMode.system:
        return 'system';
      case ThemeMode.light:
        return 'light';
      case ThemeMode.dark:
        return 'dark';
    }
  }
}