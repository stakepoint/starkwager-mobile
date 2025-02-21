part of '../../feature.dart';

class HomeScreenTabletMode extends ConsumerWidget {
  const HomeScreenTabletMode({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLandscape = context.isLandscape;
    
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!isLandscape) ...[
            verticalSpace(32),
            TabletHeader(
              title: 'home'.tr(),
              onProfileTap: () => GoRouter.of(context).go(Routes.profileSetup),
            ),
            verticalSpace(80),
          ],
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: isLandscape ? 120 : 60
            ),
            child: HomeScreenBody(),
          ),
        ],
      ),
    );
  }
}
