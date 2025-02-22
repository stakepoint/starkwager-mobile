import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:starkwager/core/constants/assets.dart';
import 'package:starkwager/extensions/build_context_extension.dart';
import 'package:starkwager/features/notification/widgets/notification_card.dart';
import 'package:starkwager/theme/app_theme.dart';
import 'package:starkwager/utils/ui_widgets.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  final notifications = [
    NotificationCard(
      title: 'Man U vs Arsenal',
      time: '3d',
      subTitle: 'lost this wagger',
      name: 'you',
      iconPath: AppIcons.closeRed,
    ),
    NotificationCard(
      title: "Will Bitcoin Hit 100k Before January 31, 2025?",
      time: '3d',
      subTitle: 'won this wagger',
      name: 'you',
      iconPath: AppIcons.tick,
    ),
    NotificationCard(
      title: "Will Bitcoin Hit 100k Before January 31, 2025?",
      time: '3d',
      subTitle: 'sent proof',
      name: '@noyi24_7',
      iconPath: AppIcons.camera,
    ),
    NotificationCard(
      title: "Will Bitcoin Hit 100k Before January 31, 2025?",
      time: '3d',
      subTitle: 'disagreed and requested for proof',
      name: '@babykeem',
      iconPath: AppIcons.camera,
    ),
    NotificationCard(
      title: "Will Bitcoin Hit 100k Before January 31, 2025?",
      time: '3d',
      subTitle: 'accepted your wagger',
      name: '@babykeem',
      iconPath: AppIcons.handshakeIcon,
    ),
    NotificationCard(
      title: "Will Bitcoin Hit 100k Before January 31, 2025?",
      time: '3d',
      subTitle: 'Waiting for your opponent',
      name: '',
      iconPath: AppIcons.handshakeIcon,
    ),
    NotificationCard(
      title: "Deposit successful",
      time: '3d',
      subTitle: 'has been added to your wallet',
      name: '10 Strk',
      iconPath: AppIcons.boxStack,
    )
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        scrolledUnderElevation: 0.0,
        backgroundColor: context.primaryBackgroundColor,
        leading: IconButton(
          onPressed: () => GoRouter.of(context).pop(),
          icon: SvgPicture.asset(AppIcons.arrowBack),
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
