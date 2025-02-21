import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:starkwager/core/constants/app_values.dart';
import 'package:starkwager/extensions/build_context_extension.dart';
import 'package:starkwager/theme/app_colors.dart';
import 'package:starkwager/theme/app_theme.dart';
import 'package:starkwager/utils/ui_widgets.dart';

class AvatarDialog extends StatelessWidget {
  final Function(String) onIconSelected;
  AvatarDialog({super.key, required this.onIconSelected});

  final ValueNotifier<String?> selectedImage = ValueNotifier(null);

  setImage(String v) {
    selectedImage.value = v;
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: context.isMobile ? const EdgeInsets.symmetric(horizontal: 20, vertical: 24) : const EdgeInsets.symmetric(horizontal: 140, vertical: 80),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Container(
        width: !context.isMobile ? 550 : 320,
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Spacer(),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Change Avatar',
                      style: TextStyle(
                        fontSize: !context.isMobile ? 18 : 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    verticalSpace(AppValues.height8),
                    Text(
                      'selectANewAvatar'.tr(),
                      style: AppTheme.of(context).bodyExtraLarge18,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
                Spacer(),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.of(context).pop(),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
              ],
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
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  if (selectedImage.value != null) {
                    onIconSelected(selectedImage.value!);
                    Navigator.pop(context);
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.buttonColor,
                  foregroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(vertical: 24),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: Text(
                  'choose'.tr(),
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
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
          // color: colors[index % colors.length].withOpacity(0.2),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: isSelected ? AppColors.buttonColor : AppColors.grayCool200, width: 4),
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
  showDialog(
    context: context,
    builder: (context) => AvatarDialog(
      onIconSelected: onIconSelected,
    ),
  );
}

///this extension get the avatar name by the index and can be used globally
extension AvatarExt on int {
  String get getImage => 'assets/avatar/avatar${this + 1}.png';
}
