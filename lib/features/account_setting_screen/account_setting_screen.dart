part of '../feature.dart';

class AccountSettings extends ConsumerStatefulWidget {
  const AccountSettings({super.key});

  @override
  ConsumerState<AccountSettings> createState() => _AccountSettingsState();
}

class _AccountSettingsState extends ConsumerState<AccountSettings> {
  final _usernameController = TextEditingController();
  final _fullnameController = TextEditingController();
  bool _isUsernameAvailable = false;

  @override
  void dispose() {
    _usernameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: context.isMobile
          ? AccountSettingsMobileMode()
          : AccountSettingsTabletMode(),
      backgroundColor: context.primaryBackgroundColor,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final isLandscape =
                MediaQuery.of(context).orientation == Orientation.landscape;
            final double maxWidth = AppValues.width600;

            return SingleChildScrollView(
              child: Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: context.isMobile
                          ? AppValues.padding24
                          : isLandscape
                              ? 184
                              : 120),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: maxWidth),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        verticalSpace(context.isMobile ? 24 : 120),
                        Padding(
                          padding:
                              const EdgeInsets.only(left: AppValues.padding8),
                          child: GestureDetector(
                            onTap: () {},
                            child: Stack(
                              children: [
                                Container(
                                  width: 80,
                                  height: 80,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: ClipRRect(
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
                                      color: context.tabTextColor,
                                      borderRadius: BorderRadius.circular(16),
                                      boxShadow: [
                                        BoxShadow(
                                          color: context.shadowColor,
                                          blurRadius: 4,
                                          offset: const Offset(0, 2),
                                        ),
                                      ],
                                    ),
                                    child: Icon(Icons.camera_alt,
                                        color: context.error, size: 20),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        verticalSpace(AppValues.height20),
                        CustomEditText(
                          controller: _fullnameController,
                          onValueChanged: (e) {},
                        ),
                        verticalSpace(AppValues.height20),
                        UsernameEditText(
                          controller: _usernameController,
                          onValueChanged: _checkUsername,
                        ),
                        if (_usernameController.text.isNotEmpty)
                          Align(
                            alignment: Alignment.centerRight,
                            child: Padding(
                              padding: const EdgeInsets.only(top: 8, right: 8),
                              child: Text(
                                _isUsernameAvailable
                                    ? 'usernameAvailable'.tr()
                                    : 'usernameUnavailable'.tr(),
                                style:
                                    AppTheme.of(context).bodyLarge16.copyWith(
                                          color: _isUsernameAvailable
                                              ? context.successColor
                                              : context.secondaryWidgetColor,
                                        ),
                              ),
                            ),
                          ),
                        SizedBox(height: context.isMobile ? 270 : 200),
                        PrimaryButton(
                          buttonText: 'Update Changes'.tr(),
                          height: context.isMobile
                              ? AppValues.height56
                              : AppValues.height80,
                          isActive: _usernameController.text.isNotEmpty &&
                              _isUsernameAvailable,
                          onPressed: () {
                            if (context.isMobile) {
                              GoRouter.of(context).go(Routes.home);
                            } else {
                              GoRouter.of(context).go(Routes.homeTablet);
                            }
                          },
                        ),
                        SizedBox(height: context.isMobile ? 32 : 184),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void _checkUsername(String value) {
    setState(() {
      _isUsernameAvailable = value.length > 3;
    });
  }
}
