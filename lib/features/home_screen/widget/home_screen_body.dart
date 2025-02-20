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
    final bool isLandscape = context.isLandscape;

    return CustomScrollView(
      slivers: [
        // Top Padding
        SliverToBoxAdapter(
          child: SizedBox(height: isMobile ? 48 : 32),
        ),
        
        // Collapsible Wallet Section
        SliverToBoxAdapter(
          child: Column(
            children: [
              ContractAddress(isTablet: !isMobile),
              verticalSpace(8),
              StarkAmount(
                isTablet: !isMobile,
                onAddMoney: () => _showFundWalletDialog(context),
                onWithdraw: () {},
              ),
              verticalSpace(isMobile ? 24 : 32),
            ],
          ),
        ),
        
        // Fixed Category Tabs
        SliverPersistentHeader(
          pinned: true,
          delegate: _CategoryTabsDelegate(),
        ),

        // Wagers List
        SliverPadding(
          padding: EdgeInsets.symmetric(
            horizontal: isMobile ? 16 : (isLandscape ? 32 : 16),
            vertical: 16
          ),
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: const WagerWidget(),
                );
              },
              childCount: 3, // Show 3 wagers for now
            ),
          ),
        ),
        
        // Bottom Padding for FAB
        SliverToBoxAdapter(
          child: SizedBox(height: isMobile ? 80 : 100),
        ),
      ],
    );
  }
}

class _CategoryTabsDelegate extends SliverPersistentHeaderDelegate {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      height: maxExtent,
      color: context.primaryBackgroundColor,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.only(left: 2, right: 2, top: 16, bottom: 8),
        child: Row(
          children: [
            _buildCategoryTab(context, 'Trending', AppIcons.trendingIcon, 0),
            _buildCategoryTab(context, 'Sports', AppIcons.sportsIcon, 1),
            _buildCategoryTab(context, 'Entertainment', AppIcons.entertainmentIcon, 2),
            _buildCategoryTab(context, 'Politics', AppIcons.politicsIcon, 3),
            _buildCategoryTab(context, 'Crypto', AppIcons.cryptoIcon, 4),
            _buildCategoryTab(context, 'Stocks', AppIcons.stocksIcon, 5),
            _buildCategoryTab(context, 'ESports', AppIcons.esportsIcon, 6),
            _buildCategoryTab(context, 'Games', AppIcons.gamesIcon, 7),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryTab(BuildContext context, String title, String icon, int index) {
    final bool isSelected = selectedIndex == index;
    
    return GestureDetector(
      onTap: () {
        selectedIndex = index;
        // Force rebuild
        if (context.mounted) {
          (context as Element).markNeedsBuild();
        }
      },
      child: Container(
        margin: const EdgeInsets.only(right: 12),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
        decoration: BoxDecoration(
          color: isSelected ? const Color.fromRGBO(16, 42, 86, 1) : const Color.fromRGBO(239, 241, 245, 1),
          borderRadius: BorderRadius.circular(16),
        ),
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: isSelected ? [
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
            ] : [
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

  @override
  double get maxExtent => 72.0;

  @override
  double get minExtent => 72.0;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) => false;
}
