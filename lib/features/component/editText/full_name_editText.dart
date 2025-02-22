part of '../../feature.dart';

class FullNameEditText extends StatelessWidget {
  const FullNameEditText({
    super.key,
    required this.controller,
    required this.onValueChanged,
  });

  final TextEditingController controller;
  final Function(String) onValueChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppValues.padding16),
      decoration: BoxDecoration(
        color: context.textBoxTextColor,
        borderRadius: BorderRadius.circular(AppValues.radius16),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller,
              onChanged: onValueChanged,
              style: AppTheme.of(context)
                  .bodyExtraLarge18
                  .copyWith(fontWeight: FontWeight.w500),
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Full name',
                hintStyle: AppTheme.of(context)
                    .bodyExtraLarge18
                    .copyWith(color: context.textHintColor),
                contentPadding: EdgeInsets.zero,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
