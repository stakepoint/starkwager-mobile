part of '../../feature.dart';

class ProfileSettingTabletMode extends ConsumerWidget {
  const ProfileSettingTabletMode({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SingleChildScrollView(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        verticalSpace(32),
        TabletHeader(
          title: 'profile'.tr(),
          onProfileTap: () => GoRouter.of(context).go(Routes.profileSetup),
        ),
        verticalSpace(80),
        verticalSpace(16),
        Padding(
          padding:
              EdgeInsets.symmetric(horizontal: context.isLandscape ? 120 : 60),
          child: ProfileSettingBody(),
        ),
      ],
    ));
  }
}
