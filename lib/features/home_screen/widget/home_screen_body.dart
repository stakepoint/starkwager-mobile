part of '../../feature.dart';

class HomeScreenBody extends ConsumerWidget {
  const HomeScreenBody({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const _HomeScreenBodyContent();
  }
}

class _HomeScreenBodyContent extends ConsumerStatefulWidget {
  const _HomeScreenBodyContent();

  @override
  ConsumerState<_HomeScreenBodyContent> createState() =>
      _HomeScreenBodyContentState();
}

class _HomeScreenBodyContentState
    extends ConsumerState<_HomeScreenBodyContent> {
  int _selectedIndex = 0;

  void _onTabSelected(int index) {
    if (_selectedIndex != index) {
      setState(() {
        _selectedIndex = index;
        debugPrint('Selected tab: $_selectedIndex');
      });
    }
  }

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
      onTap: () => _onTabSelected(index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: const EdgeInsets.only(right: 16),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected
              ? context.tabSelectedBackgroundColor
              : context.tabUnselectedBackgroundColor,
          borderRadius: BorderRadius.circular(16),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: context.shadowColor,
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  )
                ]
              : null,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (isSelected) ...[
              SvgPicture.asset(
                icon,
                width: 20,
                height: 20,
                colorFilter: ColorFilter.mode(
                  context.tabTextColor,
                  BlendMode.srcIn,
                ),
              ),
              horizontalSpace(8),
              Text(
                title,
                style: AppTheme.of(context).textSmallMedium.copyWith(
                      fontSize: 15,
                      color: context.tabTextColor,
                      height: 1.2,
                    ),
              ),
            ] else ...[
              Text(
                title,
                style: AppTheme.of(context).textSmallMedium.copyWith(
                      fontSize: 15,
                      color: AppColors.tabSelectedColor,
                      height: 1.2,
                    ),
              ),
              horizontalSpace(8),
              SvgPicture.asset(
                icon,
                width: 20,
                height: 20,
                colorFilter: ColorFilter.mode(
                  AppColors.tabSelectedColor,
                  BlendMode.srcIn,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryTabs() {
    return Container(
      color: context.primaryBackgroundColor,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            _buildCategoryTab(
              'trending'.tr(),
              AppIcons.trendingIcon,
              0,
            ),
            _buildCategoryTab(
              'sports'.tr(),
              AppIcons.sportsIcon,
              1,
            ),
            _buildCategoryTab(
              'entertainment'.tr(),
              AppIcons.entertainmentIcon,
              2,
            ),
            _buildCategoryTab(
              'politics'.tr(),
              AppIcons.politicsIcon,
              3,
            ),
            _buildCategoryTab(
              'crypto'.tr(),
              AppIcons.cryptoIcon,
              4,
            ),
            _buildCategoryTab(
              'stocks'.tr(),
              AppIcons.stocksIcon,
              5,
            ),
            _buildCategoryTab(
              'esports'.tr(),
              AppIcons.esportsIcon,
              6,
            ),
            _buildCategoryTab(
              'games'.tr(),
              AppIcons.gamesIcon,
              7,
            ),
          ],
        ),
      ),
    );
  }

  //body

  @override
  Widget build(BuildContext context) {
    final bool isMobile = context.isMobile;

    return CustomScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: isMobile ? AppValues.padding16 : 0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                verticalSpace(24),
                ContractAddress(isTablet: !isMobile),
                verticalSpace(8),
                StarkAmount(
                  isTablet: !context.isMobile,
                  onAddMoney: () => _showFundWalletDialog(context),
                  onWithdraw: () {},
                ),
              ],
            ),
          ),
        ),
        SliverPersistentHeader(
          pinned: true,
          floating: false,
          delegate: _CategoryTabsDelegate(
            builder: (overlapsContent) => Stack(
              children: [
                Container(
                  color: context.primaryBackgroundColor,
                  height: 100.0,
                ),
                _buildCategoryTabs(),
              ],
            ),
            selectedIndex: _selectedIndex,
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.only(top: 24),
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                if (index.isOdd) return verticalSpace(16);
                return Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: isMobile ? AppValues.padding16 : 0,
                  ),
                  child: const WagerWidget(),
                );
              },
              childCount: 20,
            ),
          ),
        ),
      ],
    );
  }
}

class _CategoryTabsDelegate extends SliverPersistentHeaderDelegate {
  final Widget Function(bool) builder;
  final int selectedIndex;

  _CategoryTabsDelegate({
    required this.builder,
    required this.selectedIndex,
  });

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      height: 100.0,
      color: context.primaryBackgroundColor,
      child: Column(
        children: [
          if (shrinkOffset > 0) verticalSpace(8),
          Expanded(child: builder(overlapsContent)),
        ],
      ),
    );
  }

  @override
  double get maxExtent => 100.0;

  @override
  double get minExtent => 100.0;

  @override
  bool shouldRebuild(covariant _CategoryTabsDelegate oldDelegate) {
    return oldDelegate.selectedIndex != selectedIndex;
  }
}
