part of '../../feature.dart';

class HomeScreenBody extends ConsumerWidget {
  const HomeScreenBody({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return _HomeScreenBodyContent();
  }
}

class _HomeScreenBodyContent extends ConsumerStatefulWidget {
  @override
  ConsumerState<_HomeScreenBodyContent> createState() => _HomeScreenBodyContentState();
}

class _HomeScreenBodyContentState extends ConsumerState<_HomeScreenBodyContent> {
  int _selectedIndex = 0;

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

  Widget _buildCategoryTab(String title, String icon, int index) {
    final bool isSelected = _selectedIndex == index;

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedIndex = index;
        });
      },
      child: Container(
        margin: const EdgeInsets.only(right: 12),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
        decoration: BoxDecoration(
          color: isSelected
              ? const Color.fromRGBO(16, 42, 86, 1)
              : const Color.fromRGBO(239, 241, 245, 1),
          borderRadius: BorderRadius.circular(16),
        ),
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: isSelected
                ? [
                    SvgPicture.asset(
                      icon,
                      width: 18,
                      height: 18,
                      colorFilter: ColorFilter.mode(
                        Colors.white,
                        BlendMode.srcIn,
                      ),
                    ),
                    horizontalSpace(8),
                    Text(
                      title,
                      style: AppTheme.of(context).textSmallMedium.copyWith(
                            fontSize: 14,
                            color: Colors.white,
                          ),
                    ),
                  ]
                : [
                    Text(
                      title,
                      style: AppTheme.of(context).textSmallMedium.copyWith(
                            fontSize: 14,
                            color: const Color.fromRGBO(16, 42, 86, 1),
                          ),
                    ),
                    horizontalSpace(8),
                    SvgPicture.asset(
                      icon,
                      width: 18,
                      height: 18,
                      colorFilter: ColorFilter.mode(
                        const Color.fromRGBO(16, 42, 86, 1),
                        BlendMode.srcIn,
                      ),
                    ),
                  ],
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryTabs() {
    return Container(
      color: context.primaryBackgroundColor,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.only(left: 2, right: 2, top: 16, bottom: 8),
        child: Row(
          children: [
            _buildCategoryTab('Trending', AppIcons.trendingIcon, 0),
            _buildCategoryTab('Sports', AppIcons.sportsIcon, 1),
            _buildCategoryTab('Entertainment', AppIcons.entertainmentIcon, 2),
            _buildCategoryTab('Politics', AppIcons.politicsIcon, 3),
            _buildCategoryTab('Crypto', AppIcons.cryptoIcon, 4),
            _buildCategoryTab('Stocks', AppIcons.stocksIcon, 5),
            _buildCategoryTab('ESports', AppIcons.esportsIcon, 6),
            _buildCategoryTab('Games', AppIcons.gamesIcon, 7),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool isMobile = context.isMobile;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
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
        verticalSpace(24),
        _buildCategoryTabs(),
        verticalSpace(24),
        context.isMobile ? _mobileNoWager(context) : _tabletNoWager(context),
      ],
    );
  }

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
}
