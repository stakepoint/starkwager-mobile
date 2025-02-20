part of '../../feature.dart';

class HomeScreenTabletMode extends ConsumerWidget {
  const HomeScreenTabletMode({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bool isLandscape = context.isLandscape;

    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: isLandscape ? 32 : 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            verticalSpace(32),
            TabletHeader(
              title: 'home'.tr(),
              onProfileTap: () => GoRouter.of(context).go(Routes.profileSetup),
            ),
            verticalSpace(64),
            SizedBox(
              height: MediaQuery.of(context).size.height - 150,
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: isLandscape ? 80 : 40,
                ),
                child: HomeScreenBody(),
              ),
            ),
            verticalSpace(32),
          ],
        ),
      ),
    );
  }
}
