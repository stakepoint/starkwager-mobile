// ignore_for_file: use_build_context_synchronously

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:starkwager/core/constants/assets.dart';
import 'package:starkwager/core/providers/app_theme_mode_provider.dart';
import 'package:starkwager/extensions/build_context_extension.dart';
import 'package:starkwager/theme/app_theme.dart';
import 'package:starkwager/utils/ui_widgets.dart';

class ThemeSelectionBottomSheet extends ConsumerWidget {
  const ThemeSelectionBottomSheet({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentThemeAsync = ref.watch(appThemeModeProvider);

    return currentThemeAsync.when(
        loading: () => Container(
              decoration: BoxDecoration(
                color: context.primaryBackgroundColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Center(child: CircularProgressIndicator()),
            ),
        error: (_, __) => Container(
              decoration: BoxDecoration(
                color: context.primaryBackgroundColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Center(child: Text('Error loading theme')),
            ),
        data: (currentTheme) {
          bool isSystemSelected = currentTheme == ThemeMode.system;
          bool isDarkSelected = currentTheme == ThemeMode.dark;
          bool isLightSelected = currentTheme == ThemeMode.light;

          return Container(
            decoration: BoxDecoration(
              color: context.primaryBackgroundColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            padding: EdgeInsets.only(top: 24, bottom: 24),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Spacer(),
                        Text(
                          'selectTheme'.tr(),
                          style:
                              AppTheme.of(context).titleExtraLarge24.copyWith(
                                    color: context.primaryTextColor,
                                  ),
                        ),
                        Spacer(),
                        GestureDetector(
                            onTap: () => Navigator.pop(context),
                            child: SvgPicture.asset(AppIcons.close)),
                      ],
                    ),
                  ),
                  verticalSpace(40),
                  _buildThemeOption(
                    context,
                    'system',
                    isSelected: isSystemSelected,
                    onTap: () async {
                      await ref
                          .read(appThemeModeProvider.notifier)
                          .updateMode(ThemeMode.system);
                      context.pop(context);
                    },
                  ),
                  _buildDivider(context),
                  _buildThemeOption(
                    context,
                    'dark',
                    isSelected: isDarkSelected,
                    onTap: () async {
                      await ref
                          .read(appThemeModeProvider.notifier)
                          .updateMode(ThemeMode.dark);
                      context.pop(context);
                    },
                  ),
                  _buildDivider(context),
                  _buildThemeOption(
                    context,
                    'light',
                    isSelected: isLightSelected,
                    onTap: () async {
                      await ref
                          .read(appThemeModeProvider.notifier)
                          .updateMode(ThemeMode.light);
                      context.pop(context);
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  Widget _buildThemeOption(BuildContext context, String themeName,
      {bool isSelected = false, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              themeName.tr(),
              style: AppTheme.of(context).textSmallMedium.copyWith(
                    color: context.primaryTextColor,
                  ),
            ),
            if (isSelected) ...[
              horizontalSpace(8),
              SvgPicture.asset(
                AppIcons.checked,
                width: 16,
                height: 16,
              )
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildDivider(BuildContext context) {
    return Container(
      height: 1,
      margin: EdgeInsets.symmetric(horizontal: 24),
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Flex(
            direction: Axis.horizontal,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(
              (constraints.maxWidth / 20).ceil(),
              (index) => SizedBox(
                width: 8,
                height: 1,
                child: DecoratedBox(
                  decoration: BoxDecoration(color: context.dividerColor),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
