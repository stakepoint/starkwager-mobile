part of '../feature.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        scrolledUnderElevation: 0.0,
        backgroundColor: context.primaryBackgroundColor,
        leading: IconButton(
          onPressed: () => GoRouter.of(context).pop(),
          icon: SvgPicture.asset(AppIcons.arrowBack,
              colorFilter: ColorFilter.mode(
                context.iconColor,
                BlendMode.srcIn,
              )),
        ),
      ),
      body: Container(
        margin: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'notification'.tr().toUpperCase(),
              style: AppTheme.of(context).headLineLarge32,
            ),
            verticalSpace(20),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: notifications
                      .map((notification) => notification)
                      .toList(),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
