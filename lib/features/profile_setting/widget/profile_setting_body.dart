part of '../../feature.dart';

class ProfileSettingBody extends ConsumerWidget {
  const ProfileSettingBody({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        Container(
          height: !context.isMobile ? 81 : null,
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: context.containerColor,
          ),
          child: Row(
            spacing: 16,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                  padding: EdgeInsets.all(8),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      // shape: BoxShape.rectangle,
                      color: AppColors.grayCool100),
                  child: SvgPicture.asset(
                    AppIcons.profileIcon2,
                    height: 24,
                    width: 24,
                  )),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'accountSettings'.tr(),
                    style: AppTheme.of(context).bodyLarge16.copyWith(
                        color: context.primaryTextColor,
                        fontWeight: FontWeight.w500),
                  ),
                  Text(
                    context.isMobile
                        ? 'changeYourProfilepictureUsername...'.tr()
                        : 'changeYourProfilepictureUsername...'
                            .tr()
                            .replaceAll('\n', ''),
                    style: AppTheme.of(context).bodySmall12.copyWith(
                        color: context.subTitleTextColor,
                        fontWeight: FontWeight.w400),
                  )
                ],
              ),
              Spacer(),
              SvgPicture.asset(
                AppIcons.nextArrow,
                height: 16,
                width: 16,
              ),
            ],
          ),
        )
      ],
    );
  }
}
