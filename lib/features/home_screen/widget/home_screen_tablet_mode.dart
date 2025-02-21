part of '../../feature.dart';

class HomeScreenTabletMode extends ConsumerWidget {
  const HomeScreenTabletMode({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 45),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          verticalSpace(32),
          TabletHeader(
            title: 'home'.tr(),
            onProfileTap: () => GoRouter.of(context).go(Routes.profileSetup),
          ),
          verticalSpace(80),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: context.isLandscape ? 120 : 60
              ),
              child: HomeScreenBody(),
            ),
          ),
        ],
      ),
    );
  }
}
