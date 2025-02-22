part of '../feature.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: context.primaryBackgroundColor,
      floatingActionButton: context.isMobile || context.isPortrait
          ? newWagerButton(context)
          : SizedBox(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final double maxWidth = AppValues.width600;
            final double maxWidthTablet = AppValues.width1440;
            return context.isMobile
                ? NestedScrollView(
                    headerSliverBuilder: (context, innerBoxIsScrolled) => [
                      SliverAppBar(
                        floating: true,
                        pinned: false,
                        snap: false,
                        elevation: 0,
                        toolbarHeight: 80,
                        backgroundColor: context.primaryBackgroundColor,
                        automaticallyImplyLeading: false,
                        title: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ProfileMenu(),
                              SvgPicture.asset(AppIcons.notificationIcon),
                            ],
                          ),
                        ),
                      ),
                    ],
                    body: ConstrainedBox(
                      constraints: BoxConstraints(maxWidth: maxWidth),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: AppValues.padding16),
                        child: HomeScreenBody(),
                      ),
                    ),
                  )
                : ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: maxWidthTablet),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 45),
                      child: HomeScreenTabletMode(),
                    ),
                  );
          },
        ),
      ),
    );
  }
}
