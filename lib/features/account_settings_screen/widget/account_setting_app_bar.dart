part of '../../feature.dart';

class AccountSettingsAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const AccountSettingsAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 80,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.pop(context),
          ),
          Text("ACCOUNT SETTINGS",
              style: AppTheme.of(context).titleExtraLarge24),
        ],
      ),
      automaticallyImplyLeading: false,
      backgroundColor: context.primaryBackgroundColor,
      foregroundColor: context.primaryBackgroundColor,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(80);
}
