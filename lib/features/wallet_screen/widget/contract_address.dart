part of '../../feature.dart';

class ContractAddress extends StatelessWidget {
  final bool isTablet;
  const ContractAddress({super.key, this.isTablet = false});

  @override
  Widget build(BuildContext context) {
    final titleStyle = isTablet
        ? AppTheme.of(context).bodyLarge16.copyWith(
              color: context.textHintColor,
            )
        : AppTheme.of(context).bodyMedium14.copyWith(
              color: context.textHintColor,
            );


    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('walletBalance'.tr(), style: titleStyle),
        Container(
          height: 29,
          width: 151,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: context.containerColor,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
    CopyItemContainer(value: '0x400e44000...'), 
  ],
          ),
        ),
      ],
    );
  }
}
