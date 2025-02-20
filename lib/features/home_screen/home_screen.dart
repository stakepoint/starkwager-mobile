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
        child: context.isMobile
            ? ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: AppValues.width600,
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppValues.padding16,
                  ),
                  child: HomeScreenBody(),
                ),
              )
            : HomeScreenTabletMenuBar(
                child: SizedBox(
                  width: AppValues.width1440,
                  child: HomeScreenTabletMode(),
                ),
              ),
      ),
    );
  }
}
