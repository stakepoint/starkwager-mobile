import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:starkwager/core/constants/app_values.dart';
import 'package:starkwager/core/constants/assets.dart';
import 'package:starkwager/extensions/build_context_extension.dart';
import 'package:starkwager/theme/app_theme.dart';
import 'package:starkwager/utils/ui_widgets.dart';

import '../feature.dart';

class AvatarDialog extends StatelessWidget {
  final Function(String) onIconSelected;
  final bool isBottomSheet;

  AvatarDialog({super.key, required this.onIconSelected, this.isBottomSheet = false});

  final ValueNotifier<String?> selectedImage = ValueNotifier(null);

  setImage(String v) {
    selectedImage.value = v;
  }

  @override
  Widget build(BuildContext context) {
    final content = Container(
      margin: context.isMobile ? const EdgeInsets.symmetric(horizontal: 16) : null,
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
              Text('Change Avatar', textAlign: TextAlign.center, style: AppTheme.of(context).titleExtraLarge24),
              Expanded(
                child: Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                    icon: SvgPicture.asset(AppIcons.close),
                    onPressed: () => Navigator.pop(context),
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
              style: AppTheme.of(context).bodyLarge16.copyWith(color: context.subTitleTextColor),
            ),
          ),
          verticalSpace(AppValues.height40),
          ValueListenableBuilder(
            valueListenable: selectedImage,
            builder: (context, image, _) => GridView.builder(
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
                return AvatarItem(
                  index: index,
                  onTap: setImage,
                  isSelected: image == index.getImage,
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
                  if (selectedImage.value != null) {
                    onIconSelected(selectedImage.value!);
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
      insetPadding: context.isMobile ? const EdgeInsets.symmetric(horizontal: 20, vertical: 24) : const EdgeInsets.symmetric(horizontal: 140, vertical: 80),
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

  const AvatarItem({super.key, required this.index, this.isSelected = false, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final colors = [Colors.red, Colors.blue, Colors.green, Colors.orange, Colors.purple, Colors.teal, Colors.amber, Colors.indigo];

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => onTap('assets/avatar/avatar${index + 1}.png'),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: isSelected ? context.primaryButtonColor : context.avatarBgColor, width: 4),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Image.asset(
            index.getImage,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Center(
                child: Icon(
                  Icons.person,
                  color: colors[index % colors.length],
                  size: 32,
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

void showAvatarDialog(BuildContext context, {required Function(String) onIconSelected}) {
  context.isMobile
      ? showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          backgroundColor: Colors.transparent,
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

extension AvatarExt on int {
  String get getImage => 'assets/avatar/avatar${this + 1}.png';
}
