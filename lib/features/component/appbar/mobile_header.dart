part of '../../feature.dart';

class MobileHeader extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const MobileHeader({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar( 
      automaticallyImplyLeading: false,
      scrolledUnderElevation: 0.0,
      backgroundColor: context.primaryBackgroundColor,
      toolbarHeight: context.isMobile ? null : AppValues.height100,
      elevation: 0,
      title: Padding(padding: EdgeInsets.only(top: 30), child: Text(title, style: AppTheme.of(context).headLineLarge32),) 
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
