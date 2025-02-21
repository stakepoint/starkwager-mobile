part of '../feature.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: context.isMobile ? HomeScreenAppBar() : null,
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
                ? ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: maxWidth),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: AppValues.padding16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          verticalSpace(48),
                          HomeScreenBody(),
                          Spacer(),
                        ],
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
