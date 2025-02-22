part of '../../feature.dart';

class HomeScreenTabletMode extends ConsumerWidget {
  const HomeScreenTabletMode({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLandscape = context.isLandscape;

    return NestedScrollView(
      headerSliverBuilder: (context, innerBoxIsScrolled) => [
        SliverToBoxAdapter(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              verticalSpace(32),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: isLandscape ? 0 : 60
                ),
                child: TabletHeader(
                  title: 'home'.tr(),
                  onProfileTap: () => GoRouter.of(context).go(Routes.profileSetup),
                ),
              ),
              verticalSpace(isLandscape ? 40 : 80),
            ],
          ),
        ),
      ],
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: isLandscape ? 200 : 60
        ),
        child: HomeScreenBody(),
      ),
    );
  }
}
