part of '../feature.dart';

class ProfileSettingScreen extends ConsumerWidget {
  const ProfileSettingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: context.primaryBackgroundColor,
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
                          ProfileSettingMobileMode(),
                          Spacer(),
                        ],
                      ),
                    ),
                  )
                : ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: maxWidthTablet),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 45),
                      child: ProfileSettingTabletMode(),
                    ),
                  );
          },
        ),
      ),
    );
  }
}
