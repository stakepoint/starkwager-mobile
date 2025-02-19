part of '../../feature.dart';

class MobileHeader extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const MobileHeader({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: AppBar(
        automaticallyImplyLeading: false,
        scrolledUnderElevation: 0.0,
        backgroundColor: context.primaryBackgroundColor,
        elevation: 0,
        titleSpacing: 0,
        title: Padding(
          padding: const EdgeInsets.only(left: 16, top: 30),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(title, style: AppTheme.of(context).headLineLarge32),
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
