part of '../feature.dart';

class WagersScreen extends ConsumerWidget {
  const WagersScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;
    return Scaffold(
      backgroundColor: context.primaryBackgroundColor,
      floatingActionButton: ScreenLayout.isTablet(context)
          ? isPortrait
              ? newWagerButton(context)
              : SizedBox()
          : newWagerButton(context),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return context.isMobile
                ? _buildMobileLayout()
                : _buildTabletLayout(context);
          },
        ),
      ),
    );
  }

//----------------------------------------------- MOBILE_VIEW ----------------------------------------------- //

  Widget _buildMobileLayout() {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: AppValues.width600),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppValues.padding16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Expanded(
              child: MobileBody(),
            ),
          ],
        ),
      ),
    );
  }

//----------------------------------------------- TABLET_VIEW ----------------------------------------------- //

  Widget _buildTabletLayout(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: AppValues.width1440),
      child: Padding(
        padding: const EdgeInsets.only(left: 32, right: 80),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: MobileBody(),
            ),
          ],
        ),
      ),
    );
  }
}
