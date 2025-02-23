part of '../../feature.dart';

class ProfileSettingMobileMode extends ConsumerStatefulWidget {
  const ProfileSettingMobileMode({
    super.key,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ProfileSettingMobileModeState();
}

class _ProfileSettingMobileModeState
    extends ConsumerState<ProfileSettingMobileMode> {
  File? _selectedImage;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        padding: EdgeInsets.zero,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('profile'.tr(), style: AppTheme.of(context).headLineLarge32),
            verticalSpace(12),
            Padding(
              padding: const EdgeInsets.only(left: AppValues.padding8),
              child: GestureDetector(
                onTap: () async {
                  final ImagePicker picker = ImagePicker();
                  final XFile? image =
                      await picker.pickImage(source: ImageSource.gallery);
                  if (image != null) {
                    setState(() {
                      _selectedImage = File(image.path);
                    });
                  }
                },
                child: Stack(
                  children: [
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: _selectedImage != null
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image.file(
                                _selectedImage!,
                                fit: BoxFit.cover,
                              ),
                            )
                          : ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image.asset(
                                AppIcons.userImage,
                                fit: BoxFit.cover,
                              ),
                            ),
                    ),
                    Positioned(
                      right: -4,
                      bottom: -4,
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.1),
                              blurRadius: 4,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: const Icon(Icons.camera_alt,
                            color: Colors.black, size: 20),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            verticalSpace(12),
            CopyItemContainer(value: '@noyi24_7'),
            Container(
              height: 1,
              color: context.dividerColor,
              margin: const EdgeInsets.symmetric(vertical: AppValues.height24),
            ),
            ProfileSettingBody(),
          ],
        ));
  }
}
