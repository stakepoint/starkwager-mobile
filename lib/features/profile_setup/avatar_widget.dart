import 'package:avatar_plus/avatar_plus.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:starkwager/core/constants/app_values.dart';
import 'package:starkwager/extensions/build_context_extension.dart';
import 'package:starkwager/theme/app_theme.dart';
import 'package:starkwager/utils/ui_widgets.dart';
import 'dart:math';

import '../feature.dart';

// Generate a random string of specified length
String _generateRandomString(int length) {
  const chars =
      'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
  final random = Random();
  return String.fromCharCodes(
    Iterable.generate(
      length,
      (_) => chars.codeUnitAt(random.nextInt(chars.length)),
    ),
  );
}

// List of 15 random strings for avatars
final List<String> avatarStrings = List.generate(
  15,
  (_) => _generateRandomString(10),
);

// Custom avatar widget that displays a colorful circle with initials
class CustomAvatarPlus extends StatelessWidget {
  final String text;
  final double size;
  final Color? backgroundColor;

  const CustomAvatarPlus({
    super.key,
    required this.text,
    this.size = 60,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    // Generate a color based on the text
    final color = backgroundColor ?? _getColorFromText(text);

    // Get the initials (first 2 characters)
    final initials = text.length > 2
        ? text.substring(0, 2).toUpperCase()
        : text.toUpperCase();

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color,
      ),
      child: Center(
        child: AvatarPlus(
          initials,
          trBackground: true,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  // Generate a color based on the text
  Color _getColorFromText(String text) {
    final random =
        Random(text.codeUnits.fold<int>(0, (prev, element) => prev + element));
    return Color.fromARGB(
      255,
      random.nextInt(200) + 55, // Avoid too dark colors
      random.nextInt(200) + 55,
      random.nextInt(200) + 55,
    );
  }
}

class AvatarDialog extends StatelessWidget {
  final Function(String) onIconSelected;
  final bool isBottomSheet;

  AvatarDialog(
      {super.key, required this.onIconSelected, this.isBottomSheet = false});

  final ValueNotifier<String?> selectedAvatarString = ValueNotifier(null);

  setAvatarString(String v) {
    selectedAvatarString.value = v;
  }

  @override
  Widget build(BuildContext context) {
    final content = Container(
      margin:
          context.isMobile ? const EdgeInsets.symmetric(horizontal: 16) : null,
      width: !context.isMobile ? 550 : double.infinity,
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Expanded(child: SizedBox()),
              Text('Change Avatar',
                  textAlign: TextAlign.center,
                  style: AppTheme.of(context).titleExtraLarge24),
              Expanded(
                child: Align(
                  alignment: Alignment.topRight,
                  child: GestureDetector(
                    child: Icon(
                      Icons.close,
                      color: context.primaryTextColor,
                    ),
                    onTap: () => Navigator.pop(context),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Text(
              'selectANewAvatar'.tr(),
              textAlign: TextAlign.center,
              style: AppTheme.of(context)
                  .bodyLarge16
                  .copyWith(color: context.subTitleTextColor),
            ),
          ),
          verticalSpace(AppValues.height40),
          ValueListenableBuilder(
            valueListenable: selectedAvatarString,
            builder: (context, avatarString, _) => GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: !context.isMobile ? 5 : 4,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                childAspectRatio: 1,
              ),
              itemCount: 15,
              itemBuilder: (context, index) {
                final currentAvatarString =
                    avatarStrings[index % avatarStrings.length];
                return AvatarItem(
                  index: index,
                  onTap: setAvatarString,
                  isSelected: avatarString == currentAvatarString,
                );
              },
            ),
          ),
          verticalSpace(AppValues.height24),
          Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: PrimaryButton(
                buttonText: 'choose'.tr(),
                onPressed: () {
                  if (selectedAvatarString.value != null) {
                    onIconSelected(selectedAvatarString.value!);
                    Navigator.pop(context);
                  }
                },
                isActive: true),
          ),
        ],
      ),
    );

    if (isBottomSheet) {
      return Container(
        decoration: BoxDecoration(
          color: context.containerColor,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: SingleChildScrollView(child: content),
      );
    }

    return Dialog(
      backgroundColor: context.containerColor,
      insetPadding: context.isMobile
          ? const EdgeInsets.symmetric(horizontal: 20, vertical: 24)
          : const EdgeInsets.symmetric(horizontal: 140, vertical: 80),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: content,
    );
  }
}

class AvatarItem extends StatelessWidget {
  final int index;
  final bool isSelected;
  final Function(String) onTap;

  const AvatarItem(
      {super.key,
      required this.index,
      this.isSelected = false,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    // Get the avatar string for this index
    final avatarString = avatarStrings[index % avatarStrings.length];

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => onTap(avatarString),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
              color: isSelected
                  ? context.primaryButtonColor
                  : context.avatarBgColor,
              width: 4),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: CustomAvatarPlus(
            text: avatarString,
            size: 60,
          ),
        ),
      ),
    );
  }
}

void showAvatarDialog(BuildContext context,
    {required Function(String) onIconSelected}) {
  context.isMobile
      ? showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          backgroundColor: Colors.black,
          builder: (context) => AvatarDialog(
            onIconSelected: onIconSelected,
            isBottomSheet: true,
          ),
        )
      : showDialog(
          context: context,
          builder: (context) => AvatarDialog(
            onIconSelected: onIconSelected,
          ),
        );
}
