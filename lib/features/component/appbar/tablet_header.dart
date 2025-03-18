part of '../../feature.dart';

class TabletHeader extends StatelessWidget {
  final String title;
  final VoidCallback? onProfileTap;
  final double horizontalSpaceHeader;

  const TabletHeader(
      {super.key,
      required this.title,
      this.onProfileTap,
      this.horizontalSpaceHeader = 0});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: AppTheme.of(context).headLineLarge32),
        horizontalSpace(horizontalSpaceHeader),
        Row(
          children: [
            GestureDetector(
              onTap: onProfileTap,
              child: const ProfileMenu(),
            ),
            horizontalSpace(24),
            GestureDetector(
              onTap: () {
                _showNotificationDialog(context);
              },
              child: SvgPicture.asset(AppIcons.notificationIcon,
                  width: 20,
                  height: 20,
                  colorFilter: ColorFilter.mode(
                    context.iconColor,
                    BlendMode.srcIn,
                  )),
            ),
          ],
        ),
      ],
    );
  }

  void _showNotificationDialog(BuildContext context) {
    final RenderBox overlay =
        Overlay.of(context).context.findRenderObject() as RenderBox;
    final size = overlay.size;

    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: '',
      transitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (context, anim1, anim2) {
        return Stack(
          children: [
            Positioned(
              top: 20,
              right: 20,
              child: Material(
                color: Colors.transparent,
                child: Container(
                  width: size.width * (context.isPortrait ? 0.6 : 0.4),
                  height: size.height * 0.9,
                  decoration: BoxDecoration(
                    color: context.primaryBackgroundColor,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: IconButton(
                              icon: SvgPicture.asset(AppIcons.close),
                              onPressed: () => Navigator.pop(context),
                            ),
                          ),
                        ],
                      ),
                      verticalSpace(10),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          'notification'.tr().toUpperCase(),
                          style: AppTheme.of(context).headLineLarge32,
                        ),
                      ),
                      Expanded(
                        child: ListView(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          children: notifications
                              .map((notification) => notification)
                              .toList(),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
