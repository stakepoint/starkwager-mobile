part of '../../feature.dart';

class HomeScreenBody extends ConsumerWidget {
  const HomeScreenBody({
    super.key,
  });

  void _showFundWalletDialog(BuildContext context) {
    if (context.isMobile) {
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (BuildContext context) => FundWalletDialog(),
      );
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) => FundWalletDialog(),
      );
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
        final bool isMobile = context.isMobile;

    return Column(
      children: [
        ContractAddress(isTablet: !isMobile),
        verticalSpace(8),
        StarkAmount(
          isTablet: !context.isMobile,
          onAddMoney: () => _showFundWalletDialog(context),
          onWithdraw: () {},
        ),
        verticalSpace(16),
        context.isMobile ? HomeAddAndWithdraw() : SizedBox(),
        verticalSpace(40),
        context.isMobile ? _mobileNoWager(context) : _tabletNoWager(context),
      ],
    );
  }

//----------------------------------------------- MOBILE_NO_WAGER ----------------------------------------------- //

  Widget _mobileNoWager(BuildContext context) {
    return Container(
      height: 81,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        color: context.containerColor,
      ),
      child: Row(
        spacing: 16,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          horizontalSpace(16),
          SvgPicture.asset(AppIcons.noWagerIcon),
          Text(
            'noWagersCreatedYet'.tr(),
            style: AppTheme.of(context).bodyLarge16.copyWith(
                  color: context.textHintColor,
                ),
          ),
        ],
      ),
    );
  }

  //----------------------------------------------- MOBILE_NO_WAGER ----------------------------------------------- //

  Widget _tabletNoWager(BuildContext context) {
    return Container(
      height: 175,
      width: 696,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        color: context.containerColor,
      ),
      child: Column(
        spacing: 24,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(AppIcons.noWagerIcon, width: 88, height: 88),
          Text(
            'noWagersCreatedYet'.tr(),
            style: AppTheme.of(context).textMediumNormal.copyWith(
                  color: context.textHintColor,
                ),
          ),
        ],
      ),
    );
  }

//----------------------------------------------- WALLET_ADDRESS ----------------------------------------------- //

}
