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
        child: context.isMobile
            ? ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: AppValues.width600,
                ),
                child: HomeScreenBody(),
              )
            : HomeScreenTabletMenuBar(
                child: Center(
                  child: SizedBox(
                    width: AppValues.width1440,
                    child: HomeScreenTabletMode(),
                  ),
                ),
              ),
      ),
    );
  }
}
